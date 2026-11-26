# 照 skill/mars/wild_spawn：在巨人处召一只「地球职业同款」生灵（33 种随机），打 soul_mars_wild 便于收尾
scoreboard players set #soul_mars_wild_timer kitpvp.game 24
scoreboard players set #soul_mars_wild kitpvp.game 0
execute store result score #soul_mars_wild kitpvp.game if entity @e[tag=kitpvp.soul_mars_wild]
# 上限 256 兜底（20 秒最多刷 16 只，这里只是防手滑）
execute if score #soul_mars_wild kitpvp.game matches ..255 as @e[tag=kitpvp.soul_mars_giant,limit=1] at @s run function kitpvp:skill/earth/random
execute if score #soul_mars_wild kitpvp.game matches ..255 as @e[tag=kitpvp.soul_mars_giant,limit=1] at @s run tag @e[tag=kitpvp.earth_minion,tag=!kitpvp.soul_mars_wild,tag=!kitpvp.mars_wild,distance=..4,sort=nearest,limit=1] add kitpvp.soul_mars_wild
