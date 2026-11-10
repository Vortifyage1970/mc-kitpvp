# 驯兽师魂石：首行推进快照（cat 蛋只在本魂石里发）
scoreboard players operation @s kitpvp.soul_tamer_last = @s kitpvp.soul_tamer_used

# 必须 `at @s at @e[...]` 两段：tick 里是 `as @a ... run function` 进来的，执行位置还在世界出生点
execute at @s at @e[tag=kitpvp.soul_tamer_token,distance=..8,sort=nearest,limit=1] run function kitpvp:skill/soul/tamer_apply

execute at @s run kill @e[tag=kitpvp.soul_tamer_token]
