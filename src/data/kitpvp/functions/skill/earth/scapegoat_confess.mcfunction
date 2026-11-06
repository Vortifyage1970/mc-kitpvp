# @s = 挨打的玩家：借调员工跳出来认锅（自己吃 2 点伤，玩家挂反胃）
execute at @s if entity @e[tag=kitpvp.earth_scapegoat,distance=..2,sort=nearest,limit=1] run tellraw @a [{"text":"[借调员工] ","color":"gray"},{"text":"这次是我干的，别怪他。","color":"gray","italic":true}]
execute at @s run playsound minecraft:entity.villager.no master @a[distance=..24] ~ ~ ~ 0.9 0.75
execute at @s run damage @e[tag=kitpvp.earth_scapegoat,distance=..2,sort=nearest,limit=1] 2 minecraft:generic
execute at @s if entity @e[tag=kitpvp.earth_scapegoat,distance=..2,sort=nearest,limit=1] run effect give @s minecraft:nausea 3 0 true
execute at @s run title @s actionbar [{"text":"锅已经有人认了，但你被通报批评了","color":"gray","italic":true}]
