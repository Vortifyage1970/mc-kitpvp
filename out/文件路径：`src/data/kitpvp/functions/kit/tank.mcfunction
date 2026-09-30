# ===== 坦克（kit id = 3）=====
# 入口：/function kitpvp:kit/tank
# 顺序不可调：先清场（clear_player 会把 kit 归零），再写回本职业 id，最后发装备

# --- 头三行：每个职业函数完全一致，只改数字 ---
function kitpvp:util/clear_player
scoreboard players set @s kitpvp.kit 3
tag @s add kitpvp.selected

# --- 本职业配置 ---
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

attribute @s minecraft:generic.max_health base set 20
attribute @s minecraft:generic.movement_speed base set 0.1

item replace entity @s armor.head with minecraft:diamond_helmet{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:diamond_chestplate{Unbreakable:1b}
item replace entity @s armor.legs with minecraft:diamond_leggings{Unbreakable:1b}
item replace entity @s armor.feet with minecraft:diamond_boots{Unbreakable:1b}
item replace entity @s hotbar.0 with minecraft:wooden_sword{Unbreakable:1b}
item replace entity @s hotbar.1 with minecraft:cooked_beef 16

# 永久被动：缓慢 I + 挖掘疲劳 I
function kitpvp:kit/tank_passive

# 主动技能令牌：右键投出"举盾"（铁傀儡刷怪蛋）
function kitpvp:skill/tank_give_egg

tellraw @s [{"text":"[已选择] ","color":"green","bold":true},{"text":"坦克","color":"yellow","bold":true},{"text":"  右键","color":"gray"},{"text":"举盾令牌","color":"aqua","bold":true},{"text":"释放技能","color":"gray"}]
