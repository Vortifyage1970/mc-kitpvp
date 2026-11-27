#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""里·附魔师：蛋用完补回来；剑不在主手时先升级、附魔排队到拿剑再补。"""
from pathlib import Path

F = Path(__file__).resolve().parent.parent / "src/data/kitpvp/functions"
LI = F / "skill/li_ench"
EC = F / "skill/enchanter"

SINGLE = (
    'minecraft:camel_spawn_egg{KitLiSingle:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:1s}],'
    'display:{Name:\'{"text":"单抽","color":"light_purple","italic":false}\','
    'Lore:[\'{"text":"右键：受 3 点伤害抽一次（冷却 2 秒）","color":"gray","italic":false}\']}}'
)
TEN = (
    'minecraft:panda_spawn_egg{KitLiTen:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:1s}],'
    'display:{Name:\'{"text":"十连","color":"gold","italic":false}\','
    'Lore:[\'{"text":"右键：受 20 点伤害连抽十次（冷却 15 秒）","color":"gray","italic":false}\']}}'
)


def main() -> None:
    # 1) 用完把蛋补回来
    for name, item in (("single_use.mcfunction", SINGLE), ("ten_use.mcfunction", TEN)):
        p = LI / name
        t = p.read_text(encoding="utf-8")
        if "give @s" not in t:
            t = t.rstrip("\n") + "\ngive @s %s 1\n" % item
        p.write_text(t, encoding="utf-8", newline="\n")

    # 2) 剑不在主手时：升级 + 排队，不再卡住
    (EC / "sw_queue.mcfunction").write_text(
        "# 剑不在主手：等级照升，掷骰排队到拿剑时补\n"
        "tag @s remove kitpvp.ench_wait\n"
        "scoreboard players remove @s kitpvp.ench_sw 3\n"
        "scoreboard players add @s kitpvp.ench_sword 1\n"
        "scoreboard players add @s kitpvp.ench_pending 1\n"
        "effect give @s minecraft:glowing 5 0 true\n"
        "playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.4 1.4\n"
        "function kitpvp:skill/enchanter/name_refresh\n"
        'title @s actionbar [{"text":"剑升到 ","color":"green"},{"score":{"name":"@s","objective":"kitpvp.ench_sword"},"color":"green"},{"text":" 级（拿剑时补附魔）","color":"gray"}]\n',
        encoding="utf-8", newline="\n")

    (EC / "sw_pending_one.mcfunction").write_text(
        "# 补一次排队的剑附魔\n"
        "scoreboard players remove @s kitpvp.ench_pending 1\n"
        "function kitpvp:skill/enchanter/roll_sword\n",
        encoding="utf-8", newline="\n")

    (EC / "sw_pending_apply.mcfunction").write_text(
        "# 每刻：剑一到主手就把排队的附魔补上（每刻补一次）\n"
        'execute if score @s kitpvp.ench_pending matches 1.. if data entity @s SelectedItem{id:"minecraft:golden_sword"} run function kitpvp:skill/enchanter/sw_pending_one\n',
        encoding="utf-8", newline="\n")

    (EC / "up_sword.mcfunction").write_text(
        "# 剑满 3 点：在主手就当场掷骰；不在主手就升级 + 排队\n"
        'execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} unless score @s kitpvp.ench_sword matches ..10 run scoreboard players set @s kitpvp.ench_sw 3\n'
        'execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} if score @s kitpvp.ench_sword matches ..10 run function kitpvp:skill/enchanter/sw_up\n'
        'execute unless data entity @s SelectedItem{id:"minecraft:golden_sword"} if score @s kitpvp.ench_sword matches ..10 run function kitpvp:skill/enchanter/sw_queue\n',
        encoding="utf-8", newline="\n")

    # 3) 两个职业每刻都补一次
    for name in ("skill/enchanter/tick.mcfunction", "skill/li_ench/player_tick.mcfunction"):
        p = F / name
        t = p.read_text(encoding="utf-8")
        if "sw_pending_apply" not in t:
            t = t.rstrip("\n") + "\nfunction kitpvp:skill/enchanter/sw_pending_apply\n"
        p.write_text(t, encoding="utf-8", newline="\n")

    # 4) load 加 objective
    p = F / "load.mcfunction"
    t = p.read_text(encoding="utf-8")
    if "kitpvp.ench_pending" not in t:
        t = t.replace(
            "scoreboard objectives add kitpvp.li_pity dummy",
            'scoreboard objectives add kitpvp.ench_pending dummy "排队的剑附魔次数（拿剑时补）"\n'
            "scoreboard objectives add kitpvp.li_pity dummy", 1)
    p.write_text(t, encoding="utf-8", newline="\n")

    # 5) 选职时清零
    for name in ("kit/tainted_enchanter.mcfunction", "kit/enchanter.mcfunction"):
        p = F / name
        t = p.read_text(encoding="utf-8")
        if "ench_pending" not in t:
            t = t.replace(
                "scoreboard players set @s kitpvp.ench_sw 0",
                "scoreboard players set @s kitpvp.ench_sw 0\n"
                "scoreboard players set @s kitpvp.ench_pending 0", 1)
        p.write_text(t, encoding="utf-8", newline="\n")

    print("patched")


if __name__ == "__main__":
    main()
