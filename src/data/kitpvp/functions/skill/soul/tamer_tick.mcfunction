# @s = 驯兽师魂石的 marker（每刻被 tick 调一次）
# 每 5 秒一波；20 秒到 marker 自毁。倒计时用 soul_timer / soul_next 两个独立分数
execute if score @s kitpvp.soul_next matches ..0 run function kitpvp:skill/soul/tamer_wave
execute if score @s kitpvp.soul_next matches 1.. run scoreboard players remove @s kitpvp.soul_next 1
execute if score @s kitpvp.soul_timer matches 1.. run scoreboard players remove @s kitpvp.soul_timer 1
execute if score @s kitpvp.soul_timer matches ..0 run kill @s
