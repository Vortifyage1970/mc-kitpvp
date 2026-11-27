#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""里·附魔师重做：单抽 / 十连抽 + 领域内每 2 秒自动白抽。

规则（用户 2026-11-28 定）：
- 单抽：受 3 点瞬间伤害；88% 剑与甲各涨 X 点蓄力（X ∈ 0.5/1/1.5/2，均分），
  10% 给 20 点伤害吸收，2% 进入领域（60 秒）。冷却 2 秒。
- 十连：受 20 点瞬间伤害，然后连抽 10 发。冷却 15 秒。
- 领域内：速度 II / 急迫 II / 生命回复 I，每 2 秒自动白抽一次（不扣血）。

抽卡用刷怪蛋触发（用户要求用蛋），刷出来的生物当场清掉。
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FUN = ROOT / "src/data/kitpvp/functions"
LI = FUN / "skill/li_ench"

SINGLE_EGG = "camel_spawn_egg"
SINGLE_MOB = "minecraft:camel"
TEN_EGG = "panda_spawn_egg"
TEN_MOB = "minecraft:panda"

FILLS = [150, 300, 450, 600]  # 0.5 / 1 / 1.5 / 2 点


def w(name: str, text: str) -> None:
    (LI / name).write_text(text, encoding="utf-8", newline="\n")


def bits(target: str, n: int) -> str:
    """n 位 1/2/4/8... 掷骰，写进 target 计分项。"""
    out = []
    for i in range(n):
        out.append("execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2")
        out.append("execute if score #li_b kitpvp.game matches 1 run scoreboard players add %s kitpvp.game %d"
                   % (target, 1 << i))
    return "\n".join(out) + "\n"


def build() -> None:
    # ---------- 触发 ----------
    w("single_use.mcfunction",
      "# 单抽蛋被用掉：推进快照、清掉刷出来的山羊、进入单抽\n"
      "scoreboard players operation @s kitpvp.li_single_last = @s kitpvp.li_single_used\n"
      "execute at @s run kill @e[type=%s,distance=..8]\n"
      "function kitpvp:skill/li_ench/single_draw\n" % SINGLE_MOB)

    w("ten_use.mcfunction",
      "# 十连蛋被用掉：推进快照、清掉刷出来的熊猫、进入十连\n"
      "scoreboard players operation @s kitpvp.li_ten_last = @s kitpvp.li_ten_used\n"
      "execute at @s run kill @e[type=%s,distance=..8]\n"
      "function kitpvp:skill/li_ench/ten_draw\n" % TEN_MOB)

    # ---------- 单抽 / 十连 ----------
    w("single_draw.mcfunction",
      "# 单抽：冷却 2 秒；3 点瞬间伤害换一次抽卡\n"
      "execute if score @s kitpvp.li_single_cd matches 1.. run title @s actionbar [{\"text\":\"单抽冷却：\",\"color\":\"gray\"},{\"score\":{\"name\":\"@s\",\"objective\":\"kitpvp.li_single_cd\"}},{\"text\":\" 刻\",\"color\":\"gray\"}]\n"
      "execute if score @s kitpvp.li_single_cd matches ..0 run scoreboard players set @s kitpvp.li_single_cd 40\n"
      "execute if score @s kitpvp.li_single_cd matches 40 run damage @s 3 minecraft:magic\n"
      "execute if score @s kitpvp.li_single_cd matches 40 run function kitpvp:skill/li_ench/pull\n")

    ten_pulls = ("execute if score @s kitpvp.li_ten_cd matches 300 run function kitpvp:skill/li_ench/pull\n" * 10)
    w("ten_draw.mcfunction",
      "# 十连：冷却 15 秒；20 点瞬间伤害换十次抽卡\n"
      "execute if score @s kitpvp.li_ten_cd matches 1.. run title @s actionbar [{\"text\":\"十连冷却：\",\"color\":\"gray\"},{\"score\":{\"name\":\"@s\",\"objective\":\"kitpvp.li_ten_cd\"}},{\"text\":\" 刻\",\"color\":\"gray\"}]\n"
      "execute if score @s kitpvp.li_ten_cd matches ..0 run scoreboard players set @s kitpvp.li_ten_cd 300\n"
      "execute if score @s kitpvp.li_ten_cd matches 300 run damage @s 20 minecraft:magic\n"
      + ten_pulls)

    # ---------- 抽卡本体 ----------
    w("pull.mcfunction",
      "# 抽卡：0..112 = 88.3% 蓄力，113..125 = 10.2% 伤害吸收，126..127 = 1.6% 领域\n"
      "scoreboard players set #li_r kitpvp.game 0\n"
      + bits("#li_r", 7) +
      "execute if score #li_r kitpvp.game matches 0..112 run function kitpvp:skill/li_ench/pull_charge\n"
      "execute if score #li_r kitpvp.game matches 113..125 run function kitpvp:skill/li_ench/pull_absorb\n"
      "execute if score #li_r kitpvp.game matches 126..127 run function kitpvp:skill/li_ench/pull_domain\n")

    charge_lines = ["# 蓄力档：0.5 / 1 / 1.5 / 2 点，各 25%",
                    "scoreboard players set #li_x kitpvp.game 0",
                    bits("#li_x", 2).rstrip("\n")]
    for i, fill in enumerate(FILLS):
        pts = fill / 300.0
        label = ("%g" % pts)
        charge_lines.append(
            "execute if score #li_x kitpvp.game matches %d run scoreboard players add @s kitpvp.ench_sw_fill %d" % (i, fill))
        charge_lines.append(
            "execute if score #li_x kitpvp.game matches %d run scoreboard players add @s kitpvp.ench_ap_fill %d" % (i, fill))
        charge_lines.append(
            "execute if score #li_x kitpvp.game matches %d run title @s actionbar [{\"text\":\"◆ 蓄力 +%s 点\",\"color\":\"light_purple\"},{\"text\":\"（剑与甲）\",\"color\":\"gray\"}]" % (i, label))
    for _ in range(2):
        charge_lines.append("execute if score @s kitpvp.ench_sw_fill matches 300.. run function kitpvp:skill/enchanter/fill_sw")
        charge_lines.append("execute if score @s kitpvp.ench_ap_fill matches 300.. run function kitpvp:skill/enchanter/fill_ap")
    charge_lines.append("function kitpvp:skill/enchanter/ench_check")
    charge_lines.append("playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.6 1.6")
    w("pull_charge.mcfunction", "\n".join(charge_lines) + "\n")

    w("pull_absorb.mcfunction",
      "# 伤害吸收：20 点（吸收 V = 20 点），30 秒\n"
      "effect give @s minecraft:absorption 600 4 true\n"
      "title @s actionbar [{\"text\":\"◆ 伤害吸收 20 点\",\"color\":\"yellow\"},{\"text\":\"（30 秒）\",\"color\":\"gray\"}]\n"
      "playsound minecraft:block.beacon.activate master @s ~ ~ ~ 0.6 1.4\n")

    w("pull_domain.mcfunction",
      "# 2% 档：进入领域；已经在领域里就续 60 秒\n"
      "execute if entity @s[tag=kitpvp.ench_domain] run scoreboard players set @s kitpvp.ench_domain_t 1200\n"
      "execute if entity @s[tag=kitpvp.ench_domain] run title @s actionbar {\"text\":\"坐杀博徒：续 60 秒\",\"color\":\"light_purple\"}\n"
      "execute unless entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/li_ench/start\n")

    # ---------- 领域 ----------
    w("start.mcfunction",
      "# 坐杀博徒：60 秒（1200 刻）；速度 II / 急迫 II / 生命回复 I；每 2 秒白抽一次\n"
      "scoreboard players set @s kitpvp.ench_domain_t 1200\n"
      "scoreboard players set @s kitpvp.ench_domain_cd 1200\n"
      "scoreboard players set @s kitpvp.li_dom_pull 40\n"
      "tag @s add kitpvp.ench_domain\n"
      "effect give @s minecraft:speed 1200 1 true\n"
      "effect give @s minecraft:haste 1200 1 true\n"
      "effect give @s minecraft:regeneration 1200 0 true\n"
      "tellraw @a [{\"text\":\"◤　\",\"color\":\"light_purple\"},{\"text\":\"领域展开 ・ 坐杀博徒\",\"color\":\"white\",\"bold\":true},{\"text\":\"　◢\",\"color\":\"light_purple\"}]\n"
      "execute as @a at @s run playsound minecraft:block.beacon.activate master @s ~ ~ ~ 0.7 1.0\n"
      "particle minecraft:end_rod ~ ~1 ~ 2 2 2 0.1 120\n"
      "title @s actionbar {\"text\":\"坐杀博徒：60 秒，每 2 秒白抽一次\",\"color\":\"light_purple\"}\n")

    w("tick_domain.mcfunction",
      "# 领域每刻：倒计时、维持三条 buff、每 40 刻白抽一次\n"
      "scoreboard players remove @s kitpvp.ench_domain_t 1\n"
      "effect give @s minecraft:speed 3 1 true\n"
      "effect give @s minecraft:haste 3 1 true\n"
      "effect give @s minecraft:regeneration 3 0 true\n"
      "execute if score @s kitpvp.li_dom_pull matches 1.. run scoreboard players remove @s kitpvp.li_dom_pull 1\n"
      "execute if score @s kitpvp.li_dom_pull matches ..0 run function kitpvp:skill/li_ench/dom_pull\n"
      "particle minecraft:end_rod ~ ~0.2 ~ 0.5 0.1 0.5 0.01 2\n"
      "title @s actionbar [{\"text\":\"坐杀博徒 \",\"color\":\"light_purple\"},{\"score\":{\"name\":\"@s\",\"objective\":\"kitpvp.ench_domain_t\"},\"color\":\"white\"},{\"text\":\" 刻\",\"color\":\"gray\"}]\n"
      "execute if score @s kitpvp.ench_domain_t matches ..0 run function kitpvp:skill/li_ench/end\n")

    w("dom_pull.mcfunction",
      "# 领域内白抽：不扣血，重置 40 刻的下一抽\n"
      "scoreboard players set @s kitpvp.li_dom_pull 40\n"
      "function kitpvp:skill/li_ench/pull\n"
      "playsound minecraft:block.note_block.hat master @s ~ ~ ~ 0.5 1.2\n")

    # ---------- 玩家每刻 ----------
    w("player_tick.mcfunction",
      "# 里·附魔师每刻：冷却、蛋派发、领域、临时强化\n"
      "execute if score @s kitpvp.li_single_cd matches 1.. run scoreboard players remove @s kitpvp.li_single_cd 1\n"
      "execute if score @s kitpvp.li_ten_cd matches 1.. run scoreboard players remove @s kitpvp.li_ten_cd 1\n"
      "execute if score @s kitpvp.li_single_used > @s kitpvp.li_single_last run function kitpvp:skill/li_ench/single_use\n"
      "execute if score @s kitpvp.li_ten_used > @s kitpvp.li_ten_last run function kitpvp:skill/li_ench/ten_use\n"
      "execute if score @s kitpvp.ench_domain_cd matches 1.. run scoreboard players remove @s kitpvp.ench_domain_cd 1\n"
      "execute if entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/li_ench/tick_domain\n"
      "execute if score @s kitpvp.ench_tmp matches 1.. run scoreboard players remove @s kitpvp.ench_tmp 1\n"
      "execute if score @s kitpvp.ench_tmp matches ..0 if score @s kitpvp.ench_tmp_kind matches 1.. run function kitpvp:skill/li_ench/tmp_expire\n")


def patch_kit() -> None:
    p = FUN / "kit/tainted_enchanter.mcfunction"
    text = p.read_text(encoding="utf-8")
    lines = text.splitlines()
    out = []
    for line in lines:
        if "hotbar.2 with minecraft:bat_spawn_egg" in line:
            out.append(
                'item replace entity @s hotbar.2 with minecraft:%s{KitLiSingle:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:1s}],'
                'display:{Name:\'{"text":"单抽","color":"light_purple","italic":false}\','
                'Lore:[\'{"text":"右键：受 3 点伤害抽一次（冷却 2 秒）","color":"gray","italic":false}\']}}' % SINGLE_EGG)
            out.append(
                'item replace entity @s hotbar.3 with minecraft:%s{KitLiTen:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:1s}],'
                'display:{Name:\'{"text":"十连","color":"gold","italic":false}\','
                'Lore:[\'{"text":"右键：受 20 点伤害连抽十次（冷却 15 秒）","color":"gray","italic":false}\']}}' % TEN_EGG)
            continue
        out.append(line)
    text = "\n".join(out) + "\n"

    text = text.replace(
        "scoreboard players set @s kitpvp.ench_slot 0\n",
        "scoreboard players set @s kitpvp.li_single_cd 0\n"
        "scoreboard players set @s kitpvp.li_ten_cd 0\n"
        "scoreboard players set @s kitpvp.li_dom_pull 0\n"
        "scoreboard players add @s kitpvp.li_single_used 0\n"
        "scoreboard players operation @s kitpvp.li_single_last = @s kitpvp.li_single_used\n"
        "scoreboard players add @s kitpvp.li_ten_used 0\n"
        "scoreboard players operation @s kitpvp.li_ten_last = @s kitpvp.li_ten_used\n"
        "scoreboard players set @s kitpvp.ench_slot 0\n", 1)
    text = text.replace(
        'tellraw @s [{"text":"常态不能蓄力：用「领域展开：坐杀博徒」开场，60 秒内每次命中抽一张卡","color":"dark_gray"}]\n',
        'tellraw @s [{"text":"右键「单抽」受 3 点伤害抽一次；「十连」受 20 点伤害抽十次","color":"dark_gray"}]\n')
    p.write_text(text, encoding="utf-8", newline="\n")
    print("kit patched")


def patch_load() -> None:
    p = FUN / "load.mcfunction"
    text = p.read_text(encoding="utf-8")
    add = (
        'scoreboard objectives add kitpvp.li_single_used minecraft.used:minecraft.%s\n'
        'scoreboard objectives add kitpvp.li_single_last dummy "上一刻的单抽次数"\n'
        'scoreboard objectives add kitpvp.li_ten_used minecraft.used:minecraft.%s\n'
        'scoreboard objectives add kitpvp.li_ten_last dummy "上一刻的十连次数"\n'
        'scoreboard objectives add kitpvp.li_single_cd dummy "单抽冷却刻数（40 = 2 秒）"\n'
        'scoreboard objectives add kitpvp.li_ten_cd dummy "十连冷却刻数（300 = 15 秒）"\n'
        'scoreboard objectives add kitpvp.li_dom_pull dummy "领域内自动单抽倒计时（40 刻 = 2 秒）"\n'
        % (SINGLE_EGG, TEN_EGG)
    )
    if "kitpvp.li_single_used" in text:
        print("load already has li objectives")
        return
    marker = 'scoreboard objectives add kitpvp.ench_domain_t dummy'
    idx = text.index(marker)
    text = text[:idx] + add + text[idx:]
    p.write_text(text, encoding="utf-8", newline="\n")
    print("load patched")


def patch_hooks() -> None:
    for name in ("ench_hit.mcfunction", "ench_hurt.mcfunction"):
        p = FUN / "skill/enchanter" / name
        lines = p.read_text(encoding="utf-8").splitlines()
        kept = [l for l in lines if "kitpvp.kit matches 99" not in l]
        p.write_text("\n".join(kept) + "\n", encoding="utf-8", newline="\n")
        print("hooks cleaned:", name)


def main() -> None:
    build()
    patch_kit()
    patch_load()
    patch_hooks()


if __name__ == "__main__":
    main()
