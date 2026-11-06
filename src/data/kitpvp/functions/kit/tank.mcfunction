# 坦克（kit = 3）；护甲 20 由钻石装备自然提供，但**韧性要清零**：
# 写了 AttributeModifiers 就会整体覆盖物品默认修饰符，所以每件只显式写 armor，
# 钻石自带的每件 +2 韧性就随之消失（合计 8 → 0，见 04 §九）。
# 不要用 `attribute @s generic.armor_toughness base set 0`：那是玩家属性基数，被装备覆盖不了。
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 3
tag @s add kitpvp.selected

item replace entity @s armor.head with minecraft:diamond_helmet{Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.armor",Name:"kitpvp.tank_armor_head",Amount:3,Operation:0,UUID:[I;3,0,0,1],Slot:"head"}]}
item replace entity @s armor.chest with minecraft:diamond_chestplate{Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.armor",Name:"kitpvp.tank_armor_chest",Amount:8,Operation:0,UUID:[I;3,0,0,2],Slot:"chest"}]}
item replace entity @s armor.legs with minecraft:diamond_leggings{Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.armor",Name:"kitpvp.tank_armor_legs",Amount:6,Operation:0,UUID:[I;3,0,0,3],Slot:"legs"}]}
item replace entity @s armor.feet with minecraft:diamond_boots{Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.armor",Name:"kitpvp.tank_armor_feet",Amount:3,Operation:0,UUID:[I;3,0,0,4],Slot:"feet"}]}
item replace entity @s weapon.mainhand with minecraft:wooden_sword{Unbreakable:1b}
give @s minecraft:cooked_beef 24

effect give @s minecraft:slowness infinite 0 true
effect give @s minecraft:mining_fatigue infinite 0 true

scoreboard players set @s kitpvp.lives 3

function kitpvp:skill/tank/give_egg

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"坦克","color":"yellow","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
