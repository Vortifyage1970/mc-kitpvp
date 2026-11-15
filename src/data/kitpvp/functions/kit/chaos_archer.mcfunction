# 混沌弓箭手（kit = 46）：只有一张弓——锋利 IV 当近战、冲击 I 当远程；拿弓时移速 -0.5
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 46
tag @s add kitpvp.selected
tag @s add kitpvp.arrow_user
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,display:{color:2186785}}
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:2186785}}

# 弓：Unbreakable + 力量 I + 锋利 IV（没有近战武器，靠近战判定吃锋利）+ 持弓移速 -0.5
item replace entity @s weapon.mainhand with minecraft:bow{Unbreakable:1b,Enchantments:[{id:"minecraft:punch",lvl:1},{id:"minecraft:sharpness",lvl:4}],AttributeModifiers:[{AttributeName:"minecraft:generic.movement_speed",Name:"kitpvp.archer_heavy",Amount:-0.5,Operation:1,UUID:[I;46,0,1,1],Slot:"mainhand"},{AttributeName:"minecraft:generic.movement_speed",Name:"kitpvp.archer_heavy_off",Amount:-0.5,Operation:1,UUID:[I;46,0,1,2],Slot:"offhand"}]} 1

give @s minecraft:carrot 32

# 开局先装填一支
function kitpvp:skill/chaos_archer/arrow

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"混沌弓箭手","color":"light_purple","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
