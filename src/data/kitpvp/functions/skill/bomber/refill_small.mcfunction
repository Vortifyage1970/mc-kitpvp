# 小炸弹：上限 3、每 10 秒（200 刻）补 1；数量用 clear ... 0 读背包真实值（见 04 §八）
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:mooshroom_spawn_egg{KitBombSmall:1b} 0
execute if score @s kitpvp.tmp matches ..2 run function kitpvp:skill/bomber/give_small
execute if score @s kitpvp.tmp matches ..2 run scoreboard players set @s kitpvp.bomb_small_cd 200
execute if score @s kitpvp.tmp matches ..2 run title @s actionbar {"text":"补给：小炸弹 +1","color":"gold"}
