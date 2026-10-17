# 刷新节拍 = 读秒的 10 刻整点（每刻刷太吵；跳刻最多漏一帧）
scoreboard players set #noise_step kitpvp.game 10
scoreboard players operation @s kitpvp.tmp = @s kitpvp.sun_flare_timer
scoreboard players operation @s kitpvp.tmp %= #noise_step kitpvp.game
execute if score @s kitpvp.tmp matches 0 if score @s kitpvp.sun_flare_timer matches 1.. run function kitpvp:skill/sun/noise_pick

scoreboard players remove @s kitpvp.sun_flare_timer 1
execute if score @s kitpvp.sun_flare_timer matches ..0 run function kitpvp:skill/sun/flare_end
