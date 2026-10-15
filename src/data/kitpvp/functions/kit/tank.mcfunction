# 坦克（kit = 3）；护甲 20 / 韧性 8 由钻石装备自然提供，不额外 set attribute（否则翻倍）
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 3
tag @s add kitpvp.selected

item replace entity @s armor.head with minecraft:diamond_helmet{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:diamond_chestplate{Unbreakable:1b}
item replace entity @s armor.legs with minecraft:diamond_leggings{Unbreakable:1b}
item replace entity @s armor.feet with minecraft:diamond_boots{Unbreakable:1b}
item replace entity @s weapon.mainhand with minecraft:wooden_sword{Unbreakable:1b}
give @s minecraft:cooked_beef 24

effect give @s minecraft:slowness infinite 0 true
effect give @s minecraft:mining_fatigue infinite 0 true

scoreboard players set @s kitpvp.lives 3

function kitpvp:skill/tank/give_egg

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"坦克","color":"yellow","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
