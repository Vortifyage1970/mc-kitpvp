# 在载体的落点集合：随机最多 10 只「农民」传送到落点（地球召唤的同名农民一并算进来）
execute as @e[type=minecraft:husk,name="召集农民",limit=1] at @s run tp @e[type=minecraft:zombie,name="农民",sort=random,limit=10] ~ ~ ~
execute at @s run kill @e[type=minecraft:husk,name="召集农民"]

title @s actionbar {"text":"召集农民","color":"yellow"}
execute at @s run playsound minecraft:entity.evoker.prepare_attack master @s ~ ~ ~ 0.8 1.1

# 上限 1 + 45 秒冷却：使用侧只在 cd<=0 时起计，计时中再用不会把补货推远（见 03 §2.13）
execute if score @s kitpvp.cd matches ..0 run scoreboard players set @s kitpvp.cd 900
