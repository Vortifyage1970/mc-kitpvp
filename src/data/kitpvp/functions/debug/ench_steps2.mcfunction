# 追加失败定位：打印 Enchantments 列表长度（-1 = 读不到/不存在）
kill @e[tag=kitpvp.ench_bench]
execute at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["kitpvp.ench_bench"],Invisible:1b,NoGravity:1b,Invulnerable:1b}
item replace entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] armor.head from entity @s hotbar.0
scoreboard players set #sz0 kitpvp.game -1
execute if data entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag run scoreboard players set #sz0 kitpvp.game 0
scoreboard players set #sz1 kitpvp.game -1
execute store result score #sz1 kitpvp.game run data get entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments
execute unless data entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments set value []
scoreboard players set #sz2 kitpvp.game -1
execute store result score #sz2 kitpvp.game run data get entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments
data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments append value {id:"minecraft:sharpness",lvl:0s}
scoreboard players set #sz3 kitpvp.game -1
execute store result score #sz3 kitpvp.game run data get entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments
scoreboard players set #sz4 kitpvp.game 0
execute if data entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments[{id:"minecraft:sharpness"}] run scoreboard players set #sz4 kitpvp.game 1
kill @e[tag=kitpvp.ench_bench]
tellraw @a [{"text":"[附魔自检2] ","color":"light_purple"},{"text":"tag在(0)=","color":"gray"},{"score":{"name":"#sz0","objective":"kitpvp.game"}},{"text":" 列表长度(初始)=","color":"gray"},{"score":{"name":"#sz1","objective":"kitpvp.game"}},{"text":" set空表后=","color":"gray"},{"score":{"name":"#sz2","objective":"kitpvp.game"}},{"text":" append后=","color":"gray"},{"score":{"name":"#sz3","objective":"kitpvp.game"}},{"text":" 有锋利=","color":"gray"},{"score":{"name":"#sz4","objective":"kitpvp.game"}}]
