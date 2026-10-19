# 单句中招者：上 tag + 5 秒读秒，文案由 flare_tick 每 10 刻刷一帧
tag @s add kitpvp.sun_flare
effect give @s minecraft:nausea 10 0 true
scoreboard players set @s kitpvp.sun_flare_timer 100
playsound minecraft:block.beacon.deactivate master @s ~ ~ ~ 1.0 0.7
