# 天堂制造：一次全图加速 —— 所有参战玩家获得速度 80（放大 1 秒）
# 首行推进快照（同表渔夫），漏写会连放
scoreboard players operation @s kitpvp.halley_last = @s kitpvp.halley_used

effect give @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator] minecraft:speed 1 80 true
title @a[tag=kitpvp.selected,scores={kitpvp.alive=1}] actionbar {"text":"天堂制造","color":"gold"}
playsound minecraft:entity.firework_rocket.launch master @s ~ ~ ~ 1 0.8
particle minecraft:flame ~ ~1 ~ 1 1 1 0.2 30 normal

# 蛋生出来的岩浆怪收掉
execute at @s run kill @e[tag=kitpvp.halley_token,distance=..16]
