# 每个 marker 守护一格火，寿命 100 刻（5 秒）
scoreboard players remove @e[type=minecraft:marker,tag=kitpvp.arsonist_fire,scores={kitpvp.fire_timer=1..}] kitpvp.fire_timer 1

# 火被打灭（位置变空气）则复燃；放方块 / 倒水覆盖不算，跳过
execute as @e[type=minecraft:marker,tag=kitpvp.arsonist_fire] at @s unless block ~ ~ ~ fire if block ~ ~ ~ air unless block ~ ~-1 ~ air run setblock ~ ~ ~ fire

kill @e[type=minecraft:marker,tag=kitpvp.arsonist_fire,scores={kitpvp.fire_timer=..0}]
