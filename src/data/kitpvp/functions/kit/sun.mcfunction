# 太阳（kit 65）：全套金装 + 火焰附加 I 金剑（实际伤害 4）+ 火矢 I 弓（日冕物质抛射，换弹 3 发）+ 两个上限 1 的令牌。
# 被动"免疫一切状态效果"由 tick 每刻调 skill/sun/passive 施加，不在这里挂（重生后也一样，不用补挂）。
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 65
tag @s add kitpvp.selected
tag @s add kitpvp.arrow_user
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

item replace entity @s armor.head with minecraft:golden_helmet{Unbreakable:1b} 1
item replace entity @s armor.chest with minecraft:golden_chestplate{Unbreakable:1b} 1
item replace entity @s armor.legs with minecraft:golden_leggings{Unbreakable:1b} 1
item replace entity @s armor.feet with minecraft:golden_boots{Unbreakable:1b} 1

item replace entity @s weapon.mainhand with minecraft:golden_sword{Unbreakable:1b,Enchantments:[{id:"minecraft:fire_aspect",lvl:1}]} 1
function kitpvp:skill/sun/give_bow
give @s minecraft:arrow 3

give @s minecraft:cooked_chicken 24

# 开局两个技能各 1 个令牌（持有上限 1，与 tick 的发回闸门一致）
function kitpvp:skill/sun/give_flare
function kitpvp:skill/sun/give_spot

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"太阳","color":"yellow","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
