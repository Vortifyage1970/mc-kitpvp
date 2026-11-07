# @s = 挨打的那个玩家（tick 判定"挨打帧 + 3 格内有制图台"后调进来，带 at @s）
# 只发给被打的这个人（tellraw @s）：旁人看不到，也不会刷屏
# 10 刻冷却：连击时不会一秒刷十条
scoreboard players set @s kitpvp.earth_cd_a 10
scoreboard players set @s kitpvp.rng 0
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 1
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 2
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 4
execute if score @s kitpvp.rng matches 0 run tellraw @s [{"text":"制图台提醒您 ","color":"white"},{"text":"pid=151751776","color":"gray","italic":true}]
execute if score @s kitpvp.rng matches 1 run tellraw @s [{"text":"制图台提醒您 ","color":"white"},{"text":"pid=150659086","color":"gray","italic":true}]
execute if score @s kitpvp.rng matches 2 run tellraw @s [{"text":"制图台提醒您 ","color":"white"},{"text":"pid=144100942","color":"gray","italic":true}]
execute if score @s kitpvp.rng matches 3 run tellraw @s [{"text":"制图台提醒您 ","color":"white"},{"text":"pid=146076100","color":"gray","italic":true}]
execute if score @s kitpvp.rng matches 4 run tellraw @s [{"text":"制图台提醒您 ","color":"white"},{"text":"pid=144473891","color":"gray","italic":true}]
execute if score @s kitpvp.rng matches 5 run tellraw @s [{"text":"制图台提醒您 ","color":"white"},{"text":"pid=141875197","color":"gray","italic":true}]
execute if score @s kitpvp.rng matches 6 run tellraw @s [{"text":"制图台提醒您 ","color":"white"},{"text":"pid=145192063","color":"gray","italic":true}]
execute if score @s kitpvp.rng matches 7 run tellraw @s [{"text":"制图台提醒您 ","color":"white"},{"text":"该作品已删除或不公开","color":"red","italic":true}]
playsound minecraft:block.cartography_table.use master @s ~ ~ ~ 0.8 1.0
