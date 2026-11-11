# 金星魂石：首行推进快照（ocelot 蛋只在本魂石里发）
scoreboard players operation @s kitpvp.soul_venus_last = @s kitpvp.soul_venus_used

# 先把执行位置落到玩家身上（理由同 use_tamer）
execute at @s run function kitpvp:skill/soul/venus_at
