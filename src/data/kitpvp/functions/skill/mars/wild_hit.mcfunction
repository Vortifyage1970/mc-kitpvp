# @s = 地鸣召唤出来的生灵：2 刀直接抹杀
scoreboard players add @s kitpvp.mars_curse 1
execute if score @s kitpvp.mars_curse matches 2.. run function kitpvp:skill/mars/wild_kill
title @s actionbar {"text":"诅咒","color":"dark_red"}
