# 站定 / 走路 / 疾跑 / 疾跑跳跃 各跑一次，看自己跳到多少，用来决定 v 取多少（判定线现在是 35）
execute as @s run function kitpvp:skill/earth/cop_blink_track
tellraw @s [{"text":"[交警] 你的速度分 = "},{"score":{"name":"@s","objective":"kitpvp.pspd"},"color":"yellow"},{"text":"（判定线 35 = 0.35 格/刻）","color":"gray"}]