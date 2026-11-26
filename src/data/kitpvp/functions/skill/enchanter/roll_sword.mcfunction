# 剑附魔入口：手上拿着就在手上附，没拿就先去背包里找
scoreboard players set @s kitpvp.ench_sslot 0
execute unless data entity @s SelectedItem{id:"minecraft:golden_sword"} run function kitpvp:skill/enchanter/sw_find
execute if score @s kitpvp.ench_sslot matches 0 if data entity @s SelectedItem{id:"minecraft:golden_sword"} run function kitpvp:skill/enchanter/sw_roll
