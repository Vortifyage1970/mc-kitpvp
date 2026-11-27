#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""十连冷却 15 秒 -> 5 秒（300 刻 -> 100 刻）。"""
from pathlib import Path

F = Path(__file__).resolve().parent.parent / "src/data/kitpvp/functions"


def main() -> None:
    p = F / "skill/li_ench/ten_draw.mcfunction"
    t = p.read_text(encoding="utf-8")
    t = t.replace("kitpvp.li_ten_cd 300", "kitpvp.li_ten_cd 100")
    t = t.replace("matches 300 run", "matches 100 run")
    p.write_text(t, encoding="utf-8", newline="\n")
    print("ten_draw ok:", "matches 100 run" in t, "kitpvp.li_ten_cd 100" in t)

    p = F / "load.mcfunction"
    t = p.read_text(encoding="utf-8")
    t = t.replace("十连冷却刻数（300 = 15 秒）", "十连冷却刻数（100 = 5 秒）")
    p.write_text(t, encoding="utf-8", newline="\n")

    for rel in ("kit/tainted_enchanter.mcfunction",
                "skill/li_ench/ten_use.mcfunction",
                "kit/info/tainted_enchanter.mcfunction"):
        p = F / rel
        t = p.read_text(encoding="utf-8")
        t = t.replace("受 20 点伤害连抽十次（冷却 15 秒）", "受 20 点伤害连抽十次（冷却 5 秒）")
        t = t.replace("（冷却 15 秒）", "（冷却 5 秒）")
        t = t.replace("冷却 15 秒", "冷却 5 秒")
        p.write_text(t, encoding="utf-8", newline="\n")

    p = Path(__file__).resolve().parent / "gen_li_redraw.py"
    t = p.read_text(encoding="utf-8")
    t = t.replace("kitpvp.li_ten_cd 300", "kitpvp.li_ten_cd 100")
    t = t.replace("matches 300 run", "matches 100 run")
    t = t.replace("冷却 15 秒", "冷却 5 秒")
    p.write_text(t, encoding="utf-8", newline="\n")
    print("done")


if __name__ == "__main__":
    main()
