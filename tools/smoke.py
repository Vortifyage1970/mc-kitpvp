#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""行为回归 smoke：把 src 同步到本地测试服，跑一遍 load 后所有关键入口 + 每个职业选择一次，
断言"没有加载失败、没有运行时 Unknown function、每个职业函数都能执行"。

用法：
    python tools/smoke.py            # 自动起/复用测试服（默认 D:\mc-test-server）
    python tools/smoke.py --keep     # 跑完不关服

别人的机器上用环境变量指路径：
    set MC_TEST_SERVER=D:\my-test-server
    set MC_JAVA=C:\path\to\java.exe

退出码 0 = 全过。
"""
from __future__ import annotations

import argparse
import os
import shutil
import socket
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "src"

# 机器相关的路径全部可用环境变量覆盖，方便别人在自己的机器上跑：
#   MC_TEST_SERVER   一个空的 1.20.1 原版服务端目录（默认 D:\mc-test-server）
#   MC_JAVA          启动服务端用的 java（默认指向官方启动器自带的那份）
SERVER_DIR = Path(os.environ.get("MC_TEST_SERVER", r"D:\mc-test-server"))
DEST = SERVER_DIR / "world" / "datapacks" / "kitpvp"
JAVA = Path(os.environ.get(
    "MC_JAVA",
    r"C:\Users\tensa\AppData\Roaming\.minecraft\runtime\java-runtime-delta\bin\java.exe",
))
LOG = SERVER_DIR / "logs" / "latest.log"

sys.path.insert(0, str(Path(__file__).resolve().parent))
import rcon  # noqa: E402

ERROR_WORDS = ("Unknown function", "Whilst parsing", "Failed to load", "An unexpected error", "error executing")


def rcon_up() -> bool:
    try:
        with socket.create_connection(("127.0.0.1", 25578), timeout=1):
            return True
    except OSError:
        return False


def sync() -> None:
    if DEST.exists():
        for child in DEST.iterdir():
            if child.is_dir():
                shutil.rmtree(child, ignore_errors=True)
            else:
                child.unlink(missing_ok=True)
    shutil.copytree(SRC / "data", DEST / "data")
    shutil.copy2(SRC / "pack.mcmeta", DEST / "pack.mcmeta")


def start_server() -> subprocess.Popen | None:
    if rcon_up():
        print("[smoke] 复用已在运行的测试服")
        return None
    print("[smoke] 启动测试服 ...")
    logf = open(SERVER_DIR / "smoke_run.log", "w", encoding="utf-8")
    proc = subprocess.Popen(
        [str(JAVA), "-Xms1G", "-Xmx2G", "-jar", "server.jar", "nogui"],
        cwd=str(SERVER_DIR), stdout=logf, stderr=subprocess.STDOUT,
    )
    for _ in range(60):
        if rcon_up():
            time.sleep(1)
            print("[smoke] 测试服就绪")
            return proc
        time.sleep(1)
    raise RuntimeError("测试服 60 秒内没起来")


def log_since(offset: int) -> str:
    if not LOG.exists():
        return ""
    with open(LOG, "r", encoding="utf-8", errors="replace") as fh:
        fh.seek(offset)
        return fh.read()


def kits() -> list[tuple[int, str]]:
    out = []
    for p in (SRC / "data" / "kitpvp" / "functions" / "kit").glob("*.mcfunction"):
        if p.stem.startswith("random"):
            continue
        for line in p.read_text(encoding="utf-8").splitlines():
            if "scoreboard players set @s kitpvp.kit " in line:
                out.append((int(line.strip().rsplit(" ", 1)[1]), p.stem))
                break
    return sorted(out)


def check_responses(label: str, results: list[str], problems: list[str]) -> None:
    for r in results:
        low = r
        if any(w in low for w in ERROR_WORDS):
            problems.append(f"{label}: {r.strip()[:160]}")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--keep", action="store_true")
    args = ap.parse_args()

    problems: list[str] = []
    proc = None
    try:
        sync()
        proc = start_server()

        off = LOG.stat().st_size if LOG.exists() else 0
        rcon.run(["reload"])
        time.sleep(2)
        newlog = log_since(off)
        for line in newlog.splitlines():
            if "Failed to load function" in line:
                problems.append("加载失败: " + line.strip()[:180])

        # 1) 关键入口
        entries = [
            "function kitpvp:game/reset",
            "function kitpvp:tick",
            "function kitpvp:tick/slow2",
            "function kitpvp:tick/slow4",
            "function kitpvp:skill/soul/give",
        ]
        res = rcon.run(entries)
        check_responses("入口", res, problems)
        for r in res:
            if "Executed" not in r and "no entity" not in r.lower():
                # reset/give 可能返回无实体，但不应报错；只在含 error 词时记
                pass

        # 2) 每个职业选一次（用带装备的僵尸当靶，避免真人）
        ks = kits()
        print(f"[smoke] 逐职业选一次，共 {len(ks)} 个 ...")
        for kid, name in ks:
            rcon.run(["kill @e[tag=smoke_dummy]"])
            rcon.run(['summon minecraft:zombie 0 -60 0 {Tags:["smoke_dummy"],NoAI:1b,Silent:1b}'])
            res = rcon.run([f"execute as @e[tag=smoke_dummy,limit=1] run function kitpvp:kit/{name}"])
            check_responses(f"kit {kid} {name}", res, problems)
            if not any("Executed" in x for x in res):
                problems.append(f"kit {kid} {name}: 没有执行（函数可能不加载）")
        rcon.run(["kill @e[tag=smoke_dummy]"])
    finally:
        if proc is not None and not args.keep:
            try:
                rcon.run(["stop"])
            except Exception:  # noqa: BLE001
                pass
            time.sleep(3)

    print("\n===== smoke 结果 =====")
    if problems:
        print(f"[FAIL] {len(problems)} 个问题:")
        for p in problems:
            print("  " + p)
        return 1
    print(f"[OK] 全部通过（入口 + {len(kits())} 个职业选择，无加载/运行时错误）")
    return 0


if __name__ == "__main__":
    sys.exit(main())
