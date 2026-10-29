# 文明小子（kit = 87）：锋利 V 木棍 + 击退 II 红砖；技能组 1 是喷溅口水（补货型），技能组 2 是恶魔形态
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 87
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

# 高饱和绿 65280（= 0x00FF00）；混搭铁胸甲 / 锁链护腿 / 钻石靴子
item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,display:{color:65280}}
item replace entity @s armor.chest with minecraft:iron_chestplate{Unbreakable:1b}
item replace entity @s armor.legs with minecraft:chainmail_leggings{Unbreakable:1b}
item replace entity @s armor.feet with minecraft:diamond_boots{Unbreakable:1b}

# 木棍本身没有攻击修饰符：伤害 = 基础 1 + 锋利 V 的 3 = 4，攻速沿用基础 4.0
item replace entity @s weapon.mainhand with minecraft:stick{KitCivilStick:1b,Enchantments:[{id:"minecraft:sharpness",lvl:5}]}
give @s minecraft:brick{KitCivilBrick:1b,Enchantments:[{id:"minecraft:knockback",lvl:2}]}
give @s minecraft:cooked_beef 24

scoreboard players set @s kitpvp.cd 0
scoreboard players set @s kitpvp.cd2 0
tag @s remove kitpvp.civil_demon
scoreboard players set @s kitpvp.civil_demon_timer 0

function kitpvp:skill/civil/give_spit
function kitpvp:skill/civil/give_spit
function kitpvp:skill/civil/give_spit
function kitpvp:skill/civil/give_demon_token

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"文明小子","color":"green","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
