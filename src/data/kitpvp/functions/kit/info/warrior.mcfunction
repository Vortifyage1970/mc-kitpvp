# ===== 战士（kit id = 1）=====
# 入口：/function kitpvp:kit/warrior
# 顺序不可调：先清场（clear_player 会把 kit 归零），再写回本职业 id，最后发装备

# --- 头三行：每个职业函数完全一致，只改数字 ---
function kitpvp:util/clear_player
scoreboard players set @s kitpvp.kit 1
tag @s add kitpvp.selected

# --- 本职业配置 ---
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

attribute @s minecraft:generic.max_health base set 20
attribute @s minecraft:generic.movement_speed base set 0.1

item replace entity @s armor.head with minecraft:iron_helmet{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:iron_chestplate{Unbreakable:1b}
item replace entity @s armor.legs with minecraft:iron_leggings{Unbreakable:1b}
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b}
item replace entity @s hotbar.0 with minecraft:iron_sword{Unbreakable:1b}
item replace entity @s hotbar.1 with minecraft:cooked_beef 16

tellraw @s [{"text":"[已选择] ","color":"green","bold":true},{"text":"战士","color":"yellow","bold":true}]
function kitpvp:skill/warrior_ready