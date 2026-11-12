# @s = 凤凰的守卫 marker，阶段 1（蛋）：每刻 -1，归零就孵化；自己的蛋被打破就整轮作废
tag @e[tag=kitpvp.phx_egg] remove kitpvp.phx_tmp
execute as @e[tag=kitpvp.phx_egg] if score @s kitpvp.phx_pair = #phx_pair kitpvp.game run tag @s add kitpvp.phx_tmp
execute if score @s kitpvp.phx_life matches 1.. unless entity @e[tag=kitpvp.phx_tmp,distance=..4] run function kitpvp:skill/earth/phoenix_fizzle
scoreboard players remove @s kitpvp.phx_life 1
execute if score @s kitpvp.phx_life matches 1.. run particle minecraft:flame ~ ~0.25 ~ 0.2 0.2 0.2 0.004 2 force
execute if score @s kitpvp.phx_life matches ..0 run function kitpvp:skill/earth/phoenix_reborn
tag @e[tag=kitpvp.phx_egg] remove kitpvp.phx_tmp
