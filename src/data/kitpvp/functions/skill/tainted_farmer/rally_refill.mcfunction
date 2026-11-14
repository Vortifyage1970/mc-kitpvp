# 上限 1：冷却走完、手上与地上都没有才补一颗（`clear ... 0` 只计数不清除，见 04 §8.1）
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:husk_spawn_egg{KitTaintedRally:1b} 0
execute if score @s kitpvp.tmp matches 0 run give @s minecraft:husk_spawn_egg{KitTaintedRally:1b,display:{Name:'{"text":"召集农民","color":"yellow","italic":false}'}} 1
execute if score @s kitpvp.tmp matches 0 run title @s actionbar {"text":"召集农民已就绪","color":"yellow"}
