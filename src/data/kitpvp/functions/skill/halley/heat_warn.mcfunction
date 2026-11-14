# 45 秒到了：提示 + 开始 15 秒倒计时
scoreboard players set @s kitpvp.halley_heat 0
scoreboard players set @s kitpvp.halley_pending 300
# 只发给哈雷本人（tellraw @s 本来就是私聊，这里再显式限定一次，避免以后被改成 @a）
execute if entity @s[scores={kitpvp.kit=69}] run tellraw @s [{"text":"温度升高......","color":"gold"}]
playsound minecraft:block.fire.ambient master @s ~ ~ ~ 0.8 1.4
