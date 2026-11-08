# @s = 反装甲步兵的炮弹（as @s at @s）
# 直线飞向落点眼睛高度，每刻 1.2 格（约 24 格/秒，迫击炮的鱼最快才 0.55 格/刻）
# 每个 tp 都必须先 `at @s`：函数里的 ~ / ^ 取的是"函数开始那一刻"的坐标快照，
# 不重取就会变成"每刻从炮口重新飞一次"，看起来原地悬停（迫击炮踩过这个坑）
scoreboard players add @s kitpvp.at_life 1
execute if entity @e[tag=kitpvp.at_aim,limit=1] at @s run tp @s ~ ~ ~ facing entity @e[tag=kitpvp.at_aim,limit=1] eyes
execute if entity @e[tag=kitpvp.at_aim,limit=1] at @s run tp @s ^ ^ ^1.2
particle minecraft:flame ~ ~ ~ 0.08 0.08 0.08 0.01 3 force
particle minecraft:smoke ~ ~ ~ 0.08 0.08 0.08 0.005 2 force

# 引爆：撞方块 / 贴到落点 1.5 格内 / 飞了 40 刻还没到头（兜底，避免打穿地图）
execute at @s unless block ~ ~ ~ minecraft:air unless block ~ ~ ~ minecraft:cave_air unless block ~ ~ ~ minecraft:void_air run function kitpvp:skill/earth/antitank_burst
execute at @e[tag=kitpvp.at_aim,limit=1] if entity @s[distance=..1.5] run function kitpvp:skill/earth/antitank_burst
execute if score @s kitpvp.at_life matches 40.. run function kitpvp:skill/earth/antitank_burst
