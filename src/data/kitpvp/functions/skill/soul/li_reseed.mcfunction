# 种子猪补位：魂石还在计时（#li_soul > 0），但场上已经没有 soul_li_pig 了 —— 在参战者身边补一只
# 这一只不参与 ≥14 计数、也不参与每刻自爆，但它是下一圈复制的种子：没有它，复制阶段就空转，循环就停
# 位置取第一名参战者：tick 调 timer 时没有实体上下文，用 @p 会落到世界出生点
scoreboard players set #li_reseed_cd kitpvp.game 20
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,limit=1] at @s run summon minecraft:pig ~ ~ ~ {Tags:["kitpvp.li_pig","kitpvp.soul_li_pig"],CustomName:'{"text":"iLsacuL","color":"light_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ActiveEffects:[{Id:11b,Amplifier:4b,Duration:-1,ShowParticles:0b}]}
tellraw @a [{"text":"[魂石] ","color":"light_purple","bold":true},{"text":"iLsacuL 种子补位，循环继续","color":"gray"}]
