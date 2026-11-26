# 看手上那把剑的真实状态：附魔条数 / 锋利等级 / 是否还是配发的那把
scoreboard players set #i1 kitpvp.game -1
execute store result score #i1 kitpvp.game run data get entity @s Inventory[{Slot:0b}].tag.Enchantments
scoreboard players set #i2 kitpvp.game -1
execute store result score #i2 kitpvp.game run data get entity @s Inventory[{Slot:0b}].tag.Enchantments[{id:"minecraft:sharpness"}].lvl
scoreboard players set #i3 kitpvp.game 0
execute if data entity @s Inventory[{Slot:0b}].tag.KitEnch run scoreboard players set #i3 kitpvp.game 1
scoreboard players set #i4 kitpvp.game -1
execute store result score #i4 kitpvp.game run data get entity @s Inventory[{Slot:103b}].tag.Enchantments[{id:"minecraft:protection"}].lvl
scoreboard players set #i5 kitpvp.game 0
execute if data entity @s Inventory[{Slot:0b}].tag run scoreboard players set #i5 kitpvp.game 1
tellraw @a [{"text":"[附魔现状] ","color":"light_purple"},{"text":"剑附魔条数=","color":"gray"},{"score":{"name":"#i1","objective":"kitpvp.game"}},{"text":" 锋利等级=","color":"gray"},{"score":{"name":"#i2","objective":"kitpvp.game"}},{"text":" 是配发剑=","color":"gray"},{"score":{"name":"#i3","objective":"kitpvp.game"}},{"text":" 头盔保护=","color":"gray"},{"score":{"name":"#i4","objective":"kitpvp.game"}},{"text":" 剑有tag=","color":"gray"},{"score":{"name":"#i5","objective":"kitpvp.game"}}]
