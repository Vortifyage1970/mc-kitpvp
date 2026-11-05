# 站定 / 走路 / 疾跑 / 疾跑跳 / 喝速度药水 各跑一次，看分跳到多少（判定线 900）
# 分是 (格/刻 x100)² 的和：走路 ~467、疾跑 ~784、疾跑跳 ~1225、速度 I 疾跑 ~1129
execute as @s run function kitpvp:skill/earth/cop_blink_track
tellraw @s [{"text":"[交警] 速度分 = "},{"score":{"name":"@s","objective":"kitpvp.pspd"},"color":"yellow"},{"text":"（判定线 900 = 0.30 格/刻；dx=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.pdx"},"color":"gray"},{"text":" dz=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.pdz"},"color":"gray"},{"text":"）","color":"gray"}]