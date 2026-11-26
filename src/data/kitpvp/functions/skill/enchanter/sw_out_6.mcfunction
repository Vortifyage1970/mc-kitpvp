# 把主手上的金剑换回 hotbar.5，手上恢复原来的东西，完事拆台子
item replace entity @e[tag=kitpvp.sw_bench,limit=1,sort=nearest] armor.chest from entity @s weapon.mainhand
execute if entity @s[tag=kitpvp.sw_hand] run item replace entity @s weapon.mainhand from entity @s hotbar.5
execute unless entity @s[tag=kitpvp.sw_hand] run item replace entity @s weapon.mainhand with minecraft:air
item replace entity @s hotbar.5 from entity @e[tag=kitpvp.sw_bench,limit=1,sort=nearest] armor.chest
kill @e[tag=kitpvp.sw_bench]
tag @s remove kitpvp.sw_hand
