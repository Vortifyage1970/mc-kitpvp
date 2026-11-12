# @s = 凤凰的守卫 marker，现在站在死亡位置：留下「凤凰蛋」，并开始 10 秒倒计时
scoreboard players set @s kitpvp.phx_stage 1
scoreboard players set @s kitpvp.phx_life 200
execute at @s run particle minecraft:lava ~ ~0.4 ~ 0.4 0.3 0.4 0.02 40 force
execute at @s run particle minecraft:flame ~ ~ ~ 0.5 0.4 0.5 0.01 50 force
execute at @s run playsound minecraft:entity.blaze.death master @a ~ ~ ~ 1.2 0.8
# 蛋用"隐形小盔甲架顶着海龟蛋"：名字能显示，也不会像悬空的方块那样被方块更新弹掉
execute at @s run kill @e[tag=kitpvp.phx_egg,distance=..3]
execute at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["kitpvp.phx_egg"],Invisible:1b,Small:1b,Invulnerable:1b,CustomName:'{"text":"凤凰蛋","color":"gold"}',CustomNameVisible:1b,HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:turtle_egg",Count:1b}]}
