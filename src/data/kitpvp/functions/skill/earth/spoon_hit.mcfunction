# 勺子打中人：叮一声 + 反胃，并把对方主手的物品搬到"另一个空着的手持栏格子"
# @s = 挨打的那个玩家（由 tick 里 HurtTime=9 那一帧筛出来，身边 3 格内有勺子）
# 1.20.1 没有"交换槽位"的指令，只能：先找第一个空着的手持栏格子 → 把主手的物品复制过去 → 再把主手清空
# 找不到空格（9 格全满）就什么都不做：宁可没效果，也不能覆盖掉玩家别的物品

# ---- 音效与眩晕：一勺敲在头盔上 ----
playsound minecraft:block.note_block.bell master @a[distance=..16] ~ ~ ~ 1.0 2.0
playsound minecraft:entity.item.break master @s ~ ~ ~ 0.6 1.4
effect give @s minecraft:nausea 3 0 true

# ---- 找第一个空着的手持栏格子（0..8，跳过当前选中的那格：搬到原格等于没搬）----
scoreboard players set #sp_done kitpvp.game 0
execute store result score #sp_cur kitpvp.game run data get entity @s SelectedItemSlot
scoreboard players set #sp_free kitpvp.game 1
execute if score #sp_done kitpvp.game matches 0 unless score #sp_cur kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:0b}]
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 0
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
scoreboard players set #sp_free kitpvp.game 1
execute if score #sp_done kitpvp.game matches 0 unless score #sp_cur kitpvp.game matches 1 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:1b}]
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 1
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
scoreboard players set #sp_free kitpvp.game 1
execute if score #sp_done kitpvp.game matches 0 unless score #sp_cur kitpvp.game matches 2 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:2b}]
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 2
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
scoreboard players set #sp_free kitpvp.game 1
execute if score #sp_done kitpvp.game matches 0 unless score #sp_cur kitpvp.game matches 3 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:3b}]
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 3
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
scoreboard players set #sp_free kitpvp.game 1
execute if score #sp_done kitpvp.game matches 0 unless score #sp_cur kitpvp.game matches 4 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:4b}]
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 4
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
scoreboard players set #sp_free kitpvp.game 1
execute if score #sp_done kitpvp.game matches 0 unless score #sp_cur kitpvp.game matches 5 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:5b}]
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 5
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
scoreboard players set #sp_free kitpvp.game 1
execute if score #sp_done kitpvp.game matches 0 unless score #sp_cur kitpvp.game matches 6 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:6b}]
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 6
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
scoreboard players set #sp_free kitpvp.game 1
execute if score #sp_done kitpvp.game matches 0 unless score #sp_cur kitpvp.game matches 7 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:7b}]
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 7
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
scoreboard players set #sp_free kitpvp.game 1
execute if score #sp_done kitpvp.game matches 0 unless score #sp_cur kitpvp.game matches 8 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:8b}]
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 8
execute if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1

# ---- 把主手的物品复制到那格，然后清空主手 ----
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 0 run item replace entity @s hotbar.0 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 0 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 1 run item replace entity @s hotbar.1 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 1 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 2 run item replace entity @s hotbar.2 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 2 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 3 run item replace entity @s hotbar.3 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 3 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 4 run item replace entity @s hotbar.4 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 4 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 5 run item replace entity @s hotbar.5 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 5 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 6 run item replace entity @s hotbar.6 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 6 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 7 run item replace entity @s hotbar.7 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 7 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 8 run item replace entity @s hotbar.8 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 8 run item replace entity @s weapon.mainhand with air

# ---- 真的搬成了才提示（9 格全满时 #sp_done 还是 0，玩家不会白挨一句提示）----
execute if score #sp_done kitpvp.game matches 1 run tellraw @s [{"text":"勺子","color":"gray"},{"text":" 把你的武器舀到了别的格子","color":"yellow","italic":true}]
