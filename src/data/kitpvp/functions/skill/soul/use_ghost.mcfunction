# 首行推进 last，漏写会每刻重复触发（铁律）
scoreboard players operation @s kitpvp.soul_ghost_last = @s kitpvp.soul_ghost_used

# 恼鬼蛋还有第二个来源（里·驯兽师的怨灵仆从令牌）：只有真的刷出了幽灵魂石才给效果（见 04 §五）
execute at @s if entity @e[type=minecraft:vex,name="幽灵魂石",distance=..8] run function kitpvp:skill/soul/ghost_apply

execute at @s run kill @e[type=vex,name="幽灵魂石"]
