#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""三星卡的蓄力收益除以 10：0.5/1/1.5/2 点 → 0.05/0.1/0.15/0.2 点（150/300/450/600 → 15/30/45/60 格）。"""
from pathlib import Path

F = Path(__file__).resolve().parent.parent / "src/data/kitpvp/functions/skill/li_ench"

FILL = [("150", "15"), ("300", "30"), ("450", "45"), ("600", "60")]
TEXT = [
    ("钃勫姏 +0.5 鐐?", "钃勫姏 +0.05 鐐?"),
    ("钃勔 +0.5", "钃勔 +0.05"),
]
REAL_TEXT = [
    ("蓄力 +1.5 点", "蓄力 +0.15 点"),
    ("蓄力 +0.5 点", "蓄力 +0.05 点"),
    ("蓄力 +1 点", "蓄力 +0.1 点"),
    ("蓄力 +2 点", "蓄力 +0.2 点"),
]
REAL_COMMENT = ("# 蓄力档：0.5 / 1 / 1.5 / 2 点，各 25%", "# 蓄力档：0.05 / 0.1 / 0.15 / 0.2 点，各 25%（原值 ÷10）")


def main() -> None:
    p = F / "pull_charge.mcfunction"
    t = p.read_text(encoding="utf-8")
    # 先改文案（长的先换，避免 "蓄力 +1 点" 吃掉 "蓄力 +1.5 点"）
    for old in ("蓄力 +1.5 点", "蓄力 +0.5 点", "蓄力 +1 点", "蓄力 +2 点"):
        new = dict(REAL_TEXT)[old]
        t = t.replace(old, new)
    t = t.replace(REAL_COMMENT[0], REAL_COMMENT[1])
    # 再改数值：四档 fill
    for old, new in ((" 600\n", " 60\n"), (" 450\n", " 45\n"), (" 300\n", " 30\n"), (" 150\n", " 15\n")):
        t = t.replace(old, new)
    p.write_text(t, encoding="utf-8", newline="\n")
    print("patched", p.name)


if __name__ == "__main__":
    main()
