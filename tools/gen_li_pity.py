#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""里·附魔师：
1) 三星蓄力回到原值 1/10（10/20/30/40 → 15/30/45/60 格）；
2) 新增第三条 bossbar「已连抽 N 抽」，抽出大奖时归零。
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent / "src/data/kitpvp/functions"
LI = ROOT / "skill/li_ench"
FILL = {0: 15, 1: 30, 2: 45, 3: 60}
TEXT = {0: "+0.05 点", 1: "+0.1 点", 2: "+0.15 点", 3: "+0.2 点"}
MAXP = 90


def charge() -> None:
    p = LI / "pull_charge.mcfunction"
    out = []
    for line in p.read_text(encoding="utf-8").splitlines():
        m = re.search(r"#li_x kitpvp\.game matches (\d) run scoreboard players add @s kitpvp\.(ench_sw_fill|ench_ap_fill) \d+", line)
        if m:
            t, obj = int(m.group(1)), m.group(2)
            line = "execute if score #li_x kitpvp.game matches %d run scoreboard players add @s kitpvp.%s %d" % (t, obj, FILL[t])
        m = re.search(r"#li_x kitpvp\.game matches (\d) run title @s actionbar", line)
        if m:
            t = int(m.group(1))
            line = ('execute if score #li_x kitpvp.game matches %d run title @s actionbar '
                    '[{"text":"◆ 蓄力 %s","color":"light_purple"},{"text":"（剑与甲）","color":"gray"}]' % (t, TEXT[t]))
        line = line.replace("原值 ÷15", "原值 ÷10").replace(
            "0.033 / 0.067 / 0.1 / 0.133 点", "0.05 / 0.1 / 0.15 / 0.2 点")
        out.append(line)
    p.write_text("\n".join(out) + "\n", encoding="utf-8", newline="\n")
    print("charge 1/10")


def bars() -> None:
    p = ROOT / "load.mcfunction"
    t = p.read_text(encoding="utf-8").rstrip("\n")
    if "kitpvp:li_p1" not in t:
        add = []
        for i in range(1, 9):
            add.append('bossbar add kitpvp:li_p%d {"text":"已连抽 0 抽","color":"red"}' % i)
            add.append("bossbar set kitpvp:li_p%d style progress" % i)
            add.append("bossbar set kitpvp:li_p%d max %d" % (i, MAXP))
            add.append("bossbar set kitpvp:li_p%d value 0" % i)
        t += "\n# 里·附魔师：第三条「已连抽 N 抽」，抽出大奖归零\n" + "\n".join(add)
    if "#li_pity_max" not in t:
        t += "\nscoreboard players set #li_pity_max kitpvp.game %d\n" % MAXP
    p.write_text(t + "\n", encoding="utf-8", newline="\n")
    print("load bars")


def pity_names() -> None:
    for slot in range(1, 9):
        lines = ["# 槽 %d：保底计数标题（0~%d 抽）" % (slot, MAXP)]
        for n in range(0, MAXP + 1):
            lines.append('execute if score @s kitpvp.ench_slot matches %d if score @s kitpvp.li_pity matches %d '
                         'run bossbar set kitpvp:li_p%d name {"text":"已连抽 %d 抽","color":"red"}'
                         % (slot, n, slot, n))
        (LI / ("pity_name_%d.mcfunction" % slot)).write_text("\n".join(lines) + "\n", encoding="utf-8", newline="\n")
    disp = ["# 按槽位刷新「已连抽 N 抽」的标题"]
    for slot in range(1, 9):
        disp.append("execute if score @s kitpvp.ench_slot matches %d run function kitpvp:skill/li_ench/pity_name_%d" % (slot, slot))
    (LI / "pity_name.mcfunction").write_text("\n".join(disp) + "\n", encoding="utf-8", newline="\n")
    print("pity names")


def hud_show() -> None:
    p = LI / "hud_show.mcfunction"
    t = p.read_text(encoding="utf-8")
    if "li_p1" not in t:
        add = []
        for slot in range(1, 9):
            add.append("execute if score @s kitpvp.ench_slot matches %d run bossbar set kitpvp:li_p%d players @s" % (slot, slot))
            add.append("execute if score @s kitpvp.ench_slot matches %d run execute store result bossbar kitpvp:li_p%d value run scoreboard players get @s kitpvp.li_pity" % (slot, slot))
        t = t.replace("# 每秒核对一次标题", "\n".join(add) + "\n# 每秒核对一次标题", 1)
        t = t.replace("execute if score @s kitpvp.ench_hud_t matches 0 run function kitpvp:skill/li_ench/name_refresh",
                      "execute if score @s kitpvp.ench_hud_t matches 0 run function kitpvp:skill/li_ench/name_refresh\n"
                      "execute if score @s kitpvp.ench_hud_t matches 0 run function kitpvp:skill/li_ench/pity_name", 1)
        p.write_text(t, encoding="utf-8", newline="\n")
        print("hud_show")


def hud_clear() -> None:
    p = LI / "hud.mcfunction"
    lines = p.read_text(encoding="utf-8").splitlines()
    if any("li_p1" in l for l in lines):
        return
    add = []
    for slot in range(1, 9):
        add.append("execute unless entity @a[scores={kitpvp.kit=99,kitpvp.ench_slot=%d},tag=!kitpvp.spectator] run bossbar set kitpvp:li_p%d players" % (slot, slot))
    idx = max(i for i, l in enumerate(lines) if "hud_show" in l)
    p.write_text("\n".join(lines[:idx] + add + lines[idx:]) + "\n", encoding="utf-8", newline="\n")
    print("hud clear")


def resets() -> None:
    for rel, sel in (("game/reset.mcfunction", "@a"), ("util/clear_player.mcfunction", "@s")):
        p = ROOT / rel
        t = p.read_text(encoding="utf-8").rstrip("\n")
        if "kitpvp:li_p1" in t:
            continue
        add = ["# 里·附魔师：收回「已连抽」条"]
        add += ["bossbar set kitpvp:li_p%d players" % i for i in range(1, 9)]
        add += ["bossbar set kitpvp:li_p%d value 0" % i for i in range(1, 9)]
        p.write_text(t + "\n" + "\n".join(add) + "\n", encoding="utf-8", newline="\n")
        print("reset", rel)


def call_pity() -> None:
    p = LI / "pull.mcfunction"
    t = p.read_text(encoding="utf-8").rstrip("\n")
    if "pity_name" not in t:
        t += "\n# 抽完立刻刷新「已连抽 N 抽」\nfunction kitpvp:skill/li_ench/pity_name"
    p.write_text(t + "\n", encoding="utf-8", newline="\n")

    k = ROOT / "kit/tainted_enchanter.mcfunction"
    kt = k.read_text(encoding="utf-8")
    if "pity_name" not in kt:
        kt = kt.replace("function kitpvp:skill/li_ench/assign_slot",
                        "function kitpvp:skill/li_ench/assign_slot\nfunction kitpvp:skill/li_ench/pity_name", 1)
        k.write_text(kt, encoding="utf-8", newline="\n")
    print("pity calls")


def main() -> None:
    charge()
    bars()
    pity_names()
    hud_show()
    hud_clear()
    resets()
    call_pity()


if __name__ == "__main__":
    main()
