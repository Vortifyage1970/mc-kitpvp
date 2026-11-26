#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""把 ai-content/04-hazards-reminder.md 里的坑变成**可自动检查的不变量**。

只读 src/，不依赖第三方库。被 tools/check.py 调用；也可单独跑：
    python tools/invariants.py

每个 check_* 返回 (标题, 问题列表, 是否致命)。致命项会进 check.py 的退出码。
"""
from __future__ import annotations

import os
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "src"
DATA = SRC / "data"
FUNCS = DATA / "kitpvp" / "functions"


def _read(path: Path) -> list[str]:
    return path.read_text(encoding="utf-8").splitlines()


def _iter_mc():
    for dirpath, _d, files in os.walk(DATA):
        for name in files:
            if name.endswith(".mcfunction"):
                p = Path(dirpath, name)
                yield p, p.relative_to(ROOT).as_posix()


def _rel_func(rel: str) -> Path:
    """'kitpvp:skill/x/y' -> DATA/kitpvp/functions/skill/x/y.mcfunction"""
    return FUNCS / (rel.split(":", 1)[1] + ".mcfunction")


def _body(fn_id: str) -> str:
    p = _rel_func(fn_id)
    return p.read_text(encoding="utf-8") if p.exists() else ""


# --------------------------------------------------------------------------
# 1) 快照首行：`used > last` 的接收函数（或其 2 层内调用）必须推进同一个 last
# --------------------------------------------------------------------------
TRIG = re.compile(
    r"if score @s kitpvp\.(\w+_used) > @s kitpvp\.(\w+_last) run function (kitpvp:\S+)"
)


def check_snapshot() -> tuple[str, list[str], bool]:
    bad: list[str] = []
    for p, rel in _iter_mc():
        for n, line in enumerate(_read(p), 1):
            s = line.strip()
            if s.startswith("#"):
                continue
            m = TRIG.search(s)
            if not m:
                continue
            used, last, fn = m.group(1), m.group(2), m.group(3)
            # 触发所在函数（同文件）或接收函数（2 层内）任一推进了 last 即可
            found = f"kitpvp.{last}" in p.read_text(encoding="utf-8")
            seen, frontier = set(), [fn]
            for _depth in range(3):
                if found:
                    break
                nxt = []
                for f in frontier:
                    if f in seen:
                        continue
                    seen.add(f)
                    body = _body(f)
                    if f"kitpvp.{last}" in body:
                        found = True
                        break
                    nxt += re.findall(r"function (kitpvp:\S+)", body)
                frontier = nxt
            if not found:
                bad.append(f"{rel}:{n}  {used} > {last} 的接收函数 {fn}（2 层内）没有推进 {last}")
    return "快照首行（used>last 必须推进 last）", bad, True


# --------------------------------------------------------------------------
# 2) kit 闸门号必须与函数内部 `kit matches N` 一致（里弓箭手 29 vs 24 那类）
# --------------------------------------------------------------------------
GATE = re.compile(r"kitpvp\.kit=(\d+).*run function (kitpvp:\S+)")
INNER = re.compile(r"kitpvp\.kit matches (\d+)")


def check_kit_gate() -> tuple[str, list[str], bool]:
    bad: list[str] = []
    for p, rel in _iter_mc():
        for n, line in enumerate(_read(p), 1):
            s = line.strip()
            if s.startswith("#"):
                continue
            m = GATE.search(s)
            if not m:
                continue
            gate, fn = int(m.group(1)), m.group(2)
            body = _body(fn)
            inner = {int(x) for x in INNER.findall(body)}
            if inner and gate not in inner:
                bad.append(f"{rel}:{n}  闸门 kit={gate} 但 {fn} 内部 kit matches {sorted(inner)}")
    return "kit 闸门号与内部 kit matches 一致", bad, True


# --------------------------------------------------------------------------
# 3) 慢拍车道不得混入每刻必需的东西
# --------------------------------------------------------------------------
SLOW_RED = [
    (re.compile(r"_prev\b"), "每刻重建的 _prev 快照"),
    (re.compile(r"scoreboard players remove"), "每调用一次 -1 的计时器/递减"),
    (re.compile(r"(?:clear|kill) @e\[type=minecraft:item"), "掉落实体清理"),
    (re.compile(r"_timer\b"), "每刻递减的 _timer"),
]


def check_slow_lanes() -> tuple[str, list[str], bool]:
    bad: list[str] = []
    for lane in ("slow2", "slow4"):
        p = FUNCS / "tick" / f"{lane}.mcfunction"
        if not p.exists():
            continue
        for n, line in enumerate(_read(p), 1):
            s = line.strip()
            if not s or s.startswith("#"):
                continue
            for rx, why in SLOW_RED:
                if rx.search(s):
                    bad.append(f"tick/{lane}.mcfunction:{n}  混入{why}: {s[:70]}")
    return "慢拍车道只放幂等判定", bad, True


# --------------------------------------------------------------------------
# 4) 七处同步：kit id 在 info/list/give_kit/random 都要对得上
# --------------------------------------------------------------------------
def _kit_ids() -> dict[int, str]:
    out: dict[int, str] = {}
    kit_dir = FUNCS / "kit"
    for p in kit_dir.glob("*.mcfunction"):
        if p.stem.startswith("random"):  # 随机池不是职业
            continue
        for line in _read(p):
            m = re.search(r"scoreboard players set @s kitpvp\.kit (\d+)", line)
            if m:
                out[int(m.group(1))] = p.stem
    return out


def _check_kit_sync_impl() -> tuple[str, list[str], bool]:
    bad: list[str] = []
    ids = _kit_ids()
    # random 映射
    rnd = FUNCS / "kit" / "random.mcfunction"
    rtext = rnd.read_text(encoding="utf-8") if rnd.exists() else ""
    mapped = {int(x) for x in re.findall(r"set @s kitpvp\.kit (\d+)", rtext)}
    pool = re.search(r"#pool_size kitpvp\.game (\d+)", rtext)
    if pool and int(pool.group(1)) != len(mapped):
        bad.append(f"random: #pool_size={pool.group(1)} 但映射只有 {len(mapped)} 条")
    for kid, name in sorted(ids.items()):
        if kid not in mapped:
            bad.append(f"kit {kid}（{name}）没进 random 全池映射")
        # info
        if not (FUNCS / "kit" / "info" / f"{name}.mcfunction").exists():
            bad.append(f"kit {kid}（{name}）缺 kit/info/{name}.mcfunction")
    # give_kit
    gk = FUNCS / "util" / "give_kit.mcfunction"
    gtext = gk.read_text(encoding="utf-8") if gk.exists() else ""
    for kid, name in sorted(ids.items()):
        if not re.search(rf"kitpvp\.kit matches {kid} run function kitpvp:kit/{re.escape(name)}\b", gtext):
            bad.append(f"kit {kid}（{name}）在 give_kit 里缺失或函数名不符")
    # list 菜单
    list_text = ""
    ld = FUNCS / "kit" / "list"
    if ld.is_dir():
        for p in ld.glob("*.mcfunction"):
            list_text += p.read_text(encoding="utf-8")
    for kid, name in sorted(ids.items()):
        if f"kitpvp:kit/info/{name}" not in list_text:
            bad.append(f"kit {kid}（{name}）没有出现在 kit/list 菜单里")
    return "七处同步（kit/info/list/give_kit/random 池）", bad, True


# --------------------------------------------------------------------------
# 5) team join 的队必须先在 load 里 team add
# --------------------------------------------------------------------------
def check_teams() -> tuple[str, list[str], bool]:
    bad: list[str] = []
    load = FUNCS / "load.mcfunction"
    ltext = load.read_text(encoding="utf-8") if load.exists() else ""
    created = set(re.findall(r"^\s*team add (\S+)", ltext, re.M))
    for p, rel in _iter_mc():
        for n, line in enumerate(_read(p), 1):
            s = line.strip()
            if s.startswith("#"):
                continue
            for team in re.findall(r"team join (\S+)", s):
                if team not in created:
                    bad.append(f"{rel}:{n}  team join {team}，但 load 里没有 team add {team}")
    return "team join 的队都在 load 里创建过", sorted(set(bad)), True


# --------------------------------------------------------------------------
# 6) bossbar add 的条都要在 reset/clear 里清掉 players
# --------------------------------------------------------------------------
def check_bossbars() -> tuple[str, list[str], bool]:
    bad: list[str] = []
    load = FUNCS / "load.mcfunction"
    ltext = load.read_text(encoding="utf-8") if load.exists() else ""
    bars = re.findall(r"bossbar add (kitpvp:\S+)", ltext)
    # 只有"绑定到单个玩家"的条（出现过 `bossbar set <id> players @s`）才需要显式清理；
    # 每刻用 `players @a[...]` 全量重设的（tep_hud_*、以及任何组播 HUD）会自清，跳过。
    all_text = ""
    for p, _rel in _iter_mc():
        all_text += p.read_text(encoding="utf-8")
    per_player = {
        b for b in bars
        if re.search(rf"bossbar set {re.escape(b)} players @s", all_text)
        and not re.search(rf"bossbar set {re.escape(b)} players @a", all_text)
    }
    clear_text = ""
    for rel in ("game/reset", "util/clear_player"):
        pp = FUNCS / (rel + ".mcfunction")
        if pp.exists():
            clear_text += pp.read_text(encoding="utf-8")
    for bar in sorted(per_player):
        name = re.escape(bar)
        if not (re.search(rf"bossbar set {name} players", clear_text) or re.search(rf"bossbar remove {name}", clear_text)):
            bad.append(f"{bar} 是按玩家显示的，但 reset/clear_player 里没有清 players")
    return "按玩家显示的 bossbar 在 reset/clear 里清 players", bad, True


# --------------------------------------------------------------------------
# 7) 引用了但 load 里没建的 objective
# --------------------------------------------------------------------------
OBJ_REF = [
    re.compile(r"scoreboard players \w+ \S+ (kitpvp\.\w+)"),
    re.compile(r"if score \S+ (kitpvp\.\w+)"),
    re.compile(r"store result score \S+ (kitpvp\.\w+)"),
    re.compile(r"operation \S+ (kitpvp\.\w+)"),
]


def check_objective_refs() -> tuple[str, list[str], bool]:
    bad: list[str] = []
    load = FUNCS / "load.mcfunction"
    ltext = load.read_text(encoding="utf-8") if load.exists() else ""
    defined = set(re.findall(r"scoreboard objectives add (kitpvp\.\w+)", ltext))
    ref: dict[str, str] = {}
    for p, rel in _iter_mc():
        for n, line in enumerate(_read(p), 1):
            s = line.strip()
            if not s or s.startswith("#"):
                continue
            for rx in OBJ_REF:
                for obj in rx.findall(s):
                    ref.setdefault(obj, f"{rel}:{n}")
    for obj in sorted(ref):
        if obj not in defined:
            bad.append(f"{ref[obj]}  引用了未在 load 里建的 objective {obj}")
    return "引用的 objective 都在 load 里建过", bad, True


# --------------------------------------------------------------------------
# 8) matches 后面不能跟逗号列表
# --------------------------------------------------------------------------
def check_matches_comma() -> tuple[str, list[str], bool]:
    bad: list[str] = []
    rx = re.compile(r"matches\s+[^\s]*\d\s*,\s*\d")
    for p, rel in _iter_mc():
        for n, line in enumerate(_read(p), 1):
            s = line.strip()
            if s.startswith("#"):
                continue
            if rx.search(s):
                bad.append(f"{rel}:{n}  matches 用了逗号列表: {s[:70]}")
    return "matches 不写逗号列表", bad, True


# --------------------------------------------------------------------------
# 提示（非致命）：同一颗刷怪蛋被"职业令牌 + 魂石"共用 —— 需要 dispatch
# --------------------------------------------------------------------------
def hints_shared_eggs() -> list[str]:
    load = FUNCS / "load.mcfunction"
    ltext = load.read_text(encoding="utf-8") if load.exists() else ""
    crit = {}
    for line in ltext.splitlines():
        m = re.search(r"scoreboard objectives add (kitpvp\.\w+) minecraft\.used:(minecraft\.\w+_spawn_egg)", line)
        if m:
            crit.setdefault(m.group(2), []).append(m.group(1))
    out = []
    for egg, objs in sorted(crit.items()):
        if len(objs) > 1:
            soul = [o for o in objs if o.startswith("kitpvp.soul_") or o.startswith("kitpvp.")]
            tagged = sorted(objs)
            out.append(f"{egg} 被 {len(objs)} 个 objective 共用: {', '.join(tagged)} —— 确认走 dispatch 按 tag/名字分流")
    return out


# --------------------------------------------------------------------------
# 9) 1.12 旧物品 id（1.13 拍平后改名/不存在）会让整份函数静默不加载
# --------------------------------------------------------------------------
LEGACY_ITEMS = {
    "minecraft:firework_charge": "minecraft:firework_star",
    "minecraft:red_flower": "minecraft:poppy（或 blue_orchid / allium …）",
    "minecraft:yellow_flower": "minecraft:dandelion",
    "minecraft:wool": "minecraft:white_wool",
    "minecraft:carpet": "minecraft:white_carpet",
    "minecraft:dye": "minecraft:ink_sac / bone_meal / …（按颜色）",
    "minecraft:cooked_fish": "minecraft:cooked_cod",
    "minecraft:fish": "minecraft:cod / salmon",
    "minecraft:armor_stand_spawn_egg": "不存在，换别的蛋",
    "minecraft:giant_spawn_egg": "不存在",
    "minecraft:ender_dragon_spawn_egg": "不存在",
}


def check_legacy_items() -> tuple[str, list[str], bool]:
    bad: list[str] = []
    pats = [(old, new, re.compile(re.escape(old) + r"(?!\w)")) for old, new in LEGACY_ITEMS.items()]
    for p, rel in _iter_mc():
        for n, line in enumerate(_read(p), 1):
            s = line.strip()
            if s.startswith("#"):
                continue
            for old, new, rx in pats:
                if rx.search(s):
                    bad.append(f"{rel}:{n}  用了 1.12 旧物品 id {old} → 应写 {new}")
    return "没有 1.12 旧物品 id（会让整份函数不加载）", bad, True


ALL_FATAL = [
    check_snapshot,
    check_kit_gate,
    check_slow_lanes,
    _check_kit_sync_impl,
    check_teams,
    check_bossbars,
    check_objective_refs,
    check_matches_comma,
    check_legacy_items,
]


def run() -> list[tuple[str, list[str], bool]]:
    return [fn() for fn in ALL_FATAL]


if __name__ == "__main__":
    total = 0
    for title, problems, fatal in run():
        if problems:
            total += len(problems)
            print(f"[FAIL] {title} ({len(problems)})")
            for x in problems:
                print("   " + x)
        else:
            print(f"[OK] {title}")
    hints = hints_shared_eggs()
    if hints:
        print(f"\n[提示] 共用刷怪蛋 {len(hints)} 组（非致命，人工确认已分流）:")
        for h in hints:
            print("   " + h)
    print("\n不变量问题总数:", total)
    raise SystemExit(1 if total else 0)
