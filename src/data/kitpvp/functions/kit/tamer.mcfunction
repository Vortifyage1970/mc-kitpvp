# 驯兽师（kit = 11）：锁链套 + 石剑 + 一背包动物；狼蛋由 skill/tamer/auto 补货
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 11
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

item replace entity @s armor.head with minecraft:chainmail_helmet{Unbreakable:1b} 1
item replace entity @s armor.chest with minecraft:chainmail_chestplate{Unbreakable:1b} 1
item replace entity @s armor.legs with minecraft:chainmail_leggings{Unbreakable:1b} 1
item replace entity @s armor.feet with minecraft:chainmail_boots{Unbreakable:1b} 1

item replace entity @s hotbar.0 with minecraft:stone_sword{Unbreakable:1b} 1
item replace entity @s hotbar.1 with minecraft:cooked_beef 24

give @s minecraft:bone 64
give @s minecraft:apple 32
give @s minecraft:saddle 1

# 放出来的动物是本职业的产品，当场不清；game/reset 按类型清场（含后代，见 04 §五）
give @s minecraft:horse_spawn_egg 32
give @s minecraft:parrot_spawn_egg 32
give @s minecraft:dolphin_spawn_egg 32
give @s minecraft:fox_spawn_egg 32
give @s minecraft:frog_spawn_egg 32
give @s minecraft:tadpole_spawn_egg 32
give @s minecraft:turtle_spawn_egg 32
give @s minecraft:goat_spawn_egg 32
give @s minecraft:salmon_spawn_egg 32

# 开局 3 个狼蛋（持有上限 3，与 skill/tamer/auto 的补货闸门一致）
function kitpvp:skill/tamer/give_egg
function kitpvp:skill/tamer/give_egg
function kitpvp:skill/tamer/give_egg

tellraw @s [{"text":"[职业] ","color":"aqua","bold":true},{"text":"已选择 ","color":"gray"},{"text":"驯兽师","color":"yellow","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
