#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""里·附魔师抽卡改三星 / 四星 / 大奖 + 70 抽保底。

- 三星（其余概率）：剑与甲各涨 0.5~2 点蓄力（沿用 pull_charge）。
- 四星 10%：随机魂石 / 召唤阴兵 / 召唤护林员 / 召唤宇航员 / 20 点伤害吸收 10 秒。
- 大奖 0.6% 起，连抽 70 次没出后概率线性上升，第 90 抽必出；大奖 = 坐杀博徒领域 60 秒。
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FUN = ROOT / "src/data/kitpvp/functions"
LI = FUN / "skill/li_ench"


def w(name: str, text: str) -> None:
    (LI / name).write_text(text, encoding="utf-8", newline="\n")


def bits(target: str, n: int) -> str:
    out = []
    for i in range(n):
        out.append("execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2")
        out.append("execute if score #li_b kitpvp.game matches 1 run scoreboard players add %s kitpvp.game %d"
                   % (target, 1 << i))
    return "\n".join(out)


def build() -> None:
    # 大奖阈值：0..69 抽 = 49/8192 (0.60%)；70..89 抽线性；90 抽起 8192/8192
    w("pull.mcfunction",
      "# 抽卡：先掷大奖（13 位 = 0..8191），没出货再掷四星（10%），其余三星蓄力\n"
      "scoreboard players set #li_407 kitpvp.game 407\n"
      "scoreboard players set #li_8192 kitpvp.game 8192\n"
      "scoreboard players set #li_820 kitpvp.game 820\n"
      "scoreboard players set #li_t kitpvp.game 49\n"
      "execute if score @s kitpvp.li_pity matches 70.. run scoreboard players operation #li_t kitpvp.game = @s kitpvp.li_pity\n"
      "execute if score @s kitpvp.li_pity matches 70.. run scoreboard players remove #li_t kitpvp.game 70\n"
      "execute if score @s kitpvp.li_pity matches 70.. run scoreboard players operation #li_t kitpvp.game *= #li_407 kitpvp.game\n"
      "execute if score @s kitpvp.li_pity matches 70.. run scoreboard players add #li_t kitpvp.game 49\n"
      "execute if score @s kitpvp.li_pity matches 90.. run scoreboard players set #li_t kitpvp.game 8192\n"
      "scoreboard players set #li_r kitpvp.game 0\n"
      + bits("#li_r", 13) + "\n"
      "scoreboard players set #li_r4 kitpvp.game 0\n"
      + bits("#li_r4", 10) + "\n"
      "execute if score #li_r kitpvp.game < #li_t kitpvp.game run scoreboard players set @s kitpvp.li_pity 0\n"
      "execute if score #li_r kitpvp.game < #li_t kitpvp.game run function kitpvp:skill/li_ench/pull_jackpot\n"
      "execute unless score #li_r kitpvp.game < #li_t kitpvp.game run scoreboard players add @s kitpvp.li_pity 1\n"
      "execute unless score #li_r kitpvp.game < #li_t kitpvp.game if score #li_r4 kitpvp.game matches 0..819 run function kitpvp:skill/li_ench/pull_four\n"
      "execute unless score #li_r kitpvp.game < #li_t kitpvp.game if score #li_r4 kitpvp.game matches 820.. run function kitpvp:skill/li_ench/pull_charge\n")

    # 四星：五选一
    w("pull_four.mcfunction",
      "# 四星：五个奖品等概率\n"
      "scoreboard players set #li_5 kitpvp.game 5\n"
      "scoreboard players operation #li_p4 kitpvp.game = #li_r4 kitpvp.game\n"
      "scoreboard players operation #li_p4 kitpvp.game %= #li_5 kitpvp.game\n"
      "execute if score #li_p4 kitpvp.game matches 0 run function kitpvp:skill/li_ench/pull_4soul\n"
      "execute if score #li_p4 kitpvp.game matches 1 run function kitpvp:skill/li_ench/pull_4ghost\n"
      "execute if score #li_p4 kitpvp.game matches 2 run function kitpvp:skill/li_ench/pull_4forester\n"
      "execute if score #li_p4 kitpvp.game matches 3 run function kitpvp:skill/li_ench/pull_4astro\n"
      "execute if score #li_p4 kitpvp.game matches 4 run function kitpvp:skill/li_ench/pull_4absorb\n")

    w("pull_4soul.mcfunction",
      "# 四星：随机一个魂石\n"
      "function kitpvp:skill/soul/give\n"
      "title @s actionbar [{\"text\":\"★★ 随机魂石\",\"color\":\"aqua\"},{\"text\":\"（看背包）\",\"color\":\"gray\"}]\n"
      "playsound minecraft:block.amethyst_block.chime master @s ~ ~ ~ 0.8 1.5\n")

    for fname, fn, label in (
        ("pull_4ghost.mcfunction", "earth_ghost_minion", "阴兵"),
        ("pull_4forester.mcfunction", "earth_forester", "护林员"),
        ("pull_4astro.mcfunction", "earth_astronaut", "宇航员"),
    ):
        w(fname,
          "# 四星：召唤一只%s（走地球召唤的归属流程）\n" % label
          + "execute at @s run function kitpvp:summon/%s\n" % fn
          + "function kitpvp:skill/earth/link\n"
          + "title @s actionbar [{\"text\":\"★★ 召唤%s\",\"color\":\"aqua\"}]\n" % label
          + "playsound minecraft:entity.evoker.prepare_summon master @s ~ ~ ~ 0.7 1.2\n")

    w("pull_4absorb.mcfunction",
      "# 四星：20 点伤害吸收 10 秒\n"
      "effect give @s minecraft:absorption 200 4 true\n"
      "title @s actionbar [{\"text\":\"★★ 伤害吸收 20 点\",\"color\":\"aqua\"},{\"text\":\"（10 秒）\",\"color\":\"gray\"}]\n"
      "playsound minecraft:block.amethyst_block.chime master @s ~ ~ ~ 0.8 1.2\n")

    # 大奖 = 领域
    w("pull_jackpot.mcfunction",
      "# 大奖：坐杀博徒领域（已在领域里就续时）\n"
      "execute if entity @s[tag=kitpvp.ench_domain] run scoreboard players set @s kitpvp.ench_domain_t 1200\n"
      "execute if entity @s[tag=kitpvp.ench_domain] run title @s title [{\"text\":\"★★★ 续时 60 秒\",\"color\":\"light_purple\",\"bold\":true}]\n"
      "execute unless entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/li_ench/start\n"
      "execute unless entity @s[tag=kitpvp.ench_domain] run title @s title [{\"text\":\"★★★ 坐杀博徒\",\"color\":\"light_purple\",\"bold\":true}]\n"
      "execute as @a at @s run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 0.4 1.6\n")


def patch_load() -> None:
    p = FUN / "load.mcfunction"
    t = p.read_text(encoding="utf-8")
    if "kitpvp.li_pity" in t:
        print("load already has li_pity")
        return
    t = t.replace(
        'scoreboard objectives add kitpvp.li_dom_pull dummy',
        'scoreboard objectives add kitpvp.li_pity dummy "距离上次大奖抽了多少次（70 起涨概率，90 必出）"\n'
        'scoreboard objectives add kitpvp.li_dom_pull dummy', 1)
    p.write_text(t, encoding="utf-8", newline="\n")
    print("load patched")


def patch_kit() -> None:
    p = FUN / "kit/tainted_enchanter.mcfunction"
    t = p.read_text(encoding="utf-8")
    if "li_pity" in t:
        print("kit already has li_pity")
        return
    t = t.replace("scoreboard players set @s kitpvp.li_single_cd 0\n",
                  "scoreboard players set @s kitpvp.li_single_cd 0\n"
                  "scoreboard players set @s kitpvp.li_pity 0\n", 1)
    p.write_text(t, encoding="utf-8", newline="\n")
    print("kit patched")


def main() -> None:
    build()
    patch_load()
    patch_kit()


if __name__ == "__main__":
    main()
