# 胸甲 上的 protection +1 级：借一个临时物品实体做 NBT 手术
kill @e[tag=kitpvp.ench_bench]
execute at @s run summon minecraft:item ~ ~ ~ {Tags:["kitpvp.ench_bench"],PickupDelay:32767s,Item:{id:"minecraft:stone",Count:1b}}
data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item set from entity @s Inventory[{Slot:102b}]
execute unless data entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments[{id:"minecraft:protection"}] run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments append value {id:"minecraft:protection",lvl:0s}
execute store result score #ench_lv kitpvp.game run data get entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments[{id:"minecraft:protection"}].lvl
scoreboard players add #ench_lv kitpvp.game 1
execute if score #ench_lv kitpvp.game matches 1 run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments[{id:"minecraft:protection"}].lvl set value 1s
execute if score #ench_lv kitpvp.game matches 2 run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments[{id:"minecraft:protection"}].lvl set value 2s
execute if score #ench_lv kitpvp.game matches 3 run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments[{id:"minecraft:protection"}].lvl set value 3s
execute if score #ench_lv kitpvp.game matches 4 run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments[{id:"minecraft:protection"}].lvl set value 4s
execute if score #ench_lv kitpvp.game matches 5 run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments[{id:"minecraft:protection"}].lvl set value 5s
execute if score #ench_lv kitpvp.game matches 6 run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments[{id:"minecraft:protection"}].lvl set value 6s
execute if score #ench_lv kitpvp.game matches 7 run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments[{id:"minecraft:protection"}].lvl set value 7s
execute if score #ench_lv kitpvp.game matches 8 run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments[{id:"minecraft:protection"}].lvl set value 8s
execute if score #ench_lv kitpvp.game matches 9 run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments[{id:"minecraft:protection"}].lvl set value 9s
execute if score #ench_lv kitpvp.game matches 10 run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments[{id:"minecraft:protection"}].lvl set value 10s
execute if score #ench_lv kitpvp.game matches 11 run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments[{id:"minecraft:protection"}].lvl set value 11s
execute if score #ench_lv kitpvp.game matches 12 run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments[{id:"minecraft:protection"}].lvl set value 12s
execute if score #ench_lv kitpvp.game matches 12.. run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] Item.tag.Enchantments[{id:"minecraft:protection"}].lvl set value 12s
scoreboard players operation @s kitpvp.ench_lv = #ench_lv kitpvp.game
tellraw @s [{"text":"[附魔] ","color":"light_purple"},{"text":"胸甲 · 保护 ","color":"gray"},{"text":"+1","color":"green"},{"text":" → ","color":"dark_gray"},{"score":{"name":"@s","objective":"kitpvp.ench_lv"}},{"text":" 级","color":"white"}]
item replace entity @s armor.chest from entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] contents
kill @e[tag=kitpvp.ench_bench]
playsound minecraft:block.enchantment_table.use master @s ~ ~ ~ 0.35 1.8
particle minecraft:enchant ~ ~1 ~ 0.3 0.6 0.3 0.1 10
