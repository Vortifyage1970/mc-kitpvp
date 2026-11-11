# 炸弹兵（kit = 19）：铁盔 + 铁靴（爆炸保护 V）+ 鲜红皮革胸甲/护腿 + 木剑
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 19
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

item replace entity @s armor.head with minecraft:iron_helmet{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:16711680}}
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b,display:{color:16711680}}
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b,Enchantments:[{id:"minecraft:blast_protection",lvl:5}]}
item replace entity @s weapon.mainhand with minecraft:wooden_sword{Unbreakable:1b}
give @s minecraft:cooked_beef 24

scoreboard players set @s kitpvp.lives 3

# 技能 4：一次性 4 枚核弹（用一枚少一枚，不补货）
function kitpvp:skill/bomber/give_nuke
function kitpvp:skill/bomber/give_nuke
function kitpvp:skill/bomber/give_nuke
function kitpvp:skill/bomber/give_nuke

# 其余令牌开局发满：小炸弹 3 / 大炸弹 2 / 假核弹 1 / 跟踪炸弹 1
function kitpvp:skill/bomber/give_small
function kitpvp:skill/bomber/give_small
function kitpvp:skill/bomber/give_small
function kitpvp:skill/bomber/give_big
function kitpvp:skill/bomber/give_big
function kitpvp:skill/bomber/give_fake
function kitpvp:skill/bomber/give_track

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"炸弹兵","color":"red","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
