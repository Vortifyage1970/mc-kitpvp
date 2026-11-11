# 水星（kit = 66）：青色皮革套 + 石剑（实际伤害 5 / 攻速 2.4），常态 +0.2 移速走 skill/mercury/passive
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 66
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

# 青色皮革 1481884（= 0x169C9C）；护甲 7 全由皮革自然提供，不额外 set attribute（否则翻倍）
item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,display:{color:1481884}}
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:1481884}}
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b,display:{color:1481884}}
# 深海探索者 X 与原版上限 III 无关：附魔等级在 NBT 里没有上限
item replace entity @s armor.feet with minecraft:leather_boots{Unbreakable:1b,display:{color:1481884},Enchantments:[{id:"minecraft:protection",lvl:3},{id:"minecraft:depth_strider",lvl:10}]}

# 写 AttributeModifiers 会整体取代默认修饰符，所以攻速也必须显式写：
# 伤害 5（基础 1 + 4）、攻速 2.4（基础 4 - 1.6）。最大生命 -7 改成**常态**，写在 skill/mercury/passive
item replace entity @s weapon.mainhand with minecraft:stone_sword{Unbreakable:1b,AttributeModifiers:[{AttributeName:"minecraft:generic.attack_damage",Name:"kitpvp.mercury_damage",Amount:4.0,Operation:0,UUID:[I;66,0,0,1],Slot:"mainhand"},{AttributeName:"minecraft:generic.attack_speed",Name:"kitpvp.mercury_attack_speed",Amount:-1.6,Operation:0,UUID:[I;66,0,0,2],Slot:"mainhand"}]}

# 幂等：先清掉背包里已有的水桶再发。重选职业 / 走随机池都可能让本函数再跑一遍，
# 不清就会出现两个水桶（04 §五：发东西一律先清再发）
clear @s minecraft:water_bucket
give @s minecraft:water_bucket 1
give @s minecraft:cooked_cod 16

function kitpvp:skill/mercury/passive

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"水星","color":"aqua","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
