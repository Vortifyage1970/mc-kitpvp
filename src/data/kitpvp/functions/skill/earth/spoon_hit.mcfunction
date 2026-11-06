# 勺子打中人：叮一声 + 反胃，然后 60% 概率把对方主手的物品塞进背包区
# @s = 挨打的那个玩家（tick 里 HurtTime=9 那一帧筛出来，身边 3 格内有勺子）
# 60% = 6 次 1in2 拼出 0..63（均匀），取 0..37 共 38/64 = 59.4%；想改概率就改最后那个 37
# 背包区 inventory.0..26 对应 NBT 的 Slot 9..35（0..8 是手持栏），所以探空格的索引要 +9
# 27 格全满时退化成"打掉在地上"：召唤一个物品实体，把 SelectedItem 整份复制过去，再清空主手
# 1.20.1 没有交换槽位指令，所以只能"找空格 → 复制过去 → 清空主手"

# ---- 命中反馈：不管骰子过没过都响，否则玩家会以为是自己手滑 ----
playsound minecraft:block.note_block.bell master @a[distance=..16] ~ ~ ~ 1.0 2.0
playsound minecraft:entity.item.break master @s ~ ~ ~ 0.6 1.4
effect give @s minecraft:nausea 3 0 true

# ---- 骰子：6 次 1in2 拼 0..63，>=38 就这次不搬 ----
scoreboard players set #sp_try kitpvp.game 1
scoreboard players set #sp_done kitpvp.game 0
scoreboard players set #sp_pick kitpvp.game -1
scoreboard players set #sp_rng kitpvp.game 0
execute store success score #sp_bit kitpvp.game if predicate kitpvp:random/1in2
execute if score #sp_bit kitpvp.game matches 1 run scoreboard players add #sp_rng kitpvp.game 1
execute store success score #sp_bit kitpvp.game if predicate kitpvp:random/1in2
execute if score #sp_bit kitpvp.game matches 1 run scoreboard players add #sp_rng kitpvp.game 2
execute store success score #sp_bit kitpvp.game if predicate kitpvp:random/1in2
execute if score #sp_bit kitpvp.game matches 1 run scoreboard players add #sp_rng kitpvp.game 4
execute store success score #sp_bit kitpvp.game if predicate kitpvp:random/1in2
execute if score #sp_bit kitpvp.game matches 1 run scoreboard players add #sp_rng kitpvp.game 8
execute store success score #sp_bit kitpvp.game if predicate kitpvp:random/1in2
execute if score #sp_bit kitpvp.game matches 1 run scoreboard players add #sp_rng kitpvp.game 16
execute store success score #sp_bit kitpvp.game if predicate kitpvp:random/1in2
execute if score #sp_bit kitpvp.game matches 1 run scoreboard players add #sp_rng kitpvp.game 32
execute if score #sp_rng kitpvp.game matches 38.. run scoreboard players set #sp_try kitpvp.game 0

# ---- 找第一个空着的背包格（0..26 → NBT Slot 9..35）----
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:9b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 0
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:10b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:11b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 2
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:12b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 3
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:13b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 4
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:14b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 5
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:15b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 6
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:16b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 7
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:17b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 8
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:18b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 9
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:19b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 10
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:20b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 11
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:21b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 12
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:22b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 13
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:23b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 14
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:24b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 15
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:25b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 16
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:26b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 17
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:27b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 18
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:28b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 19
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:29b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 20
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:30b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 21
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:31b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 22
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:32b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 23
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:33b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 24
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:34b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 25
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 store success score #sp_free kitpvp.game run data get entity @s Inventory[{Slot:35b}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_pick kitpvp.game 26
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 if score #sp_free kitpvp.game matches 0 run scoreboard players set #sp_done kitpvp.game 1

# ---- 找到了：复制到那格，再清空主手 ----
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 0 run item replace entity @s inventory.0 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 0 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 1 run item replace entity @s inventory.1 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 1 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 2 run item replace entity @s inventory.2 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 2 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 3 run item replace entity @s inventory.3 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 3 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 4 run item replace entity @s inventory.4 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 4 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 5 run item replace entity @s inventory.5 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 5 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 6 run item replace entity @s inventory.6 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 6 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 7 run item replace entity @s inventory.7 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 7 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 8 run item replace entity @s inventory.8 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 8 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 9 run item replace entity @s inventory.9 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 9 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 10 run item replace entity @s inventory.10 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 10 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 11 run item replace entity @s inventory.11 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 11 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 12 run item replace entity @s inventory.12 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 12 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 13 run item replace entity @s inventory.13 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 13 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 14 run item replace entity @s inventory.14 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 14 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 15 run item replace entity @s inventory.15 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 15 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 16 run item replace entity @s inventory.16 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 16 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 17 run item replace entity @s inventory.17 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 17 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 18 run item replace entity @s inventory.18 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 18 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 19 run item replace entity @s inventory.19 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 19 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 20 run item replace entity @s inventory.20 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 20 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 21 run item replace entity @s inventory.21 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 21 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 22 run item replace entity @s inventory.22 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 22 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 23 run item replace entity @s inventory.23 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 23 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 24 run item replace entity @s inventory.24 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 24 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 25 run item replace entity @s inventory.25 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 25 run item replace entity @s weapon.mainhand with air
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 26 run item replace entity @s inventory.26 from entity @s weapon.mainhand
execute if score #sp_done kitpvp.game matches 1 if score #sp_pick kitpvp.game matches 26 run item replace entity @s weapon.mainhand with air

# ---- 背包全满：掉在脚边（用 SelectedItem 整份复制成物品实体，避免手写 NBT 丢掉附魔和名字）----
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 at @s run summon minecraft:item ~ ~1 ~ {Tags:["kitpvp.spoon_loot"],PickupDelay:20s,Item:{id:"minecraft:air",Count:1b}}
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 run data modify entity @e[tag=kitpvp.spoon_loot,sort=nearest,limit=1] Item set from entity @s SelectedItem
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 run item replace entity @s weapon.mainhand with air
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 run tag @e[tag=kitpvp.spoon_loot,sort=nearest,limit=1] remove kitpvp.spoon_loot

# ---- 提示：搬进背包 / 打掉在地上 两种结果分开说 ----
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 1 run tellraw @s [{"text":"勺子","color":"gray"},{"text":" 把你的武器塞进了背包","color":"yellow","italic":true}]
execute if score #sp_try kitpvp.game matches 1 if score #sp_done kitpvp.game matches 0 run tellraw @s [{"text":"勺子","color":"gray"},{"text":" 把你的武器打掉了","color":"yellow","italic":true}]
