# 里·末影人（kit = 33）：铁盔 + 紫黑皮革胸/腿 + 纯黑皮革靴（摔落保护 V）；铁剑 + 传送枪
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 33
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

item replace entity @s armor.head with minecraft:iron_helmet{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:2820927}}
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b,display:{color:2820927}}
item replace entity @s armor.feet with minecraft:leather_boots{Unbreakable:1b,display:{color:0},Enchantments:[{id:"minecraft:feather_falling",lvl:5}]}
item replace entity @s weapon.mainhand with minecraft:iron_sword{Unbreakable:1b}
give @s minecraft:cooked_beef 12
give @s minecraft:chorus_fruit 24
give @s minecraft:spyglass{KitPortalGun:1b,Unbreakable:1b,display:{Name:'{"text":"传送枪","color":"light_purple"}'}} 1

scoreboard players set @s kitpvp.lives 3
scoreboard players set @s kitpvp.tep_cd 0
scoreboard players set @s kitpvp.tep_ready 0
scoreboard players set @s kitpvp.tep_step 0

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"里·末影人","color":"dark_purple","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
