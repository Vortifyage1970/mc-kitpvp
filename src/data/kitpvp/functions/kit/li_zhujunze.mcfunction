# 李朱俊泽（kit = 88）：大将军铁剑（亡灵杀手 V / 节肢杀手 V）+ 玩家头颅（爆炸保护 100，护甲 4）
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 88
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

# 头颅本身没有护甲，护甲 4 靠 head 槽上的修饰符（写 AttributeModifiers 会整体取代默认修饰符）；
# 2026-11-10 起去掉韧性 4
item replace entity @s armor.head with minecraft:player_head{SkullOwner:"LiZhujunze",Enchantments:[{id:"minecraft:blast_protection",lvl:10}],AttributeModifiers:[{AttributeName:"minecraft:generic.armor",Name:"kitpvp.li_armor",Amount:4,Operation:0,UUID:[I;88,0,0,1],Slot:"head"}]}

item replace entity @s weapon.mainhand with minecraft:iron_sword{Unbreakable:1b,Enchantments:[{id:"minecraft:smite",lvl:5},{id:"minecraft:bane_of_arthropods",lvl:5}]}
give @s minecraft:cooked_beef 24

scoreboard players set @s kitpvp.cd 0
function kitpvp:skill/li_zhujunze/give_egg
function kitpvp:skill/li_zhujunze/give_egg
function kitpvp:skill/li_zhujunze/give_egg

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"李朱俊泽","color":"dark_purple","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
