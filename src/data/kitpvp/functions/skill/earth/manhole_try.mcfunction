# @s = 井盖。装填期走完后由 tick 调进来：只有"不属于召唤者"的人站在正上方才会破土
# 两种认人口径：earth_owner/etid（正常召唤）、mh_summoner 分（手动 function 召唤时靠它顶上）
tag @a remove kitpvp.mh_exempt
scoreboard players set #mh_own kitpvp.game 0
scoreboard players operation #mh_own kitpvp.game = @s kitpvp.earth_owner
execute if score #mh_own kitpvp.game matches 1.. as @a if score @s kitpvp.etid = #mh_own kitpvp.game run tag @s add kitpvp.mh_exempt
execute as @a if score @s kitpvp.mh_summoner matches 1 run tag @s add kitpvp.mh_exempt
execute at @s if entity @a[distance=..2.5,gamemode=!spectator,tag=!kitpvp.spectator,tag=!kitpvp.mh_exempt,nbt=!{Health:0.0f}] run function kitpvp:skill/earth/manhole_pop
tag @a remove kitpvp.mh_exempt
