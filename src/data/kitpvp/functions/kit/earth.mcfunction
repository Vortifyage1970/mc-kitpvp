# 地球（kit = 68）：铁头盔 + 高饱和蓝皮革胸甲（荆棘 II）+ 钻石护腿 + 铁靴子；锋利 III 工作台
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 68
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

# 高饱和蓝 26367（= 0x0066FF）；荆棘 II 是原版上限内（上限 III）
item replace entity @s armor.head with minecraft:iron_helmet{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:26367},Enchantments:[{id:"minecraft:thorns",lvl:2}]}
item replace entity @s armor.legs with minecraft:diamond_leggings{Unbreakable:1b}
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b}

# 工作台没有攻击修饰符：基础 1 + 锋利 III 的 2 = 3
item replace entity @s weapon.mainhand with minecraft:crafting_table{KitEarthTable:1b,Enchantments:[{id:"minecraft:sharpness",lvl:3}]}
give @s minecraft:cooked_porkchop 24

scoreboard players set @s kitpvp.cd 0
function kitpvp:skill/earth/give_egg
function kitpvp:skill/earth/give_egg
function kitpvp:skill/earth/give_egg

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"地球","color":"blue","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
