# @s = 铁人，at 它身上：在身后一格丢一颗隐形小炸弹，并给铁人一发真速度（Motion，不用 tp）
# 炸弹本体照抄炸弹兵（summon/bomber_small.mcfunction:2），改动：位置身后一格 + 隐形写进 NBT
# 冲量算法：炸弹在身后一格 ⇒「铁人坐标 − 炸弹坐标」就是朝前的单位向量（坐标 ×1000 存进分数），
# 再用 store result entity … Motion[i] double 写回真实速度：0.00035 × 1000 = 0.35 格/刻，
# 之后交给原版摩擦（每刻 ×0.91）自然衰减 ⇒ 肉眼是"被屁股后的炮仗顶出去"的抛物线，全程没有 tp
summon minecraft:creeper ^ ^ ^-1 {Tags:["kitpvp.bomb","kitpvp.bomb_small"],CustomName:'{"text":"小炸弹","color":"gold"}',CustomNameVisible:0b,ignited:1b,Fuse:0s,ExplosionRadius:2b,ActiveEffects:[{Id:14b,Amplifier:0b,Duration:1000000,ShowParticles:0b}]}
execute store result score #im_px kitpvp.game run data get entity @s Pos[0] 1000
execute store result score #im_py kitpvp.game run data get entity @s Pos[1] 1000
execute store result score #im_pz kitpvp.game run data get entity @s Pos[2] 1000
execute store result score #im_bx kitpvp.game run data get entity @e[tag=kitpvp.bomb_small,limit=1,sort=nearest,distance=..3] Pos[0] 1000
execute store result score #im_by kitpvp.game run data get entity @e[tag=kitpvp.bomb_small,limit=1,sort=nearest,distance=..3] Pos[1] 1000
execute store result score #im_bz kitpvp.game run data get entity @e[tag=kitpvp.bomb_small,limit=1,sort=nearest,distance=..3] Pos[2] 1000
scoreboard players operation #im_dx kitpvp.game = #im_px kitpvp.game
scoreboard players operation #im_dx kitpvp.game -= #im_bx kitpvp.game
scoreboard players operation #im_dy kitpvp.game = #im_py kitpvp.game
scoreboard players operation #im_dy kitpvp.game -= #im_by kitpvp.game
scoreboard players operation #im_dz kitpvp.game = #im_pz kitpvp.game
scoreboard players operation #im_dz kitpvp.game -= #im_bz kitpvp.game
scoreboard players add #im_dy kitpvp.game 300
execute store result entity @s Motion[0] double 0.00035 run scoreboard players get #im_dx kitpvp.game
execute store result entity @s Motion[1] double 0.00035 run scoreboard players get #im_dy kitpvp.game
execute store result entity @s Motion[2] double 0.00035 run scoreboard players get #im_dz kitpvp.game
