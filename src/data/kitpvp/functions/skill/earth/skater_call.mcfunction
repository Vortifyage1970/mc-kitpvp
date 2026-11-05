# 滑冰者的"寒带动静"：每 3 次滑行（≈6 秒）来一声，四种轮着来，靠 #skater_sel 递增取模（不用随机，听得出是循环）
# 北极熊闷吼 / 狐狸尖哨 / 狼嚎 / 山羊咩 —— 都是雪原生物音色，跟它脚下的细雪对得上
scoreboard players add #skater_sel kitpvp.game 1
scoreboard players operation #skater_sel kitpvp.game %= #skater_four kitpvp.game
execute if score #skater_sel kitpvp.game matches 0 run playsound minecraft:entity.polar_bear.ambient master @a[distance=..24] ~ ~ ~ 0.8 0.7
execute if score #skater_sel kitpvp.game matches 1 run playsound minecraft:entity.fox.ambient master @a[distance=..24] ~ ~ ~ 0.9 1.4
execute if score #skater_sel kitpvp.game matches 2 run playsound minecraft:entity.wolf.howl master @a[distance=..24] ~ ~ ~ 0.9 1.0
execute if score #skater_sel kitpvp.game matches 3 run playsound minecraft:entity.goat.ambient master @a[distance=..24] ~ ~ ~ 0.8 1.3
scoreboard players set @s kitpvp.skater_call 3
