#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""里·附魔师：修卡片与开局初始化。

1. 开局自动开领域：`ench_domain_used` 是全局 used 计数，跨局不清；选职业时把
   `last` 清成 0，于是下一次 tick 就判定 used > last，白送一个领域。
   改成选职业时把 last 同步成 used（快照），开局不再误触。
2. 开局条上有旧进度：选职业后直接跑一次 hud_show，按 0 重算并挂回自己那两条。
3. c12/c22 忘了写 ench_tmp 时长，攻击力修饰符永不摘除 —— 补 240 / 400 刻。
4. c13/c24 只有播报没有效果 —— 用 resistance II(40%) / IV(80%) 近似「全套保护 +2/+5」。
5. c20 只加护甲一级，剑没加 —— 补 ench_sw +3。
6. c21 赌徒之蛋只播报、不给蛋 —— 补 give 海龟蛋（objective 统计的就是 turtle_spawn_egg）。
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FUN = ROOT / "src/data/kitpvp/functions"
LI = FUN / "skill/li_ench"


def patch_kit() -> None:
    p = FUN / "kit/tainted_enchanter.mcfunction"
    text = p.read_text(encoding="utf-8")
    old = ("scoreboard players set @s kitpvp.ench_domain_last 0\n"
           "scoreboard players set @s kitpvp.ench_egg_last 0\n")
    new = ("scoreboard players add @s kitpvp.ench_domain_used 0\n"
           "scoreboard players operation @s kitpvp.ench_domain_last = @s kitpvp.ench_domain_used\n"
           "scoreboard players add @s kitpvp.ench_egg_used 0\n"
           "scoreboard players operation @s kitpvp.ench_egg_last = @s kitpvp.ench_egg_used\n")
    assert old in text, "kit snapshot block not found"
    text = text.replace(old, new, 1)
    old2 = "function kitpvp:skill/li_ench/name_refresh\n"
    new2 = ("function kitpvp:skill/li_ench/name_refresh\n"
            "function kitpvp:skill/li_ench/hud_show\n")
    assert old2 in text
    text = text.replace(old2, new2, 1)
    p.write_text(text, encoding="utf-8", newline="\n")
    print("kit patched")


def patch_tmp_duration(name: str, ticks: int) -> None:
    p = LI / "card" / name
    lines = p.read_text(encoding="utf-8").splitlines()
    out = []
    for line in lines:
        out.append(line)
        if line.startswith("scoreboard players set @s kitpvp.ench_tmp_kind"):
            pass
    text = p.read_text(encoding="utf-8")
    anchor = "scoreboard players set @s kitpvp.ench_tmp_kind 3"
    assert anchor in text
    if "kitpvp.ench_tmp %d" % ticks not in text:
        text = text.replace(
            anchor,
            "scoreboard players set @s kitpvp.ench_tmp %d\n%s" % (ticks, anchor),
            1,
        )
    p.write_text(text, encoding="utf-8", newline="\n")
    print("tmp duration", name, ticks)


def patch_prot(name: str, seconds: int, amplifier: int) -> None:
    p = LI / "card" / name
    text = p.read_text(encoding="utf-8")
    anchor = 'title @s actionbar'
    add = ("# 原版没有「护甲保护等级」这种临时加成，这里用抗性近似：\n"
           "# amplifier %d = 减伤 %d%%，时长与卡面一致\n"
           "effect give @s minecraft:resistance %d %d true\n"
           % (amplifier, (amplifier + 1) * 20, seconds, amplifier))
    if "minecraft:resistance" in text:
        return
    idx = text.index(anchor)
    text = text[:idx] + add + text[idx:]
    p.write_text(text, encoding="utf-8", newline="\n")
    print("prot", name)


def patch_level() -> None:
    p = LI / "card/c20_level.mcfunction"
    text = p.read_text(encoding="utf-8")
    if "kitpvp.ench_sw 3" in text:
        return
    anchor = "scoreboard players add @s kitpvp.ench_ap 3"
    text = text.replace(anchor, "scoreboard players add @s kitpvp.ench_sw 3\n" + anchor, 1)
    p.write_text(text, encoding="utf-8", newline="\n")
    print("level card: sword +1 level too")


def patch_egg() -> None:
    p = LI / "card/c21_egg.mcfunction"
    text = p.read_text(encoding="utf-8")
    if "turtle_spawn_egg" in text:
        return
    give = ('give @s minecraft:turtle_spawn_egg{KitDomainFree:1b,'
            'Enchantments:[{id:"minecraft:unbreaking",lvl:1s}],'
            'display:{Name:\'{"text":"赌徒之蛋","color":"gold","italic":false}\','
            'Lore:[\'{"text":"右键使用：下一次领域展开不吃冷却","color":"gray","italic":false}\']}} 1\n')
    text = give + text
    p.write_text(text, encoding="utf-8", newline="\n")
    print("egg card gives the egg")


def main() -> None:
    patch_kit()
    patch_tmp_duration("c12_sharp3.mcfunction", 240)
    patch_tmp_duration("c22_sharp5.mcfunction", 400)
    patch_prot("c13_prot2.mcfunction", 12, 1)
    patch_prot("c24_prot5.mcfunction", 20, 3)
    patch_level()
    patch_egg()


if __name__ == "__main__":
    main()
