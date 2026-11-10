# 20 秒到：原地自爆并死亡（苦力怕无前摇、半径 3），顺带把主人的临时标签摘掉
summon minecraft:creeper ~ ~ ~ {Tags:["kitpvp.soul_venus_bomb"],ignited:1b,Fuse:0s,ExplosionRadius:3b}
particle minecraft:explosion ~ ~ ~ 0.3 0.3 0.3 0 1 normal
playsound minecraft:entity.generic.explode master @a[distance=..24] ~ ~ ~ 0.9 1.1
tag @a remove kitpvp.soul_venus_owner
kill @s
