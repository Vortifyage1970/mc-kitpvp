# 首行推进快照；只给 1 支箭，不清玩家已有的箭
scoreboard players operation @s kitpvp.soul_archer_last = @s kitpvp.soul_archer_used

# 骷髅蛋还有第二个来源（里·驯兽师的骸骨仆从令牌）：只有真的刷出了魂石骷髅才给效果（见 04 §五）
execute at @s if entity @e[type=minecraft:skeleton,name="弓箭手魂石",distance=..8] run function kitpvp:skill/soul/archer_apply

execute at @s run kill @e[type=minecraft:skeleton,name="弓箭手魂石"]
