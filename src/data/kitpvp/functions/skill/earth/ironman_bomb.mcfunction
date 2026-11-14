# @s = 铁人，at 它身上：在身后一格丢一颗隐形小炸弹
# 炸弹本体完全照抄炸弹兵的代码（summon/bomber_small.mcfunction:2），只做两处改动：
#   ① 位置改成身后一格（^ ^ ^-1，跟着铁人朝向）
#   ② 隐形写在 NBT 里（ActiveEffects Id 14 = invisibility，ShowParticles:0b 不留粒子），不用药水命令
# 铁人自己不带任何隐形/效果，这条函数只生成一个炸弹实体
summon minecraft:creeper ^ ^ ^-1 {Tags:["kitpvp.bomb","kitpvp.bomb_small"],CustomName:'{"text":"小炸弹","color":"gold"}',CustomNameVisible:0b,ignited:1b,Fuse:0s,ExplosionRadius:1b,ActiveEffects:[{Id:14b,Amplifier:0b,Duration:1000000,ShowParticles:0b}]}
scoreboard players set @s kitpvp.im_push 4
