# 分步自检：0 = 那一步没成功，1 = 成功
kill @e[tag=kitpvp.ench_bench]
scoreboard players set #s1 kitpvp.game 0
execute if data entity @s Inventory[{Slot:0b}].tag.KitEnch run scoreboard players set #s1 kitpvp.game 1
execute at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["kitpvp.ench_bench"],Invisible:1b,NoGravity:1b,Invulnerable:1b}
scoreboard players set #s2 kitpvp.game 0
execute if entity @e[tag=kitpvp.ench_bench,distance=..2] run scoreboard players set #s2 kitpvp.game 1
item replace entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] armor.head from entity @s hotbar.0
scoreboard players set #s3 kitpvp.game 0
execute if data entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.KitEnch run scoreboard players set #s3 kitpvp.game 1
execute unless data entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag set value {}
execute unless data entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments set value []
execute unless data entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments[{id:"minecraft:sharpness"}] run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments append value {id:"minecraft:sharpness",lvl:0s}
scoreboard players set #s4 kitpvp.game 0
execute if data entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments[{id:"minecraft:sharpness",lvl:0s}] run scoreboard players set #s4 kitpvp.game 1
item replace entity @s hotbar.0 from entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] armor.head
scoreboard players set #s5 kitpvp.game 0
execute if data entity @s Inventory[{Slot:0b}].tag.Enchantments[{id:"minecraft:sharpness"}] run scoreboard players set #s5 kitpvp.game 1
kill @e[tag=kitpvp.ench_bench]
tellraw @a [{"text":"[附魔自检] ","color":"light_purple"},{"text":"剑在(1)=","color":"gray"},{"score":{"name":"#s1","objective":"kitpvp.game"}},{"text":" 架子出来(2)=","color":"gray"},{"score":{"name":"#s2","objective":"kitpvp.game"}},{"text":" 搬进架子(3)=","color":"gray"},{"score":{"name":"#s3","objective":"kitpvp.game"}},{"text":" 列表追加(4)=","color":"gray"},{"score":{"name":"#s4","objective":"kitpvp.game"}},{"text":" 搬回身上(5)=","color":"gray"},{"score":{"name":"#s5","objective":"kitpvp.game"}}]
