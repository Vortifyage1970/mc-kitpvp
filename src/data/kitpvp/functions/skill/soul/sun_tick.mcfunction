# @s = 太阳魂石的 marker（每刻被 tick 调一次）
# 失明每刻重挂 2 秒覆盖：整段 20 秒持续有效，中途走进 10 格的人也会立刻失明
execute at @s as @a[distance=..10,scores={kitpvp.alive=1},tag=!kitpvp.spectator] run effect give @s minecraft:blindness 2 0 true
execute if score @s kitpvp.soul_next matches ..0 run function kitpvp:skill/soul/sun_noise
execute if score @s kitpvp.soul_next matches 1.. run scoreboard players remove @s kitpvp.soul_next 1
execute if score @s kitpvp.soul_timer matches 1.. run scoreboard players remove @s kitpvp.soul_timer 1
execute if score @s kitpvp.soul_timer matches ..0 run kill @s
