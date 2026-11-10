# @s = 玩家；执行位置 = 出口门（门心在视线高度）
# 站到门前：脚落到门心下方 1.55 格（= 使用者开枪时站的地面高度），面向门朝外的方向
execute rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-1.55 ~ ~ ~
execute rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-1.55 ~ ~ ~
# 再往外探 0.3 格：门本身离墙 0.85 格，加上这 0.3 绝不会半个身子卡在墙里
execute rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^ ^0.3
execute rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^ ^0.3

# 竖直动量 → 水平冲刺：进门时摔得越深，出去弹得越远（3 步底座 + 下落距离/4，最多 10 步）
scoreboard players set #tep_div kitpvp.game 4
execute store result score @s kitpvp.tep_dash run data get entity @s FallDistance 1
scoreboard players operation @s kitpvp.tep_step = @s kitpvp.tep_dash
scoreboard players operation @s kitpvp.tep_step /= #tep_div kitpvp.game
scoreboard players add @s kitpvp.tep_step 3
execute if score @s kitpvp.tep_step matches 11.. run scoreboard players set @s kitpvp.tep_step 10

data merge entity @s {FallDistance:0f}
scoreboard players set @s kitpvp.tep_ready 10
particle minecraft:dragon_breath ~ ~1.4 ~ 0.4 0.6 0.4 0.05 16 normal
playsound minecraft:entity.enderman.teleport master @a[distance=..16] ~ ~ ~ 0.8 1.1
