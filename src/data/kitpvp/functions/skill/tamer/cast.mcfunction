# 首行无条件推进快照，漏写会每刻连发
scoreboard players operation @s kitpvp.tamer_last = @s kitpvp.tamer_used

# 只有真的放出了自己的狼蛋才进冷却；8 格覆盖刷怪蛋右键射程（at @s 锚定后 distance 才是"附近"）。
# 放出来的狼是本职业的产品，不在这里清（game/reset 按类型清）
execute at @s if entity @e[type=minecraft:wolf,tag=kitpvp.tamer_wolf,distance=..8] run function kitpvp:skill/tamer/fire
