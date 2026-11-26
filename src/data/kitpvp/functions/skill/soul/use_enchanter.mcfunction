# 附魔师魂石：用一次，给"手里的武器 + 头胸腿靴"套上 20 秒的五级附魔，到点自动还原
# 铁律：首行推进 last，否则每刻都会重复触发
scoreboard players operation @s kitpvp.soul_enchanter_last = @s kitpvp.soul_enchanter_used
# 牛蛋是这颗魂石的载体（魂石都是"用掉的瞬间刷一只同名生物"来判定），别改成会打人的生物
execute at @s if entity @e[type=minecraft:cow,name="附魔师魂石",distance=..8] run function kitpvp:skill/soul/enchanter_apply
execute at @s run kill @e[type=minecraft:cow,name="附魔师魂石"]
