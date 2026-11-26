# 附魔师计时：每刻 -1，到 0 就强化一次；同时算 bossbar 的 0..1000 进度
scoreboard players remove @s kitpvp.ench_timer 1
execute if score @s kitpvp.ench_timer matches ..0 run function kitpvp:skill/enchanter/upgrade

# 进度 = (总周期 - 剩余) * 1000 / 总周期
scoreboard players operation @s kitpvp.ench_pct = @s kitpvp.ench_period
scoreboard players operation @s kitpvp.ench_pct -= @s kitpvp.ench_timer
scoreboard players operation @s kitpvp.ench_pct *= #ench_thousand kitpvp.game
scoreboard players operation @s kitpvp.ench_pct /= @s kitpvp.ench_period
execute if score @s kitpvp.ench_roll matches 11 run scoreboard players set @s kitpvp.ench_pct 1000
execute if score @s kitpvp.ench_pct matches 1001.. run scoreboard players set @s kitpvp.ench_pct 1000
execute if score @s kitpvp.ench_pct matches ..-1 run scoreboard players set @s kitpvp.ench_pct 0
