# @s = 玩家：把这一对串联体里离 @s 最近的那节上缓慢 III，另一节清掉
# 用 sort=nearest / sort=furthest 分工，避免算距离；每刻刷新，效果只挂 1 秒所以离开范围会自然过期
execute as @e[tag=kitpvp.earth_tanden,distance=..40,sort=nearest,limit=1] run effect give @s minecraft:slowness 1 2 true
execute as @e[tag=kitpvp.earth_tanden,distance=..40,sort=furthest,limit=1] run effect clear @s minecraft:slowness
