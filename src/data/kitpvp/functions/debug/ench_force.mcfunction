# 决定性测试：直接把锋利 V 写回手里的剑，跳过所有等级计算
kill @e[tag=kitpvp.ench_bench]
execute at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["kitpvp.ench_bench"],Invisible:1b,NoGravity:1b,Invulnerable:1b}
item replace entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] armor.head from entity @s weapon.mainhand
execute unless data entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag run data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag set value {}
data modify entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] ArmorItems[3].tag.Enchantments set value [{id:"minecraft:sharpness",lvl:5s}]
item replace entity @s weapon.mainhand from entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] armor.head
kill @e[tag=kitpvp.ench_bench]
tellraw @s [{"text":"\n[附魔强制] ","color":"light_purple"},{"text":"已把锋利 V 写回你手上那格（手持那一格），看一眼剑上有没有蓝字","color":"gray"}]
