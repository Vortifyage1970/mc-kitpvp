#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""坐杀博徒：把稀有档的概率往上抬一点。

128 格重新切：
  普通 0..82   = 83 格 = 64.8%
  稀有 83..118 = 36 格 = 28.1%
  传说 119..127 = 9 格 =  7.0%
原来是 0..88(69.5%) / 89..120(25.0%) / 121..127(5.5%)。
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
P = ROOT / "src/data/kitpvp/functions/skill/li_ench/draw.mcfunction"

BANDS = [
    ("matches 0..88 if", "matches 0..82 if"),
    ("matches 89..120 if", "matches 83..118 if"),
    ("matches 121..127 if", "matches 119..127 if"),
]


def main() -> None:
    text = P.read_text(encoding="utf-8")
    for old, new in BANDS:
        if old not in text and new in text:
            continue
        n = text.count(old)
        text = text.replace(old, new)
        print("%-24s -> %-24s (%d lines)" % (old, new, n))
    P.write_text(text, encoding="utf-8", newline="\n")


if __name__ == "__main__":
    main()
