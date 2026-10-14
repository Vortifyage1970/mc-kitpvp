# 战士魂石与里·弓箭手的熔火核心令牌共用 blaze_spawn_egg，靠生成生物的自定义名分流（同 skill/tank/dispatch）
# ⚠ 首行必须**无条件**推进快照：漏写或只在名字匹配时推进，会让"用了另一种蛋"的那次积压着，
#   下次用真魂石之前就提前触发（也可能反过来把熔火核心的令牌当成魂石）
scoreboard players operation @s kitpvp.soul_warrior_last = @s kitpvp.soul_warrior_used

execute at @s if entity @e[type=minecraft:blaze,name="战士魂石",distance=..8] run function kitpvp:skill/soul/use_warrior
