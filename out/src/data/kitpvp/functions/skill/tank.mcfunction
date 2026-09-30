# ===== 坦克技能：举盾 =====
# 自动技能。调用方：
#   kit/tank.mcfunction            （选职业时初发）
#   tick -> skill/dispatch         （cd<=0 时，每 30 秒）
# 进入条件：kitpvp.kit=3 且 kitpvp.alive=1 且 kitpvp.cd <= 0
#
# 效果：获得一面持续 15 秒、耐久 80 的盾（放副手）。
# 计时：
#   cd  = 主技能冷却（600 刻 = 30 秒）
#   cd2 = 盾牌剩余寿命（300 刻 = 15 秒），由 tick 每刻递减，
#         归零且 tag=kitpvp.shield_ready -> tank_shield_expire 收回。

# 1. 清掉可能残留的旧盾（背包任意位置），防止叠加成多面
clear @s minecraft:shield{KitShield:1b}

# 2. 发新盾到副手
#    盾最大耐久 336，Damage=256 -> 剩余耐久 80
#    （若与实际不符，只改 256，保持 336-256=80 的关系）
item replace entity @s weapon.offhand with minecraft:shield{KitShield:1b,Damage:256}

# 3. 打标记 + 启动寿命计时（15 秒 = 300 刻）
tag @s add kitpvp.shield_ready
scoreboard players set @s kitpvp.cd2 300

# 4. 主技能冷却（30 秒 = 600 刻）
scoreboard players set @s kitpvp.cd 600

# 5. 反馈
title @s actionbar {"text":"举盾：获得一面盾（15 秒）","color":"gold"}
playsound minecraft:item.shield.block master @s ~ ~ ~ 0.8 1.0
