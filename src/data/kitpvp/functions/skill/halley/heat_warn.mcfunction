# 45 秒到了：提示 + 开始 15 秒倒计时
scoreboard players set @s kitpvp.halley_heat 0
scoreboard players set @s kitpvp.halley_pending 300
# 全服广播：这是"哈雷正在升温"的世界事件，所有人都该看到是谁在发热
tellraw @a [{"selector":"@s"},{"text":" 温度升高......","color":"gold"}]
playsound minecraft:block.fire.ambient master @s ~ ~ ~ 0.8 1.4
