# @s = 铁人，at 它身上：在**身后一格**丢一颗隐形小炸弹（复用炸弹兵的代码：苦力怕 Fuse:0 立爆 + ExplosionRadius:1）
# 位置用 ^ ^ ^-1（局部坐标，正后方一格），不再叠在他自己身上 ⇒ 爆炸把他往前推一点，自己挨的伤害也更少
# 隐形：不给名字（无 CustomName）+ 隐形药水，只留下爆炸本身
execute at @s run summon minecraft:creeper ^ ^ ^-1 {Tags:["kitpvp.bomb","kitpvp.bomb_small"],Silent:0b,ignited:1b,Fuse:0s,ExplosionRadius:1b}
effect give @e[tag=kitpvp.bomb_small] minecraft:invisibility infinite 0 true
