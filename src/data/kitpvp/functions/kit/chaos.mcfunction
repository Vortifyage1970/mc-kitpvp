# 混沌战士（kit = 45）：没有任何专属装备，只有一双手和一堆"耗材武器"
# 武器耐久只有 2~4 次；碎掉后手会空，下一次命中时随机换一把新的（见 kit/chaos_hit）
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 45
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,display:{color:1638400}}
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:1638400}}
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b,display:{color:1638400}}
item replace entity @s armor.feet with minecraft:leather_boots{Unbreakable:1b,display:{color:1638400}}
give @s minecraft:cooked_beef 12

scoreboard players set @s kitpvp.lives 3
function kitpvp:kit/chaos_start

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"混沌战士","color":"dark_purple","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
