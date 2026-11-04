# 到点只收回"自己铺的那格细雪"：玩家在这段时间里换过方块就跳过，别把人放的东西删了
execute if block ~ ~ ~ minecraft:powder_snow run setblock ~ ~ ~ minecraft:air
kill @s
