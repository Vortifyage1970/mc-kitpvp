# 里·弓箭手（kit = 24）：石斧「小锤40」+ 四发箭的弓 + 炮台 / 熔火核心
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 24
tag @s add kitpvp.selected
tag @s add kitpvp.arrow_user
scoreboard players set @s kitpvp.alive 1

# 暗红皮革 11141120 = 0xAA0000
item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,display:{color:11141120},Enchantments:[{id:"minecraft:protection",lvl:2}]} 1
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:11141120},Enchantments:[{id:"minecraft:protection",lvl:2}]} 1
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b,display:{color:11141120},Enchantments:[{id:"minecraft:protection",lvl:1}]} 1
item replace entity @s armor.feet with minecraft:leather_boots{Unbreakable:1b,display:{color:11141120},Enchantments:[{id:"minecraft:protection",lvl:1}]} 1

# 小锤40：实际伤害 4.4 / 攻速 1.3（玩家基础值 1 / 4，故写 3.4 / -2.7，见 04 §九）
item replace entity @s weapon.mainhand with minecraft:stone_axe{KitTaintAxe:1b,Unbreakable:1b,AttributeModifiers:[{AttributeName:"minecraft:generic.attack_damage",Name:"kitpvp.taint_axe_damage",Amount:3.4,Operation:0,UUID:[I;24,0,0,1],Slot:"mainhand"},{AttributeName:"minecraft:generic.attack_speed",Name:"kitpvp.taint_axe_speed",Amount:-2.7,Operation:0,UUID:[I;24,0,0,2],Slot:"mainhand"}],display:{Name:'{"text":"小锤40","color":"gold"}'}} 1

give @s minecraft:cooked_beef 18
function kitpvp:skill/taint_archer/give_bow
give @s minecraft:arrow 4

# 开局 3 个令牌（持有上限 3，与 tick 的补货闸门一致）
function kitpvp:skill/taint_archer/give_token_turret
function kitpvp:skill/taint_archer/give_token_turret
function kitpvp:skill/taint_archer/give_token_turret
function kitpvp:skill/taint_archer/give_token_core

# 炮台队槽惰性分配：拿到本局第一个未占用的槽（游标循环 1..6）
execute if score @s kitpvp.ttid matches 0 run scoreboard players add #ttid kitpvp.game 1
execute if score @s kitpvp.ttid matches 0 if score #ttid kitpvp.game matches 7.. run scoreboard players set #ttid kitpvp.game 1
execute if score @s kitpvp.ttid matches 0 run scoreboard players operation @s kitpvp.ttid = #ttid kitpvp.game

scoreboard players set @s kitpvp.lives 3

tellraw @s [{"text":"[职业] ","color":"dark_red","bold":true},{"text":"已选择 ","color":"gray"},{"text":"里·弓箭手","color":"yellow","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
