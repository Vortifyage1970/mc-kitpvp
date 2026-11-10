# @s = 玩家；执行位置 = 出口门（门心在视线高度、离墙 1.0 格）
# 站到门前：脚落到门心下方 1.55 格（= 使用者开枪时站的地面高度），面向门外
execute rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-1.55 ~ ~ ~
execute rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-1.55 ~ ~ ~
execute rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^ ^0.3
execute rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^ ^0.3

# 竖直动量 → 水平冲刺：5 步底座 + 下落距离/2，最多 16 步（0.9 格/刻 → 4.5 ~ 14.4 格）
scoreboard players set #tep_div kitpvp.game 2
execute store result score @s kitpvp.tep_dash run data get entity @s FallDistance 1
scoreboard players operation @s kitpvp.tep_step = @s kitpvp.tep_dash
scoreboard players operation @s kitpvp.tep_step /= #tep_div kitpvp.game
scoreboard players add @s kitpvp.tep_step 5
execute if score @s kitpvp.tep_step matches 17.. run scoreboard players set @s kitpvp.tep_step 16

data merge entity @s {FallDistance:0f}
scoreboard players set @s kitpvp.tep_ready 10
effect give @s minecraft:slow_falling 2 0 true
particle minecraft:dragon_breath ~ ~1.4 ~ 0.4 0.6 0.4 0.05 16 normal
playsound minecraft:entity.enderman.teleport master @a[distance=..16] ~ ~ ~ 0.8 1.1
# 到达当刻就走第一步，别等下一 tick（否则会顿一下，看着像没弹出去）
execute if score @s kitpvp.tep_step matches 1.. at @s run function kitpvp:skill/enderman/dash_step
