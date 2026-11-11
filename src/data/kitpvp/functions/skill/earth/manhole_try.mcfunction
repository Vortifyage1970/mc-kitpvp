# @s = 井盖。装填期走完后由 tick 调进来：只有"不是埋它的人"站在正上方才会破土
# 认人只用一个分数：召唤时把召唤者的 kitpvp.mh_summoner 置 1，其余人置 0（见 summon/earth_manhole.mcfunction）
# 单人想自己踩自己埋的井盖：/scoreboard players set @s kitpvp.mh_summoner 0
tag @a remove kitpvp.mh_exempt
execute as @a[scores={kitpvp.mh_summoner=1..}] run tag @s add kitpvp.mh_exempt
execute at @s if entity @a[distance=..2.5,gamemode=!spectator,tag=!kitpvp.spectator,tag=!kitpvp.mh_exempt,nbt=!{Health:0.0f}] run function kitpvp:skill/earth/manhole_pop
tag @a remove kitpvp.mh_exempt
