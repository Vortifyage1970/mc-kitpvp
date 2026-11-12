# @s = 凤凰的守卫 marker，现在站在死亡位置：留下「凤凰蛋」，并开始 10 秒倒计时
scoreboard players set @s kitpvp.phx_stage 1
scoreboard players set @s kitpvp.phx_life 200
execute at @s run particle minecraft:lava ~ ~0.4 ~ 0.4 0.3 0.4 0.02 40 force
execute at @s run particle minecraft:flame ~ ~ ~ 0.5 0.4 0.5 0.01 50 force
execute at @s run playsound minecraft:entity.blaze.death master @a ~ ~ ~ 1.2 0.8
# 蛋 = 隐形小盔甲架顶着嗅探兽蛋，纯装饰：Invulnerable 打不碎、没有血量概念，10 秒到点必复活
execute at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["kitpvp.phx_egg","kitpvp.phx_new"],Invisible:1b,Small:1b,Invulnerable:1b,NoGravity:1b,CustomName:'{"text":"凤凰蛋","color":"gold"}',CustomNameVisible:1b,HandItems:[{},{}],ArmorItems:[{},{},{},{id:"minecraft:sniffer_egg",Count:1b}]}
scoreboard players operation @e[tag=kitpvp.phx_new,limit=1,sort=nearest] kitpvp.phx_pair = #phx_pair kitpvp.game
tag @e[tag=kitpvp.phx_new] remove kitpvp.phx_new
# 把这只蛋标成"自己的"，好让孵化/收尾只处理同一号的蛋
tag @e[tag=kitpvp.phx_egg] remove kitpvp.phx_tmp
execute as @e[tag=kitpvp.phx_egg] if score @s kitpvp.phx_pair = #phx_pair kitpvp.game run tag @s add kitpvp.phx_tmp
scoreboard players add @e[tag=kitpvp.phx_tmp] kitpvp.earth_owner 0
scoreboard players operation @e[tag=kitpvp.phx_tmp] kitpvp.earth_owner = @s kitpvp.earth_owner
tag @e[tag=kitpvp.phx_egg] remove kitpvp.phx_tmp
