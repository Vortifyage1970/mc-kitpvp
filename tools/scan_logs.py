#!/usr/bin/env python3
"""找出"function 静默不加载"的真实原因：读世界日志里的加载期报错。

用法：
    python tools/scan_logs.py [日志目录] [最近文件数]

聊天和控制台都不会提示这类错误。日志里的 `Failed to load function kitpvp:xxx`
后面紧跟一行 `Whilst parsing command on line N: 原因`，N 是**文件真实行号**（注释计入），
本脚本会把那一行的源码一并打出来。

静态检查（模板引用 / 单实体参数）已并入 `tools/check.py`，这里只管读日志。

只读，无依赖。
"""
from __future__ import annotations

import gzip
import re
import sys
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "src"
DEFAULT_LOGS = Path(
    r"D:\Minecraft\.minecraft\versions\1.20.1-Forge_47.4.4\logs"
)

FAIL = re.compile(r"Failed to load function (kitpvp:[A-Za-z0-9_/]+)")
PARSE = re.compile(r"Whilst parsing command on line (\d+):\s*(.*?)\s*at position")
STAMP = re.compile(r"^\[([^\]]+)\]")


def read_lines(path: Path) -> list[str]:
    if path.suffix == ".gz":
        with gzip.open(path, "rt", encoding="utf-8", errors="replace") as fh:
            return fh.read().splitlines()
    return path.read_text(encoding="utf-8", errors="replace").splitlines()


def func_path(func: str) -> Path:
    rel = func.split(":", 1)[1]
    return SRC / "data" / "kitpvp" / "functions" / (rel + ".mcfunction")


def scan_logs(logs: Path, keep: int) -> list[str]:
    files = sorted(
        (p for p in logs.glob("*.log*") if p.stat().st_size > 0),
        key=lambda p: p.stat().st_mtime,
    )[-keep:]
    out: list[str] = []
    found = 0
    for path in files:
        lines = read_lines(path)
        for i, line in enumerate(lines):
            m = FAIL.search(line)
            if not m:
                continue
            func = m.group(1)
            stamp = STAMP.match(line)
            reason = lineno = ""
            for probe in lines[i + 1 : i + 5]:
                pm = PARSE.search(probe)
                if pm:
                    lineno, reason = pm.group(1), pm.group(2)
                    break
            found += 1
            out.append("")
            out.append(f"[{stamp.group(1) if stamp else '?'}]  {path.name}")
            out.append(f"  文件  {func}")
            if lineno:
                out.append(f"  行号  line {lineno}（文件真实行号）")
            out.append(f"  原因  {reason}")
            src = func_path(func)
            if src.exists() and lineno:
                rows = src.read_text(encoding="utf-8").splitlines()
                idx = int(lineno) - 1
                if 0 <= idx < len(rows):
                    out.append(f"  源码  {src.relative_to(ROOT).as_posix()}:{lineno}")
                    out.append(f"        | {rows[idx]}")
    out.insert(0, f"日志目录：{logs}")
    out.insert(1, f"扫描最近 {len(files)} 个非空日志，命中 {found} 条 kitpvp 加载失败")
    out.insert(2, "（源码行取自当前文件；旧日志可能对应已经改过的版本）")
    return out


def main() -> int:
    logs = Path(sys.argv[1]) if len(sys.argv) > 1 else DEFAULT_LOGS
    keep = int(sys.argv[2]) if len(sys.argv) > 2 else 6

    if not logs.is_dir():
        print(f"日志目录不存在：{logs}")
        return 0

    for line in scan_logs(logs, keep):
        print(line)
    print("\n（静态检查请跑 python tools/check.py）")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
