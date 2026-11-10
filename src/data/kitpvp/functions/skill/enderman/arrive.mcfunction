# @s = 玩家；执行位置 = 出口门（门心在视线高度、离墙 1.0 格）
# 先站到门前：脚落到门心下方 1.55 格（= 使用者开枪时站的地面高度），面向门外
execute rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-1.55 ~ ~ ~
execute rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-1.55 ~ ~ ~
execute rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^ ^0.3
execute rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^ ^0.3

# 出口是哪一类门（0 墙 / 1 地面 / 2 天花板）：决定弹出方向
scoreboard players set #tep_face kitpvp.game 0
execute if score @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 1 run scoreboard players set #tep_face kitpvp.game 1
execute if score @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 1 run scoreboard players set #tep_face kitpvp.game 1
execute if score @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 2 run scoreboard players set #tep_face kitpvp.game 2
execute if score @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 2 run scoreboard players set #tep_face kitpvp.game 2

# 记下进门时的下落深度（决定弹多远），然后一次弹出
execute store result score @s kitpvp.tep_dash run data get entity @s FallDistance 1
data merge entity @s {FallDistance:0f}
scoreboard players set @s kitpvp.tep_ready 10
scoreboard players set @s kitpvp.tep_step 0
execute at @s run function kitpvp:skill/enderman/launch
