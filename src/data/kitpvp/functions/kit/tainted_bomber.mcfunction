# 里·炸弹兵（kit = 32）：鲜红皮革胸甲（爆炸保护 X）+ 纯黑皮革护腿（爆炸保护 X）；无头盔 / 靴子 / 主武器
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 32
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:16711680},Enchantments:[{id:"minecraft:blast_protection",lvl:10}]}
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b,display:{color:0},Enchantments:[{id:"minecraft:blast_protection",lvl:10}]}
give @s minecraft:cooked_beef 12

scoreboard players set @s kitpvp.lives 3

# 令牌开局发满：小炸弹 5 / 大炸弹 5 / 跟踪炸弹 2 / 核弹 5
function kitpvp:skill/bomber/give_small
function kitpvp:skill/bomber/give_small
function kitpvp:skill/bomber/give_small
function kitpvp:skill/bomber/give_small
function kitpvp:skill/bomber/give_small
function kitpvp:skill/bomber/give_big
function kitpvp:skill/bomber/give_big
function kitpvp:skill/bomber/give_big
function kitpvp:skill/bomber/give_big
function kitpvp:skill/bomber/give_big
function kitpvp:skill/bomber/give_track
function kitpvp:skill/bomber/give_track
function kitpvp:skill/bomber/give_nuke
function kitpvp:skill/bomber/give_nuke
function kitpvp:skill/bomber/give_nuke
function kitpvp:skill/bomber/give_nuke
function kitpvp:skill/bomber/give_nuke

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"里·炸弹兵","color":"dark_red","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
