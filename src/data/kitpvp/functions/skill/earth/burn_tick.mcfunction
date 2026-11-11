# @s = 身上 burn_left ≥ 1 的玩家：篝火点着的 5 秒，每刻冒火星、每 20 刻掉 1 点火焰伤害
# 用分数计时而不是 Fire 标签：玩家 NBT 不允许 /data 改（1.20.1 会报 Unable to modify player data）
particle minecraft:flame ~ ~1 ~ 0.3 0.55 0.3 0.01 4
particle minecraft:smoke ~ ~1.1 ~ 0.25 0.45 0.25 0.005 2
scoreboard players operation #burn_m kitpvp.game = @s kitpvp.burn_left
scoreboard players operation #burn_m kitpvp.game %= #burn_20 kitpvp.game
execute if score #burn_m kitpvp.game matches 0 run damage @s 1 minecraft:on_fire
execute if score #burn_m kitpvp.game matches 0 run playsound minecraft:block.fire.ambient master @s ~ ~ ~ 0.6 1.0
scoreboard players remove @s kitpvp.burn_left 1
