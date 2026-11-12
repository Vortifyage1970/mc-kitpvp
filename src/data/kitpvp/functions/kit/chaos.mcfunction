# 混沌战士（kit = 45）：铁盔 + 锁链胸甲 + 铁护腿（护甲 -1）+ 锁链靴
# 手上永远一把"耗材"：耐久 2~4 次，用完记分板清零 → 清主手、播损坏音、无缝发下一把（见 kit/chaos_use）
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 45
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

item replace entity @s armor.head with minecraft:iron_helmet{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:chainmail_chestplate{Unbreakable:1b}
item replace entity @s armor.legs with minecraft:chainmail_leggings{Unbreakable:1b}
item replace entity @s armor.feet with minecraft:chainmail_boots{Unbreakable:1b}
scoreboard players set @s kitpvp.lives 3
function kitpvp:kit/chaos_start

give @s minecraft:cooked_beef 13
give @s minecraft:spyglass{ChaosToken:1b,Unbreakable:1b,display:{Name:'{"text":"混沌·重铸","color":"dark_purple","italic":false}',Lore:['{"text":"右键：清掉手上的武器，随机重铸一把（冷却 30 秒）","color":"dark_purple","italic":false}']}} 1
tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"混沌战士","color":"dark_purple","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
