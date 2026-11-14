# 上限 256 兜底；刷在巨人附近随机位置（先刷在巨人脚下，再 spreadplayers 撒开）
scoreboard players set #mars_wild_timer kitpvp.game 30
scoreboard players set #mars_wild kitpvp.game 0
execute store result score #mars_wild kitpvp.game if entity @e[tag=kitpvp.mars_wild]
execute if score #mars_wild kitpvp.game matches 256.. run scoreboard players set #mars_wild_timer kitpvp.game 30
# 6 选 1 的生灵
scoreboard players set #mars_pick kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #mars_pick kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #mars_pick kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #mars_pick kitpvp.game 4
scoreboard players set #mars_pick_max kitpvp.game 6
scoreboard players operation #mars_pick kitpvp.game %= #mars_pick_max kitpvp.game
execute as @e[tag=kitpvp.mars_giant,limit=1] at @s if score #mars_pick kitpvp.game matches 0 run summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.mars_wild","kitpvp.mars_wild_new"],PersistenceRequired:1b}
execute as @e[tag=kitpvp.mars_giant,limit=1] at @s if score #mars_pick kitpvp.game matches 1 run summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.mars_wild","kitpvp.mars_wild_new"],PersistenceRequired:1b}
execute as @e[tag=kitpvp.mars_giant,limit=1] at @s if score #mars_pick kitpvp.game matches 2 run summon minecraft:spider ~ ~ ~ {Tags:["kitpvp.mars_wild","kitpvp.mars_wild_new"],PersistenceRequired:1b}
execute as @e[tag=kitpvp.mars_giant,limit=1] at @s if score #mars_pick kitpvp.game matches 3 run summon minecraft:creeper ~ ~ ~ {Tags:["kitpvp.mars_wild","kitpvp.mars_wild_new"],PersistenceRequired:1b}
execute as @e[tag=kitpvp.mars_giant,limit=1] at @s if score #mars_pick kitpvp.game matches 4 run summon minecraft:sheep ~ ~ ~ {Tags:["kitpvp.mars_wild","kitpvp.mars_wild_new"],PersistenceRequired:1b}
execute as @e[tag=kitpvp.mars_giant,limit=1] at @s if score #mars_pick kitpvp.game matches 5 run summon minecraft:cow ~ ~ ~ {Tags:["kitpvp.mars_wild","kitpvp.mars_wild_new"],PersistenceRequired:1b}
execute at @e[tag=kitpvp.mars_wild_new,limit=1] run spreadplayers ~ ~ 2 8 false @e[tag=kitpvp.mars_wild_new]
tag @e[tag=kitpvp.mars_wild_new] remove kitpvp.mars_wild_new
