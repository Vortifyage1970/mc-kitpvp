# @s = 凤凰的守卫 marker，现在站在死亡位置：留下「凤凰蛋」，并开始 10 秒倒计时
scoreboard players set @s kitpvp.phx_stage 1
scoreboard players set @s kitpvp.phx_life 200
execute at @s run particle minecraft:lava ~ ~0.4 ~ 0.4 0.3 0.4 0.02 40 force
execute at @s run particle minecraft:flame ~ ~ ~ 0.5 0.4 0.5 0.01 50 force
execute at @s run playsound minecraft:entity.blaze.death master @a ~ ~ ~ 1.2 0.8
# 蛋 = 隐形 + NoAI 的尸壳（白天不烧）顶着嗅探兽蛋，20 血：它是真能被打破的，不是装饰
# 用尸壳不用僵尸：僵尸白天会烧，蛋会自己烧没；也不怕它动——NoAI 站着不动
execute at @s run kill @e[tag=kitpvp.phx_egg,distance=..3]
execute at @s run summon minecraft:husk ~ ~ ~ {Tags:["kitpvp.phx_egg"],Invisible:1b,NoAI:1b,Silent:1b,NoGravity:1b,PersistenceRequired:1b,CanPickUpLoot:0b,CustomName:'{"text":"凤凰蛋","color":"gold"}',CustomNameVisible:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:sniffer_egg",Count:1b}]}
# 队伍跟着守卫抄：召唤者自己的生灵不会去啃这颗蛋，但玩家仍然能手打
scoreboard players add @e[tag=kitpvp.phx_egg] kitpvp.earth_owner 0
scoreboard players operation @e[tag=kitpvp.phx_egg] kitpvp.earth_owner = @s kitpvp.earth_owner
scoreboard players operation #phx_t kitpvp.game = @s kitpvp.earth_owner
execute if score #phx_t kitpvp.game matches 1 run team join earth_1 @e[tag=kitpvp.phx_egg]
execute if score #phx_t kitpvp.game matches 2 run team join earth_2 @e[tag=kitpvp.phx_egg]
execute if score #phx_t kitpvp.game matches 3 run team join earth_3 @e[tag=kitpvp.phx_egg]
execute if score #phx_t kitpvp.game matches 4 run team join earth_4 @e[tag=kitpvp.phx_egg]
execute if score #phx_t kitpvp.game matches 5 run team join earth_5 @e[tag=kitpvp.phx_egg]
execute if score #phx_t kitpvp.game matches 6 run team join earth_6 @e[tag=kitpvp.phx_egg]
