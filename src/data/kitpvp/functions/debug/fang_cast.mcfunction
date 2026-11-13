# 起手式：先在目标脚下打一个 marker，响一声"唤魔者蓄力"，10 刻后真正咬
# 执行上下文是那只铁块骷髅（as @s at @s）
execute as @s at @s as @p[distance=..15,gamemode=!spectator] run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.fang_at"]}
execute if entity @e[tag=kitpvp.fang_at] at @e[tag=kitpvp.fang_at,limit=1] run particle minecraft:crit ~ ~0.3 ~ 0.4 0.05 0.4 0.02 20
execute if entity @e[tag=kitpvp.fang_at] at @s run playsound minecraft:entity.evoker.prepare_attack hostile @a[distance=..16] ~ ~ ~ 0.9 0.9
scoreboard players set @s kitpvp.fang_cd 60
execute if entity @e[tag=kitpvp.fang_at] run schedule function kitpvp:debug/fang_bite 10t replace
