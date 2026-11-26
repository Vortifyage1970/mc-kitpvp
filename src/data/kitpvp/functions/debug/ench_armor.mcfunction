# 实测四件护甲的保护等级与总 EPF（对着代码算的期望值核验）
execute as @p run execute store result score #p_head kitpvp.game run data get entity @s Inventory[{Slot:103b}].tag.Enchantments[{id:"minecraft:protection"}].lvl
execute as @p run execute store result score #p_head kitpvp.game run data get entity @s Inventory[{Slot:103b}].tag.Enchantments[{id:"minecraft:protection"}].lvl
execute as @p run execute store result score #p_chest kitpvp.game run data get entity @s Inventory[{Slot:102b}].tag.Enchantments[{id:"minecraft:protection"}].lvl
execute as @p run execute store result score #p_chest kitpvp.game run data get entity @s Inventory[{Slot:102b}].tag.Enchantments[{id:"minecraft:protection"}].lvl
execute as @p run execute store result score #p_legs kitpvp.game run data get entity @s Inventory[{Slot:101b}].tag.Enchantments[{id:"minecraft:protection"}].lvl
execute as @p run execute store result score #p_legs kitpvp.game run data get entity @s Inventory[{Slot:101b}].tag.Enchantments[{id:"minecraft:protection"}].lvl
execute as @p run execute store result score #p_feet kitpvp.game run data get entity @s Inventory[{Slot:100b}].tag.Enchantments[{id:"minecraft:protection"}].lvl
execute as @p run execute store result score #p_feet kitpvp.game run data get entity @s Inventory[{Slot:100b}].tag.Enchantments[{id:"minecraft:protection"}].lvl
scoreboard players set #p_sum kitpvp.game 0
scoreboard players operation #p_sum kitpvp.game += #p_head kitpvp.game
scoreboard players operation #p_sum kitpvp.game += #p_chest kitpvp.game
scoreboard players operation #p_sum kitpvp.game += #p_legs kitpvp.game
scoreboard players operation #p_sum kitpvp.game += #p_feet kitpvp.game
tellraw @a [{"text":"[护甲实测] 头盔=","color":"gray"},{"score":{"name":"#p_head","objective":"kitpvp.game"}},{"text":" 胸甲=","color":"gray"},{"score":{"name":"#p_chest","objective":"kitpvp.game"}},{"text":" 护腿=","color":"gray"},{"score":{"name":"#p_legs","objective":"kitpvp.game"}},{"text":" 靴子=","color":"gray"},{"score":{"name":"#p_feet","objective":"kitpvp.game"}},{"text":" 合计EPF=","color":"yellow"},{"score":{"name":"#p_sum","objective":"kitpvp.game"}}]
tellraw @a [{"text":"[护甲实测] 把合计 EPF 除以 4 就是减伤百分比；期望值：6 级 ≈ 4.9，11 级 ≈ 7.3","color":"dark_gray"}]
