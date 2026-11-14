# 400 → 0；巨人被提前打死也收场（否则歌会空放）
execute unless entity @e[tag=kitpvp.soul_mars_giant] run function kitpvp:skill/soul/mars_expire
execute if score @s kitpvp.soul_mars_timer matches 1.. run scoreboard players remove @s kitpvp.soul_mars_timer 1
execute if score @s kitpvp.soul_mars_timer matches ..0 run function kitpvp:skill/soul/mars_expire
