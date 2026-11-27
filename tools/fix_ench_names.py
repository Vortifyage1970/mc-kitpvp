#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""修附魔等级 bossbar 名称：重建 name_refresh（11 级那行 JSON 少了引号），
并让 HUD 每秒自检一次名字，避免槽位换人后显示上一位的等级。
顺带把里·附魔师的食物换回牛排。
"""
from pathlib import Path

F = Path(__file__).resolve().parent.parent / "src/data/kitpvp/functions"

KITS = (
    ("li", F / "skill/li_ench/name_refresh.mcfunction", "kitpvp:li_s%d", "kitpvp:li_a%d"),
    ("ench", F / "skill/enchanter/name_refresh.mcfunction", "kitpvp:ench_s%d", "kitpvp:ench_a%d"),
)


def title(kind: str, level: int) -> str:
    name = "剑" if kind == "s" else "护甲"
    tail = "（满）" if level >= 11 else ""
    return '{"text":"%s · 附魔等级 %d%s"}' % (name, level, tail)


def build() -> None:
    for _tag, path, s_bar, a_bar in KITS:
        lines = ["# bossbar 标题：8 个槽 × 12 级 × 两栏，等级变了就重设一次名字"]
        for slot in range(1, 9):
            for level in range(12):
                lines.append(
                    "execute if score @s kitpvp.ench_slot matches %d if score @s kitpvp.ench_sword matches %d "
                    "run bossbar set %s name %s" % (slot, level, s_bar % slot, title("s", level)))
                lines.append(
                    "execute if score @s kitpvp.ench_slot matches %d if score @s kitpvp.ench_armor matches %d "
                    "run bossbar set %s name %s" % (slot, level, a_bar % slot, title("a", level)))
        path.write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")
        print("rebuilt", path.name, len(lines))


def patch_hud() -> None:
    for tag, rel in (("li", "skill/li_ench/hud_show.mcfunction"),
                     ("ench", "skill/enchanter/hud_show.mcfunction")):
        p = F / rel
        t = p.read_text(encoding="utf-8")
        if "ench_hud_t" in t:
            continue
        t = t.rstrip("\n") + (
            "\n# 每秒核对一次标题，槽位换人后不会显示上一位的等级\n"
            "scoreboard players add @s kitpvp.ench_hud_t 1\n"
            "execute if score @s kitpvp.ench_hud_t matches 20.. run scoreboard players set @s kitpvp.ench_hud_t 0\n"
            "execute if score @s kitpvp.ench_hud_t matches 0 run function kitpvp:skill/%s/name_refresh\n"
            % ("li_ench" if tag == "li" else "enchanter"))
        p.write_text(t, encoding="utf-8", newline="\n")
        print("hud patched", rel)


def patch_load() -> None:
    p = F / "load.mcfunction"
    t = p.read_text(encoding="utf-8")
    if "kitpvp.ench_hud_t" not in t:
        t = t.replace(
            "scoreboard objectives add kitpvp.ench_pending dummy",
            'scoreboard objectives add kitpvp.ench_hud_t dummy "HUD 标题自检计时（20 刻一次）"\n'
            "scoreboard objectives add kitpvp.ench_pending dummy", 1)
        p.write_text(t, encoding="utf-8", newline="\n")
        print("load patched")


def patch_food() -> None:
    p = F / "kit/tainted_enchanter.mcfunction"
    t = p.read_text(encoding="utf-8")
    t = t.replace("hotbar.1 with minecraft:golden_carrot 32", "hotbar.1 with minecraft:cooked_beef 32")
    p.write_text(t, encoding="utf-8", newline="\n")
    card = F / "kit/info/tainted_enchanter.mcfunction"
    c = card.read_text(encoding="utf-8")
    c = c.replace('"text":"金胡萝卜","color":"white"', '"text":"熟牛肉","color":"white"')
    card.write_text(c, encoding="utf-8", newline="\n")
    print("food -> steak 32")


def main() -> None:
    build()
    patch_hud()
    patch_load()
    patch_food()


if __name__ == "__main__":
    main()
