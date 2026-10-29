# 生成 3 秒后（earth_lev 从 60 走到 0）获得漂浮 V 15 秒，再走 15 秒后清除
effect give @s minecraft:levitation 15 4 true
tag @s add kitpvp.earth_lifted
scoreboard players set @s kitpvp.earth_lev 300
playsound minecraft:entity.shulker_bullet.hit master @s ~ ~ ~ 1.0 1.4
