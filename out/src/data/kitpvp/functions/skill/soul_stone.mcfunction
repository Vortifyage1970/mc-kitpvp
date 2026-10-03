# ===== 魂石：给一个玩家随机发一个（@s = 单个玩家）=====
# 随机方案：位随机 + 取模
#   1. 用同一个 kitpvp:random/1in2 谓词连掷 10 次 → 0..1023
#      每次调用 predicate 都重新采样，10 次即 10 个独立比特
#   2. 对 #soul_count 取模 → 0..N-1
#   3. 分派表逐行匹配
# 加新魂石只需：a) 追加 1 行分派  b) 把 #soul_count +1  c) 写对应函数文件
# 谓词永远只需 1in2 一个。

tag @s remove kitpvp.soul_given

# --- 位随机：10 次 1in2，得 0..1023 ---
scoreboard players set @s kitpvp.soul_rand 0
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 1
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 2
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 4
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 8
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 16
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 32
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 64
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 128
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 256
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.soul_rand 512

# --- 取模：0..N-1 ---
scoreboard players operation @s kitpvp.soul_rand %= #soul_count kitpvp.game

# --- 分派表：加新魂石只在这里追加 1 行 ---
execute if score @s kitpvp.soul_rand matches 0 run function kitpvp:skill/soul_warrior
execute if score @s kitpvp.soul_rand matches 1 run function kitpvp:skill/soul_archer
execute if score @s kitpvp.soul_rand matches 2 run function kitpvp:skill/soul_tank
execute if score @s kitpvp.soul_rand matches 3 run function kitpvp:skill/soul_assassin
