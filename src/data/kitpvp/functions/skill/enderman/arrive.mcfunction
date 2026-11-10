# @s = 玩家；执行位置 = 出口门
# 站到门的位置并面向门的朝向（这样后面的冲刺方向就是"从门里弹出去"）
execute rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ~ ~ ~ ~ ~
execute rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ~ ~ ~ ~ ~

# 竖直动量 → 水平冲刺：进门时摔得多深，出去就弹多远（3 步底座，最多 8 步）
# 1.20.1 没有 `scoreboard players divide`，除法只能走 operation /=（除数放假玩家）
scoreboard players set #tep_div kitpvp.game 5
execute store result score @s kitpvp.tep_dash run data get entity @s FallDistance 1
scoreboard players operation @s kitpvp.tep_step = @s kitpvp.tep_dash
scoreboard players operation @s kitpvp.tep_step /= #tep_div kitpvp.game
scoreboard players add @s kitpvp.tep_step 3
execute if score @s kitpvp.tep_step matches 9.. run scoreboard players set @s kitpvp.tep_step 8

data merge entity @s {FallDistance:0f}
scoreboard players set @s kitpvp.tep_ready 10
particle minecraft:dragon_breath ~ ~0.9 ~ 0.4 0.9 0.4 0.05 20 normal
playsound minecraft:entity.enderman.teleport master @a[distance=..16] ~ ~ ~ 0.8 1.1
