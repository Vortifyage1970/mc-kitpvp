# 药剂师（kit = 12）；绿色皮革 + 铁胸甲，两套药剂分别走 skill/alchemist 的投掷与饮用链路
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 12
tag @s add kitpvp.selected

item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,display:{color:3046706}}
item replace entity @s armor.chest with minecraft:iron_chestplate{Unbreakable:1b}
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b,display:{color:3046706}}
item replace entity @s armor.feet with minecraft:leather_boots{Unbreakable:1b,display:{color:3046706}}

item replace entity @s weapon.mainhand with minecraft:stone_sword{Unbreakable:1b}

give @s minecraft:cooked_beef 24

scoreboard players set @s kitpvp.cd 0
tag @s remove kitpvp.alchemist_elixir_used
function kitpvp:skill/alchemist/give_splash
function kitpvp:skill/alchemist/give_elixir

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"药剂师","color":"dark_green","bold":true}]
