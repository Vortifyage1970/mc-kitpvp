# ===== 弓箭手 · 职业发放 =====
# 调用方：
#   1) kit/info/archer 的 [确认选择] 按钮 → /function kitpvp:kit/archer
#   2) util/give_kit（重发装备）→ function kitpvp:kit/archer
# 责任：清场 → 分配弓号 → 发装备 → 写分数 → 打 tag
#
# 关于弓号（kitpvp.bowid，1..6）：
#   1.20.1 没有宏、函数参数，弓的 NBT 无法在运行时动态写玩家标识，
#   所以给每个弓箭手静态分配一个 1..6 的编号，弓的 NBT 写死对应的
#   KitBowOwner:<N>b，捡弓时用 6 个 advancement 各自匹配一个值。
#   同一玩家在同一局内只分配一次；编号超过 6 时归 0，发不带归属
#   标记的普通弓（该玩家换弹归属判定退化，是主动限流）。

# 第一行清场（会清零 kitpvp.kit 和 kitpvp.bowid，本函数随后写回）
function kitpvp:util/clear_player

# 职业分
scoreboard players set @s kitpvp.kit 2

# 分配个人弓号（仅当当前为 0 才分配）
execute if score @s kitpvp.bowid matches 0 run scoreboard players add #bowid_counter kitpvp.game 1
execute if score @s kitpvp.bowid matches 0 run scoreboard players operation @s kitpvp.bowid = #bowid_counter kitpvp.game
# 超过 6 号时退化为 0
execute if score @s kitpvp.bowid matches 7.. run scoreboard players set @s kitpvp.bowid 0

# 命数
scoreboard players set @s kitpvp.lives 3

# 护甲
item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b} 1
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b} 1
item replace entity @s armor.legs with minecraft:iron_leggings{Unbreakable:1b} 1
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b} 1

# 主手
item replace entity @s weapon.mainhand with minecraft:stone_sword{Unbreakable:1b} 1

# 副手：按弓号分发（1.20.1 无宏，只能 6 个静态分支）
execute if score @s kitpvp.bowid matches 1 run item replace entity @s weapon.offhand with minecraft:bow{KitBowOwner:1b,Unbreakable:1b} 1
execute if score @s kitpvp.bowid matches 2 run item replace entity @s weapon.offhand with minecraft:bow{KitBowOwner:2b,Unbreakable:1b} 1
execute if score @s kitpvp.bowid matches 3 run item replace entity @s weapon.offhand with minecraft:bow{KitBowOwner:3b,Unbreakable:1b} 1
execute if score @s kitpvp.bowid matches 4 run item replace entity @s weapon.offhand with minecraft:bow{KitBowOwner:4b,Unbreakable:1b} 1
execute if score @s kitpvp.bowid matches 5 run item replace entity @s weapon.offhand with minecraft:bow{KitBowOwner:5b,Unbreakable:1b} 1
execute if score @s kitpvp.bowid matches 6 run item replace entity @s weapon.offhand with minecraft:bow{KitBowOwner:6b,Unbreakable:1b} 1
# 弓号 0：普通弓（无归属标记，拾取时不触发换弹）
execute if score @s kitpvp.bowid matches 0 run item replace entity @s weapon.offhand with minecraft:bow{Unbreakable:1b} 1

# 消耗品
give @s minecraft:cooked_beef 16
give @s minecraft:arrow 12

# 标记（与 kit 系统一致）
tag @s add kitpvp.selected

tellraw @s [{"text":"已选择：","color":"gray"},{"text":"弓箭手","color":"aqua","bold":true}]
