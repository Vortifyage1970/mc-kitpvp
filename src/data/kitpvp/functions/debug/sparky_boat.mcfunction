# 试验：用 NBT Passengers 把劫掠兽塞进船里（右键上船走的是交互/AI，NBT 乘客直接建"载具-乘客"关系）
# 船先造、乘客写在船身上；两条并列 —— 一条橡木船 + 一只劫掠兽
summon minecraft:boat ~ ~ ~ {Type:"oak",Tags:["kitpvp.test_boat"],Passengers:[{id:"minecraft:ravager",Tags:["kitpvp.test_boat_pax"],CustomName:'{"text":"船上的电磁炮","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,NoAI:1b,Health:50.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:50.0}]}]}
# 判定一：船在不在
execute at @s if entity @e[tag=kitpvp.test_boat,distance=..4] run tellraw @s [{"text":"[试验] 船造出来了","color":"yellow"}]
execute at @s unless entity @e[tag=kitpvp.test_boat,distance=..4] run tellraw @s [{"text":"[试验] 船没造出来（脚下别站水里/方块里）","color":"red"}]
# 判定二：乘客数（data get 取列表会返回长度；1 = 劫掠兽真坐上了）
execute at @s unless entity @e[tag=kitpvp.test_boat,distance=..4] run return 0
execute at @s store result score #boat_pax kitpvp.game run data get entity @e[tag=kitpvp.test_boat,distance=..4,limit=1,sort=nearest] Passengers
tellraw @s [{"text":"[试验] 船的乘客数 = ","color":"gray"},{"score":{"name":"#boat_pax","objective":"kitpvp.game"},"color":"aqua"},{"text":"（1 = 劫掠兽坐上了；0 = 没坐上，说明这版本硬拦）","color":"gray"}]
