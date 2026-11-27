# 汉堡小子（kit = 89，抽象）：金胸甲 + 金靴子，头/腿留空；金剑 + 熟鸡肉 x24
# 技能：按住 Shift 蓄力，进度用自己的 bossbar 显示；每满 1 秒一声提示音；
# 蓄到 25 秒全场提示一次，蓄满 50 秒在随机存活玩家处召唤「汉堡兽」（对所有玩家敌对，含召唤者）
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 89
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

item replace entity @s armor.head with minecraft:air
item replace entity @s armor.chest with minecraft:golden_chestplate{Unbreakable:1b,Trim:{material:"minecraft:copper",pattern:"minecraft:snout"}}
item replace entity @s armor.legs with minecraft:air
item replace entity @s armor.feet with minecraft:golden_boots{Unbreakable:1b,Trim:{material:"minecraft:copper",pattern:"minecraft:snout"}}

item replace entity @s weapon.mainhand with minecraft:golden_sword{Unbreakable:1b} 1
give @s minecraft:cooked_chicken 24

scoreboard players set @s kitpvp.burger_charge 0
scoreboard players set @s kitpvp.burger_snd 20
scoreboard players set @s kitpvp.burger_announced 0
function kitpvp:skill/burger/assign_slot

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"汉堡小子","color":"light_purple","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
