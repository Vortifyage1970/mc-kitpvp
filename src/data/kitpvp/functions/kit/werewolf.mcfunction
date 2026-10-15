# 狼人（kit = 18）：石斧「嗜血狼牙」+ 嗅闻令牌；命中与击杀的被动由 advancement 驱动
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 18
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3
scoreboard players set @s kitpvp.werewolf_hit_cd 0

# 灰色皮革 8421504 = 0x808080
item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,display:{color:8421504}} 1
item replace entity @s armor.chest with minecraft:chainmail_chestplate{Unbreakable:1b} 1
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b,display:{color:8421504}} 1
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b} 1

# 嗜血狼牙：实际伤害 5.5 / 攻速 1.4（玩家基础值 1 / 4，故写 4.5 / -2.6，见 04 §九）
item replace entity @s hotbar.0 with minecraft:stone_axe{KitWerewolfAxe:1b,Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:4.5,Operation:0,UUID:[I;18,0,0,1],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-2.6,Operation:0,UUID:[I;18,0,0,2],Slot:"mainhand"}],display:{Name:'{"text":"嗜血狼牙","color":"gray"}'}} 1
item replace entity @s hotbar.1 with minecraft:mutton 8

# 开局 2 个令牌（持有上限 2，与 skill/werewolf/auto 的补货闸门一致）
function kitpvp:skill/werewolf/give_egg
function kitpvp:skill/werewolf/give_egg

tellraw @s [{"text":"[职业] ","color":"aqua","bold":true},{"text":"已选择 ","color":"gray"},{"text":"狼人","color":"yellow","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
