# 地球的召唤入口：掷一只随机生灵（skill/earth/random），再认归属、进补货冷却、播报
function kitpvp:skill/earth/random

# 召唤物归属：队槽只用于"不攻击召唤者"，玩家与召唤物必须都进同一队（见 04 §五）
function kitpvp:skill/earth/link

# 首次召唤启动补货冷却（15 秒 = 300 刻）；冷却中的其他召唤不重置计时，冷却只闸补货、不闸已有蛋
execute if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.cd 300
title @s actionbar {"text":"生灵已降临","color":"blue"}
playsound minecraft:block.grass.place master @s ~ ~ ~ 0.8 1.0
