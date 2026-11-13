# 雪球测试的节拍器：冷却 → 出手 → 命中检测 → 自己续约
scoreboard players remove @e[tag=kitpvp.snow_test] kitpvp.snow_cd 1
execute as @e[tag=kitpvp.snow_test,scores={kitpvp.snow_cd=..0},limit=1] at @s run function kitpvp:debug/snow_cast
# 命中：雪球飞到 1.6 格内就算打中（要在原版"撞上即消失"之前判定，所以半径给得比 1 格宽）
execute as @e[type=minecraft:snowball,tag=kitpvp.snow] at @s if entity @a[distance=..1.6,gamemode=!spectator] run damage @a[distance=..1.6,gamemode=!spectator] 1 minecraft:magic by @e[tag=kitpvp.snow_test,limit=1]
execute as @e[type=minecraft:snowball,tag=kitpvp.snow] at @s if entity @a[distance=..1.6,gamemode=!spectator] run playsound minecraft:entity.snowball.hit hostile @a[distance=..12] ~ ~ ~ 0.8 1.2
execute as @e[type=minecraft:snowball,tag=kitpvp.snow] at @s if entity @a[distance=..1.6,gamemode=!spectator] run kill @s
execute if entity @e[tag=kitpvp.snow_test] run schedule function kitpvp:debug/snow_test_loop 1t replace
