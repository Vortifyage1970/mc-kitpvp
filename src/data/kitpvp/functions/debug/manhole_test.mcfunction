# 井盖自测：/function kitpvp:debug/manhole_test
# 先在脚下埋一只（召唤会把你记成"埋它的人"），再把你从豁免里摘出去，这样你自己踩也能爆
execute at @s run function kitpvp:summon/earth_manhole
scoreboard players set @s kitpvp.mh_summoner 0
tellraw @s [{"text":"[井盖] 已在你脚下埋好，2 秒装填期过后走开再踩回来，","color":"gold"},{"text":"踩中会把你拖慢 6 秒","color":"yellow"}]
