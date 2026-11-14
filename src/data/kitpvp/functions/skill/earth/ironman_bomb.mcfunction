# @s = 铁人，at 它身上：在脚边丢一颗"小炸弹"（苦力怕伪装 + 0 半径，真正的伤害由 ironman_bomb_tick 结算）
# 用 ignited + 长引信是为了让它一边闪白一边嘶嘶响（这 2 秒就是玩家跑开的时间）
summon minecraft:creeper ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.im_bomb"],Silent:1b,NoAI:1b,ignited:1b,Fuse:200s,ExplosionRadius:0b,NoGravity:1b,CustomName:'{"text":"小炸弹","color":"red"}',CustomNameVisible:0b}
scoreboard players set @e[tag=kitpvp.im_bomb] kitpvp.im_bomb_t 40
playsound minecraft:entity.creeper.primed hostile @a[distance=..16] ~ ~ ~ 0.7 1.4
