# 首行推进快照，漏写会每刻重复触发
scoreboard players operation @s kitpvp.soul_warrior_last = @s kitpvp.soul_warrior_used

execute at @s run kill @e[type=minecraft:blaze,name="战士魂石"]

effect give @s minecraft:strength 20 0 true

title @s actionbar {"text":"魂石·战意：力量 I（20 秒）","color":"red"}
playsound minecraft:entity.player.attack.strong master @s ~ ~ ~ 0.8 1.2
