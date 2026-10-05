# ===== 纵火狂：以落点为中心铺 4x4 火 =====
# 执行位置：已由 arsonist_burst 用 align xyz 对齐到落点所在方块
# 覆盖范围：dx ∈ {-2,-1,0,1}，dz ∈ {-2,-1,0,1}，共 16 格
# 每格条件：该位置是空气（绝不覆盖任何原有方块）且下方不是空气（有支撑）
# 每个点着的火配一个 marker 实体，由 arsonist_flame_tick 在 5 秒内每刻保火

execute positioned ~-2 ~ ~-2 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~-2 ~ ~-1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~-2 ~ ~0 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~-2 ~ ~1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~-1 ~ ~-2 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~-1 ~ ~-1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~-1 ~ ~0 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~-1 ~ ~1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~0 ~ ~-2 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~0 ~ ~-1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~0 ~ ~0 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~0 ~ ~1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~1 ~ ~-2 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~1 ~ ~-1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~1 ~ ~0 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one
execute positioned ~1 ~ ~1 if block ~ ~ ~ air unless block ~ ~-1 ~ air run function kitpvp:skill/arsonist_place_one

# 给本批新 marker 装上 100 刻（5 秒）寿命
# 用 kitpvp.arsonist_new 作"本批未初始化"标记，避免误伤上一批
execute as @e[type=minecraft:marker,tag=kitpvp.arsonist_new] run scoreboard players set @s kitpvp.fire_timer 100
execute as @e[type=minecraft:marker,tag=kitpvp.arsonist_new] run tag @s remove kitpvp.arsonist_new
