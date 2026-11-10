# @s = 玩家；执行位置 = 出口门（门心在射线命中的位置，离方块 1.0 格）
# 第一步：先认出出口是哪一类门（0 墙 / 1 地面 / 2 天花板），后面站姿和弹出方向都要看它
scoreboard players set #tep_face kitpvp.game 0
execute if score @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 1 run scoreboard players set #tep_face kitpvp.game 1
execute if score @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 1 run scoreboard players set #tep_face kitpvp.game 1
execute if score @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 2 run scoreboard players set #tep_face kitpvp.game 2
execute if score @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 2 run scoreboard players set #tep_face kitpvp.game 2

# 第二步：按门的类型把玩家摆到门口。
# 墙门：脚落在门心下方 1.55 格（= 开枪时站的地面）；地面门：脚落在门心下方 0.9 格（站在门上方）；
# 天花板门：脚落在门心下方 2.0 格（头刚好在门下面）。之前一律 -1.55，地面门就会把人塞进地板里
execute if score #tep_face kitpvp.game matches 0 rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-1.55 ~ ~ ~
execute if score #tep_face kitpvp.game matches 0 rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-1.55 ~ ~ ~
execute if score #tep_face kitpvp.game matches 1 rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-0.9 ~ ~ ~
execute if score #tep_face kitpvp.game matches 1 rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-0.9 ~ ~ ~
execute if score #tep_face kitpvp.game matches 2 rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-2.0 ~ ~ ~
execute if score #tep_face kitpvp.game matches 2 rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-2.0 ~ ~ ~

# 第三步：往门面外侧再探 0.3 格（墙门=水平出、地面门=往上、天花板门=往下）
execute rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^ ^0.3
execute rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^ ^0.3

# 第四步：记下进门时的下落深度，一次弹出
execute store result score @s kitpvp.tep_dash run data get entity @s FallDistance 1
data merge entity @s {FallDistance:0f}
scoreboard players set @s kitpvp.tep_ready 10
scoreboard players set @s kitpvp.tep_step 0
execute at @s run function kitpvp:skill/enderman/launch
