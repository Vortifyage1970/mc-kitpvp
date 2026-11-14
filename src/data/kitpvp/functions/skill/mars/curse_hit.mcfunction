# @s = 被诅咒剑命中的目标：累计 4 刀上整套诅咒
scoreboard players add @s kitpvp.mars_curse 1
particle minecraft:enchanted_hit ~ ~1 ~ 0.4 0.5 0.4 0.1 8 normal
execute if score @s kitpvp.mars_curse matches 4.. run function kitpvp:skill/mars/curse
