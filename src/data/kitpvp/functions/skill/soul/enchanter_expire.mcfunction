# @s = 五级附魔到点的玩家：从 stone_bak 把原件换回去
# 只还原"还带着 KitSoulTemp 标记"的槽位：中途换过装就不动，免得把新装备覆盖掉
scoreboard players set #stone_t kitpvp.game 0
execute store result score #stone_t kitpvp.game run data get entity @s SelectedItem.tag.KitSoulTemp 1
execute if score #stone_t kitpvp.game matches 1 run item replace entity @s weapon.mainhand from entity @e[tag=kitpvp.stone_bak,limit=1,sort=nearest] armor.head
scoreboard players set #stone_t kitpvp.game 0
execute store result score #stone_t kitpvp.game run data get entity @s Inventory[{Slot:103b}].tag.KitSoulTemp 1
execute if score #stone_t kitpvp.game matches 1 run item replace entity @s armor.head from entity @e[tag=kitpvp.stone_bak,limit=1,sort=nearest] armor.chest
scoreboard players set #stone_t kitpvp.game 0
execute store result score #stone_t kitpvp.game run data get entity @s Inventory[{Slot:102b}].tag.KitSoulTemp 1
execute if score #stone_t kitpvp.game matches 1 run item replace entity @s armor.chest from entity @e[tag=kitpvp.stone_bak,limit=1,sort=nearest] armor.legs
scoreboard players set #stone_t kitpvp.game 0
execute store result score #stone_t kitpvp.game run data get entity @s Inventory[{Slot:101b}].tag.KitSoulTemp 1
execute if score #stone_t kitpvp.game matches 1 run item replace entity @s armor.legs from entity @e[tag=kitpvp.stone_bak,limit=1,sort=nearest] armor.feet
scoreboard players set #stone_t kitpvp.game 0
execute store result score #stone_t kitpvp.game run data get entity @s Inventory[{Slot:100b}].tag.KitSoulTemp 1
execute if score #stone_t kitpvp.game matches 1 run item replace entity @s armor.feet from entity @e[tag=kitpvp.stone_bak,limit=1,sort=nearest] weapon.mainhand
# 收摊
kill @e[tag=kitpvp.stone_bak,distance=..8]
kill @e[tag=kitpvp.stone_work,distance=..8]
scoreboard players set @s kitpvp.stone_left -1
playsound minecraft:block.enchantment_table.use master @s ~ ~ ~ 0.8 0.9
particle minecraft:enchant ~ ~1 ~ 0.6 0.8 0.6 0.03 20
tellraw @s [{"text":"[附魔师魂石] ","color":"gray"},{"text":"五级附魔已失效","color":"gray"}]
