# 里·渔夫（kit = 29 = 表渔夫 7 + 22）：激流 I 三叉戟 + 保护 V·护甲 2 的无法破坏鞘翅 + 深海探索者 X 皮革靴子
# 攻击属性沿用表渔夫的折算（基础值 1 / 4 ⇒ 写 6 / -3 = 实际伤害 7 / 攻速 1.0，见 04 §九）
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 29
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

# 不穿头盔与护腿：护甲只有鞘翅 2 点 + 皮革靴子 2 点（都为 29 段 UUID）；鞘翅本身不带护甲值，靠修饰符补
item replace entity @s armor.chest with minecraft:elytra{Unbreakable:1b,Enchantments:[{id:"minecraft:protection",lvl:5}],AttributeModifiers:[{AttributeName:"generic.armor",Name:"generic.armor",Amount:2,Operation:0,UUID:[I;29,0,0,2],Slot:"chest"}]} 1
item replace entity @s armor.feet with minecraft:leather_boots{Unbreakable:1b,Enchantments:[{id:"minecraft:depth_strider",lvl:10}],AttributeModifiers:[{AttributeName:"generic.armor",Name:"generic.armor",Amount:2,Operation:0,UUID:[I;29,0,0,4],Slot:"feet"}]} 1

# 三叉戟只带激流 I（不带忠诚）：攻击属性与表渔夫逐字一致，只换附魔与 UUID
item replace entity @s weapon.mainhand with minecraft:trident{Unbreakable:1b,Enchantments:[{id:"minecraft:riptide",lvl:1}],AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:6,Operation:0,UUID:[I;29,0,0,5],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-3,Operation:0,UUID:[I;29,0,0,6],Slot:"mainhand"}]} 1

give @s minecraft:fishing_rod{Unbreakable:1b,Enchantments:[{id:"minecraft:knockback",lvl:1}]} 1
give @s minecraft:water_bucket 2
give @s minecraft:cooked_cod 30

# 两个技能各 1 个令牌（上限 1）：用掉的立刻消失，另一个由技能函数当场收走（blue_start / domain_start），
# 两边都在"整把锁走完"（cd 与 cd2 同时归零）后才由 tick 一起发回 —— 手上不会留着按不出反应的令牌
function kitpvp:skill/tainted_fisher/give_blue
function kitpvp:skill/tainted_fisher/give_domain

scoreboard players set @s kitpvp.lives 3

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"里·渔夫","color":"dark_red","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
