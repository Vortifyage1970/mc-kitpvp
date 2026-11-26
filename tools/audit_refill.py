#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""审计补货型冷却：找出『使用侧不写 cd』或『补货在每刻车道、使用在慢拍』的 +1 bug。只读。"""
from __future__ import annotations
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
F = ROOT / "src/data/kitpvp/functions"
SET = re.compile(r"scoreboard players set @s (kitpvp\.(?:cd|cd2|cd3|halley_cd|sun_reload|\w+_cd)) (\d+)")
CALL = re.compile(r"run function (kitpvp:\S+)")
INIT_PREFIX = ("kit/", "game/", "player/", "lobby/", "map/", "load")

sett: dict[str, dict[str, list[str]]] = {}  # cd -> {kind: [files]}
fast_refill: list[tuple[str, str]] = []      # (file, target)

def kind_of(rel: str, stem: str) -> str:
    if rel.startswith(INIT_PREFIX) or rel == "load.mcfunction":
        return "init"
    if re.search(r"(refill|give|handout|auto)", stem, re.I):
        return "refill"
    return "use"

for p in F.rglob("*.mcfunction"):
    rel = p.relative_to(F).as_posix()
    k = kind_of(rel, p.stem)
    lane = "FAST" if rel.startswith("tick/kits") else ("SLOW" if rel.startswith("tick/slow") else "other")
    for ln in p.read_text(encoding="utf-8").splitlines():
        s = ln.strip()
        if s.startswith("#"):
            continue
        for m in SET.finditer(s):
            sett.setdefault(m.group(1), {}).setdefault(k, []).append(rel)
        if lane == "FAST":
            for m in CALL.finditer(s):
                t = m.group(1)
                if re.search(r"(refill|give|handout|auto)", t.rsplit("/", 1)[-1], re.I):
                    fast_refill.append((rel, t))

print("== A) 有补货侧写 cd、但【使用侧(非 refill/give/handout/auto 的技能文件)】完全不写 → 使用侧缺 cd ==")
bad = 0
for cd, d in sorted(sett.items()):
    if "refill" in d and "use" not in d:
        bad += 1
        print(f"  [!] {cd}: refill写于 {sorted(set(d['refill']))}；使用侧无写")
print("  小计:", bad)

print("\n== B) 补货函数在【每刻车道 kits_*】（先于 slow2 使用侧）→ 顺序型秒补嫌疑 ==")
for f, t in sorted(set(fast_refill)):
    print(f"  [!] {f} -> {t}")

print("\n== 参考：每个 cd 的 set 分类 ==")
for cd, d in sorted(sett.items()):
    print(f"  {cd}: init={len(d.get('init',[]))} refill={len(d.get('refill',[]))} use={len(d.get('use',[]))}")
