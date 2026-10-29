# 上限 5、每 10 秒（200 刻）补 1 个；数量用 clear ... 0 读背包真实值（见 04 §八）
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:pig_spawn_egg{KitLiPig:1b} 0

execute if score @s kitpvp.tmp matches ..4 run function kitpvp:skill/li_zhujunze/give_egg
execute if score @s kitpvp.tmp matches ..4 run scoreboard players set @s kitpvp.cd 200
execute if score @s kitpvp.tmp matches ..4 run title @s actionbar {"text":"补给：iLsacuL +1","color":"light_purple"}
execute if score @s kitpvp.tmp matches ..4 at @s run playsound minecraft:entity.pig.ambient master @s ~ ~ ~ 0.8 1.4
