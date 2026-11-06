# 飞行器状态自查：/function kitpvp:debug/flyer_state
tellraw @s [{"text":"=== 飞行器状态 ===","color":"gold"}]
execute unless entity @e[tag=kitpvp.earth_flyer_carrier] run tellraw @s [{"text":"母体：不在（没召出来 / 已经死了）","color":"red"}]
execute if entity @e[tag=kitpvp.earth_flyer_carrier] run tellraw @s [{"text":"母体：在","color":"green"},{"text":"  冷却 = ","color":"gray"},{"score":{"name":"@e[tag=kitpvp.earth_flyer_carrier]","objective":"kitpvp.earth_cd_a"},"color":"yellow"},{"text":"  俯冲剩余 = ","color":"gray"},{"score":{"name":"@e[tag=kitpvp.earth_flyer_carrier]","objective":"kitpvp.flyer_dive"},"color":"yellow"},{"text":"  宽限 = ","color":"gray"},{"score":{"name":"@e[tag=kitpvp.earth_flyer_carrier]","objective":"kitpvp.flyer_grace"},"color":"yellow"}]
execute unless entity @e[tag=kitpvp.earth_flyer_body] run tellraw @s [{"text":"吊舱：不在","color":"red"}]
execute if entity @e[tag=kitpvp.earth_flyer_body] run tellraw @s [{"text":"吊舱：在","color":"green"},{"text":"  距离母体 = ","color":"gray"},{"nbt":"Pos","entity":"@e[tag=kitpvp.earth_flyer_body]","color":"dark_aqua"}]
execute store result score #fl_n kitpvp.game if entity @a[tag=kitpvp.flyer_target]
tellraw @s [{"text":"俯冲目标数 = ","color":"gray"},{"score":{"name":"#fl_n","objective":"kitpvp.game"},"color":"yellow"},{"text":"（0 时走"垂直下坠"兜底）","color":"dark_gray"}]
