# 地球·81 逃兵：每刻读一次真实血量
# 11 点以上照常打人；10 点及以下（半血）切逃跑 —— 只切一次，之后一直逃，治好了也不回头
scoreboard players set @s kitpvp.dser_hp 0
execute store result score @s kitpvp.dser_hp run data get entity @s Health 1
execute if score @s kitpvp.dser_hp matches ..10 unless entity @s[tag=kitpvp.dser_flee] run function kitpvp:skill/earth/deserter_flee
execute if entity @s[tag=kitpvp.dser_flee] run function kitpvp:skill/earth/deserter_run
