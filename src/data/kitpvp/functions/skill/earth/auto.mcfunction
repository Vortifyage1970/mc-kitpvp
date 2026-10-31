# 上限 3、每 12 秒（240 刻）补 1 个；数量用 clear ... 0 读背包真实值（见 04 §八）
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:goat_spawn_egg{KitEarthEgg:1b} 0

execute if score @s kitpvp.tmp matches ..2 run function kitpvp:skill/earth/give_egg
execute if score @s kitpvp.tmp matches ..2 run scoreboard players set @s kitpvp.cd 240
execute if score @s kitpvp.tmp matches ..2 run title @s actionbar {"text":"补给：召唤生灵 +1","color":"blue"}
