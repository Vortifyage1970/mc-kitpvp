# @s = 反装甲步兵的炮弹（as @s at @s）
# 浅抛物线：水平每刻 1.2 格（约 24 格/秒）朝落点，竖直按速度表 0.30 每刻 -0.05 递减，
# 17 刻左右正好落回炮口高度（20 格射程约 1.7 格落差）
# 每个 tp 都必须先 `at @s`：函数里的 ~ / ^ 取的是"函数开始那一刻"的坐标快照，
# 不重取就会变成"每刻从炮口重新飞一次"，看起来原地悬停（迫击炮踩过这个坑）
scoreboard players add @s kitpvp.at_life 1

# 水平：只沿水平朝向走，避免 `^` 顺着俯角往下扎（那样水平行程会被吃掉一截）
execute if entity @e[tag=kitpvp.at_aim,limit=1,sort=nearest] at @s run tp @s ~ ~ ~ facing entity @e[tag=kitpvp.at_aim,limit=1,sort=nearest] eyes
execute if entity @e[tag=kitpvp.at_aim,limit=1,sort=nearest] at @s rotated ~ 0 run tp @s ^ ^ ^1.2

# 竖直：一条对称的下行曲线（先升到约 +0.9 再落回来），和迫击炮一样查表
execute if score @s kitpvp.at_life matches 1 at @s run tp @s ~ ~0.30 ~
execute if score @s kitpvp.at_life matches 2 at @s run tp @s ~ ~0.25 ~
execute if score @s kitpvp.at_life matches 3 at @s run tp @s ~ ~0.20 ~
execute if score @s kitpvp.at_life matches 4 at @s run tp @s ~ ~0.15 ~
execute if score @s kitpvp.at_life matches 5 at @s run tp @s ~ ~0.10 ~
execute if score @s kitpvp.at_life matches 6 at @s run tp @s ~ ~0.05 ~
execute if score @s kitpvp.at_life matches 7 at @s run tp @s ~ ~0.00 ~
execute if score @s kitpvp.at_life matches 8 at @s run tp @s ~ ~-0.05 ~
execute if score @s kitpvp.at_life matches 9 at @s run tp @s ~ ~-0.10 ~
execute if score @s kitpvp.at_life matches 10 at @s run tp @s ~ ~-0.15 ~
execute if score @s kitpvp.at_life matches 11 at @s run tp @s ~ ~-0.20 ~
execute if score @s kitpvp.at_life matches 12 at @s run tp @s ~ ~-0.25 ~
execute if score @s kitpvp.at_life matches 13 at @s run tp @s ~ ~-0.30 ~
execute if score @s kitpvp.at_life matches 14 at @s run tp @s ~ ~-0.35 ~
execute if score @s kitpvp.at_life matches 15 at @s run tp @s ~ ~-0.40 ~
execute if score @s kitpvp.at_life matches 16 at @s run tp @s ~ ~-0.45 ~
execute if score @s kitpvp.at_life matches 17 at @s run tp @s ~ ~-0.50 ~
execute if score @s kitpvp.at_life matches 18 at @s run tp @s ~ ~-0.55 ~
execute if score @s kitpvp.at_life matches 19 at @s run tp @s ~ ~-0.60 ~
execute if score @s kitpvp.at_life matches 20.. at @s run tp @s ~ ~-0.65 ~

particle minecraft:flame ~ ~ ~ 0.08 0.08 0.08 0.01 3 force
particle minecraft:smoke ~ ~ ~ 0.08 0.08 0.08 0.005 2 force

# 引爆：落点 0.8 格内 / 撞方块 / 飞 40 刻兜底
execute at @e[tag=kitpvp.at_aim,limit=1,sort=nearest] if entity @s[distance=..0.8] run function kitpvp:skill/earth/antitank_burst
execute at @s unless block ~ ~ ~ minecraft:air unless block ~ ~ ~ minecraft:cave_air unless block ~ ~ ~ minecraft:void_air run function kitpvp:skill/earth/antitank_burst
execute if score @s kitpvp.at_life matches 40.. run function kitpvp:skill/earth/antitank_burst
