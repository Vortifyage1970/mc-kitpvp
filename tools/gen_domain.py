import os
BASE = r"src/data/kitpvp/functions/skill/enchanter"

def w(name, body):
    path = os.path.join(BASE, name)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8", newline="\n") as f:
        f.write(body.strip("\n") + "\n")

w("domain_cast.mcfunction", """
# 右键《神学大全》：领域展开·坐杀博徒。首行推进快照，否则每刻重复触发
scoreboard players operation @s kitpvp.ench_domain_last = @s kitpvp.ench_domain_used
execute if entity @s[tag=kitpvp.ench_domain] run title @s actionbar {"text":"赌场已经开着了","color":"gray"}
execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_ready matches 1.. run function kitpvp:skill/enchanter/domain_start
execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_ready matches ..0 if score @s kitpvp.ench_domain_cd matches 1.. run title @s actionbar [{"text":"坐杀博徒冷却中：","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_cd"},"color":"white"},{"text":" 刻","color":"gray"}]
execute unless entity @s[tag=kitpvp.ench_domain] if score @s kitpvp.ench_domain_ready matches ..0 if score @s kitpvp.ench_domain_cd matches ..0 run function kitpvp:skill/enchanter/domain_start
""")

w("domain_start.mcfunction", """
# 坐杀博徒：20 秒赌场时间（400 刻），冷却 50 秒（1000 刻）
scoreboard players set @s kitpvp.ench_domain_t 400
scoreboard players set @s kitpvp.ench_domain_cd 1000
scoreboard players set @s kitpvp.ench_domain_ready 0
tag @s add kitpvp.ench_domain
tellraw @a [{"text":"◆　","color":"light_purple"},{"text":"领域展开 · 坐杀博徒","color":"white","bold":true},{"text":"　◆","color":"light_purple"}]
execute as @a at @s run playsound minecraft:block.beacon.activate master @s ~ ~ ~ 0.7 1.0
execute as @a at @s run playsound minecraft:entity.vex.charge master @s ~ ~ ~ 0.5 0.8
particle minecraft:end_rod ~ ~1 ~ 2 2 2 0.1 120
title @s actionbar {"text":"坐杀博徒：20 秒，每次命中抽一张卡","color":"light_purple"}
""")

w("domain_tick.mcfunction", """
# 领域每刻：倒计时、发光、脚下金粒
scoreboard players remove @s kitpvp.ench_domain_t 1
effect give @s minecraft:glowing 2 0 true
particle minecraft:end_rod ~ ~0.2 ~ 0.5 0.1 0.5 0.01 2
title @s actionbar [{"text":"坐杀博徒 ","color":"light_purple"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_t"},"color":"white"},{"text":" 刻 · 命中抽卡","color":"gray"}]
execute if score @s kitpvp.ench_domain_t matches ..0 run function kitpvp:skill/enchanter/domain_end
""")

w("domain_end.mcfunction", """
tellraw @a [{"text":"◆　","color":"light_purple"},{"text":"坐杀博徒 · 收束","color":"gray","bold":true},{"text":"　◆","color":"light_purple"}]
execute as @a at @s run playsound minecraft:block.beacon.deactivate master @s ~ ~ ~ 0.6 1.2
tag @s remove kitpvp.ench_domain
scoreboard players set @s kitpvp.ench_domain_t 0
""")

# 抽卡：7 位定稀有度（0..127），4 位定卡（0..15）
roll_r = ["scoreboard players set #dom_r kitpvp.game 0"]
for bit in (1, 2, 4, 8, 16, 32, 64):
    roll_r.append("execute store success score #dom_b kitpvp.game run predicate kitpvp:random/1in2")
    roll_r.append("execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_r kitpvp.game %d" % bit)
roll_p = ["scoreboard players set #dom_p kitpvp.game 0"]
for bit in (1, 2, 4, 8):
    roll_p.append("execute store success score #dom_b kitpvp.game run predicate kitpvp:random/1in2")
    roll_p.append("execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_p kitpvp.game %d" % bit)

# (稀有度区间, 卡区间, 函数名)
TABLE = [
    ((0, 88), [(0, 20, "c00_mo"), (21, 41, "c01_cui"), (42, 62, "c02_str"), (63, 83, "c03_spd"), (84, 104, "c04_res"), (105, 127, "c05_haste")]),
    ((89, 120), [(0, 20, "c10_fine_sw"), (21, 41, "c11_fine_ap"), (42, 62, "c12_sharp3"), (63, 83, "c13_prot2"), (84, 104, "c14_heal4"), (105, 127, "c15_cd5s")]),
    ((121, 127), [(0, 20, "c20_level"), (21, 41, "c21_egg"), (42, 62, "c22_sharp5"), (63, 83, "c23_heal10"), (84, 104, "c24_prot5"), (105, 127, "c25_souls")]),
]
lines = ["# 坐杀博徒：每命中一次抽一张卡（普通 0..88 / 稀有 89..120 / 传说 121..127）"] + roll_r + [""] + roll_p + [""]
for (rlo, rhi), cards in TABLE:
    for clo, chi, fn in cards:
        lines.append("execute if score @dom_r kitpvp.game matches nothing 0" if False else
                     "execute if score #dom_r kitpvp.game matches %d..%d if score #dom_p kitpvp.game matches %d..%d run function kitpvp:skill/enchanter/card/%s" % (rlo, rhi, clo, chi, fn))
w("domain_draw.mcfunction", "\n".join(lines))

CARDS = {}

CARDS["c00_mo"] = """
scoreboard players add @s kitpvp.ench_sw_fill 60
execute if score @s kitpvp.ench_sw_fill matches 300.. run function kitpvp:skill/enchanter/fill_sw
title @s actionbar [{"text":"◆ 抽到：","color":"white"},{"text":"磨刀","color":"white","bold":true},{"text":"（剑进度 +0.2）","color":"gray"}]
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.6 1.7
"""
CARDS["c01_cui"] = """
scoreboard players add @s kitpvp.ench_ap_fill 60
execute if score @s kitpvp.ench_ap_fill matches 300.. run function kitpvp:skill/enchanter/fill_ap
title @s actionbar [{"text":"◆ 抽到：","color":"white"},{"text":"淬甲","color":"white","bold":true},{"text":"（护甲进度 +0.2）","color":"gray"}]
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.6 1.2
"""
CARDS["c02_str"] = """
effect give @s minecraft:strength 3 0 true
title @s actionbar [{"text":"◆ 抽到：","color":"white"},{"text":"力量 I","color":"white","bold":true},{"text":"（3 秒）","color":"gray"}]
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.6 1.5
"""
CARDS["c03_spd"] = """
effect give @s minecraft:speed 5 1 true
title @s actionbar [{"text":"◆ 抽到：","color":"white"},{"text":"速度 II","color":"white","bold":true},{"text":"（5 秒）","color":"gray"}]
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.6 1.9
"""
CARDS["c04_res"] = """
effect give @s minecraft:resistance 5 0 true
title @s actionbar [{"text":"◆ 抽到：","color":"white"},{"text":"抗性提升 I","color":"white","bold":true},{"text":"（5 秒）","color":"gray"}]
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.6 1.1
"""
CARDS["c05_haste"] = """
effect give @s minecraft:haste 5 1 true
title @s actionbar [{"text":"◆ 抽到：","color":"white"},{"text":"急迫 II","color":"white","bold":true},{"text":"（5 秒）","color":"gray"}]
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 0.6 2.0
"""
CARDS["c10_fine_sw"] = """
scoreboard players add @s kitpvp.ench_sw_fill 120
execute if score @s kitpvp.ench_sw_fill matches 300.. run function kitpvp:skill/enchanter/fill_sw
title @s actionbar [{"text":"◇ 抽到：","color":"aqua"},{"text":"精磨","color":"aqua","bold":true},{"text":"（剑进度 +0.4）","color":"gray"}]
playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.7 1.6
"""
CARDS["c11_fine_ap"] = """
scoreboard players add @s kitpvp.ench_ap_fill 120
execute if score @s kitpvp.ench_ap_fill matches 300.. run function kitpvp:skill/enchanter/fill_ap
title @s actionbar [{"text":"◇ 抽到：","color":"aqua"},{"text":"精淬","color":"aqua","bold":true},{"text":"（护甲进度 +0.4）","color":"gray"}]
playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.7 1.1
"""
CARDS["c12_sharp3"] = """
# 利刃：攻击力 +2（等价锋利 III），10 秒
scoreboard players set @s kitpvp.ench_tmp 200
scoreboard players set @s kitpvp.ench_tmp_kind 3
attribute @s minecraft:generic.attack_damage modifier remove kitpvp:tmp_sharp
attribute @s minecraft:generic.attack_damage modifier add kitpvp:tmp_sharp kitpvp.tmp_sharp 2 operation add
title @s actionbar [{"text":"◇ 抽到：","color":"aqua"},{"text":"利刃","color":"aqua","bold":true},{"text":"（锋利 +3 · 10 秒）","color":"gray"}]
playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.8 1.5
"""
CARDS["c13_prot2"] = """
# 铁壁：四件保护 +2 ≈ 抗性 II 40%，10 秒
effect give @s minecraft:resistance 10 1 true
title @s actionbar [{"text":"◇ 抽到：","color":"aqua"},{"text":"铁壁","color":"aqua","bold":true},{"text":"（全套保护 +2 · 10 秒）","color":"gray"}]
playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.7 0.9
"""
CARDS["c14_heal4"] = """
effect give @s minecraft:instant_health 1 0 true
title @s actionbar [{"text":"◇ 抽到：","color":"aqua"},{"text":"回春","color":"aqua","bold":true},{"text":"（回复两颗心）","color":"gray"}]
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.4 1.8
"""
CARDS["c15_cd5s"] = """
scoreboard players remove @s kitpvp.ench_domain_cd 100
execute if score @s kitpvp.ench_domain_cd matches ..0 run scoreboard players set @s kitpvp.ench_domain_cd 0
title @s actionbar [{"text":"◇ 抽到：","color":"aqua"},{"text":"蓄势","color":"aqua","bold":true},{"text":"（下次领域冷却 −5 秒）","color":"gray"}]
playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.7 1.3
"""
CARDS["c20_level"] = """
# 大当：剑与护甲各 +1 级（直接灌 3 点再走 ench_check）
scoreboard players add @s kitpvp.ench_sw 3
scoreboard players add @s kitpvp.ench_ap 3
execute if score @s kitpvp.ench_sw matches 4.. run scoreboard players set @s kitpvp.ench_sw 3
execute if score @s kitpvp.ench_ap matches 4.. run scoreboard players set @s kitpvp.ench_ap 3
function kitpvp:skill/enchanter/ench_check
tellraw @s [{"text":"★ 大当！","color":"gold","bold":true},{"text":" 剑与护甲各升 1 级","color":"yellow"}]
playsound minecraft:block.anvil.use master @s ~ ~ ~ 1.0 0.8
particle minecraft:totem_of_undying ~ ~1 ~ 0.6 0.6 0.6 0.2 40
"""
CARDS["c21_egg"] = """
# 赌徒之蛋：留着，用掉之后下一次领域不吃冷却
give @s minecraft:turtle_spawn_egg{KitEnchRedraw:1b,display:{Name:'{"text":"坐杀博徒·重开","color":"light_purple","italic":false}'},Enchantments:[{id:"minecraft:unbreaking",lvl:1s}]} 1
tellraw @s [{"text":"★ 抽到：","color":"gold"},{"text":"赌徒之蛋","color":"gold","bold":true},{"text":"（右键使用：下次领域不消耗冷却）","color":"gray"}]
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.7 1.2
"""
CARDS["c22_sharp5"] = """
# 锋锐：攻击力 +3（等价锋利 V），20 秒
scoreboard players set @s kitpvp.ench_tmp 400
scoreboard players set @s kitpvp.ench_tmp_kind 3
attribute @s minecraft:generic.attack_damage modifier remove kitpvp:tmp_sharp
attribute @s minecraft:generic.attack_damage modifier add kitpvp:tmp_sharp kitpvp.tmp_sharp 3 operation add
tellraw @s [{"text":"★ 抽到：","color":"gold"},{"text":"锋锐","color":"gold","bold":true},{"text":"（锋利 +5 · 20 秒）","color":"gray"}]
playsound minecraft:block.anvil.land master @s ~ ~ ~ 0.9 1.1
"""
CARDS["c23_heal10"] = """
effect give @s minecraft:instant_health 1 1 true
effect give @s minecraft:regeneration 2 2 true
tellraw @s [{"text":"★ 抽到：","color":"gold"},{"text":"大回复","color":"gold","bold":true},{"text":"（回复约 10 点生命）","color":"gray"}]
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.7 1.4
"""
CARDS["c24_prot5"] = """
# 守护：四件保护 +5 ≈ 上限 80%，20 秒
effect give @s minecraft:resistance 20 3 true
tellraw @s [{"text":"★ 抽到：","color":"gold"},{"text":"守护","color":"gold","bold":true},{"text":"（全套保护 +5 · 20 秒）","color":"gray"}]
playsound minecraft:block.beacon.activate master @s ~ ~ ~ 0.8 1.3
"""
CARDS["c25_souls"] = """
function kitpvp:skill/soul/give
function kitpvp:skill/soul/give
function kitpvp:skill/soul/give
tellraw @s [{"text":"★ 抽到：","color":"gold"},{"text":"魂石袋","color":"gold","bold":true},{"text":"（3 个随机魂石）","color":"gray"}]
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.8 1.0
"""

for name, body in CARDS.items():
    w("card/%s.mcfunction" % name, body)

w("tmp_expire.mcfunction", """
# 临时强化到点：利刃/锋锐是属性修饰符，得手动摘；抗性/回血是效果，自己会掉
execute if score @s kitpvp.ench_tmp_kind matches 3 run attribute @s minecraft:generic.attack_damage modifier remove kitpvp:tmp_sharp
scoreboard players set @s kitpvp.ench_tmp 0
scoreboard players set @s kitpvp.ench_tmp_kind 0
title @s actionbar {"text":"临时强化已结束","color":"gray"}
""")

w("egg_cast.mcfunction", """
# 赌徒之蛋：右键 → 下一次领域不吃冷却（不立刻展开，还是要右键书）
scoreboard players operation @s kitpvp.ench_egg_last = @s kitpvp.ench_egg_used
execute at @s run kill @e[type=minecraft:turtle,distance=..8]
scoreboard players set @s kitpvp.ench_domain_ready 1
title @s actionbar {"text":"赌徒之蛋已使用：下一次领域不消耗冷却","color":"light_purple"}
playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.9 1.6
""")
print("generated")
