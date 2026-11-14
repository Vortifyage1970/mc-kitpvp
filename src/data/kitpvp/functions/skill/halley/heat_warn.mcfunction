# 45 秒到了：提示 + 开始 15 秒倒计时
scoreboard players set @s kitpvp.halley_heat 0
scoreboard players set @s kitpvp.halley_pending 300
tellraw @s [{"text":"温度升高......","color":"gold"}]
playsound minecraft:block.fire.ambient master @s ~ ~ ~ 0.8 1.4
