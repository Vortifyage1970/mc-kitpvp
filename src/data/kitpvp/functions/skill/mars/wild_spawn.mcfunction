# 在巨人处召一只「地球职业同款」的生灵（33 种随机），并打上 mars_wild 便于 2 刀抹杀与收尾
scoreboard players set #mars_wild_timer kitpvp.game 30
scoreboard players set #mars_wild kitpvp.game 0
execute store result score #mars_wild kitpvp.game if entity @e[tag=kitpvp.mars_wild]
# 上限 256 兜底
execute if score #mars_wild kitpvp.game matches ..255 as @e[tag=kitpvp.mars_giant,limit=1] at @s run function kitpvp:skill/earth/random
execute if score #mars_wild kitpvp.game matches ..255 as @e[tag=kitpvp.mars_giant,limit=1] at @s run tag @e[tag=kitpvp.earth_minion,tag=!kitpvp.mars_wild,distance=..4,sort=nearest,limit=1] add kitpvp.mars_wild
