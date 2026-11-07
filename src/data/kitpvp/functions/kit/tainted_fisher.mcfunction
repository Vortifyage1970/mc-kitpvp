# 里·渔夫（kit 29）：激流 I 三叉戟（实际伤害 5 / 攻速 1.0，按 04 §九折算）+ 保护 V 鞘翅 + 深海探索者 X 皮革靴子
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 29
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

# 不穿头盔与护腿：护甲全在鞘翅与靴子上（鞘翅没有自带护甲，靠修饰符补）——鞘翅 3 + 靴子 2 = 5
item replace entity @s armor.chest with minecraft:elytra{Unbreakable:1b,Enchantments:[{id:"minecraft:protection",lvl:5}],AttributeModifiers:[{AttributeName:"generic.armor",Name:"generic.armor",Amount:3,Operation:0,UUID:[I;29,0,0,2],Slot:"chest"}]} 1
item replace entity @s armor.feet with minecraft:leather_boots{Unbreakable:1b,Enchantments:[{id:"minecraft:depth_strider",lvl:10}],AttributeModifiers:[{AttributeName:"generic.armor",Name:"generic.armor",Amount:2,Operation:0,UUID:[I;29,0,0,4],Slot:"feet"}]} 1

# 三叉戟只带激流 I（不带忠诚）
item replace entity @s weapon.mainhand with minecraft:trident{Unbreakable:1b,Enchantments:[{id:"minecraft:riptide",lvl:1}],AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:4,Operation:0,UUID:[I;29,0,0,5],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-3.0,Operation:0,UUID:[I;29,0,0,6],Slot:"mainhand"}]} 1

give @s minecraft:fishing_rod{Unbreakable:1b,Enchantments:[{id:"minecraft:knockback",lvl:1}]} 1
give @s minecraft:cooked_cod 24

# 各 1 个令牌：用掉即消失，另一个由技能函数当场收走，整把锁走完后由 tick 一起发回（见 04 §四）
function kitpvp:skill/tainted_fisher/give_blue
function kitpvp:skill/tainted_fisher/give_domain

scoreboard players set @s kitpvp.lives 3

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"里·渔夫","color":"dark_red","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
