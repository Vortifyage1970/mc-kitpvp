# 李朱俊泽魂石：召出一只**常驻**的 iLsacuL 种子（没有时限，直到被玩家打死或被清场）
# 循环本身由 tick 的 #li_active 驱动：局内只要有任意一只 iLsacuL 在场上（种子、复制体、地球召的都算）就跑
# 计时归零：让这只猪从"第 0 刻"开始走，3 秒后必有一次复制、6 秒后必有一次引爆——
# 否则它会插进循环的任意相位，看起来像"不繁殖不爆"
scoreboard players set #litimer kitpvp.game 0

# 种子猪：**照常参与复制与第 6 秒的引爆**（抗性提升 V = 100% 减伤，炸不死），
# 只有"每刻自爆"（apocalypse）和 ≥14 的计数把它排除——否则一只炸不死的猪会让开关永远关不掉。
# 它活着，下一圈才有的可复制：这是魂石能连着跑下去的唯一依据。
# 生命周期：**没有时限**（2026-11-10 起去掉 20 秒计时）；它被玩家打死就没了，循环靠剩下的复制体继续跑到自爆清场。
# 生成位置 = 调用方的位置（由 use_li 的 `at @e[魂石载体]` 给到，即蛋落点）
summon minecraft:pig ~ ~ ~ {Tags:["kitpvp.li_pig","kitpvp.soul_li_pig"],CustomName:'{"text":"iLsacuL","color":"light_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ActiveEffects:[{Id:11b,Amplifier:4b,Duration:-1,ShowParticles:0b}]}

title @s actionbar {"text":"魂石·iLsacuL：获得一只抗性提升 V 的 iLsacuL（常驻）","color":"light_purple"}
playsound minecraft:entity.pig.ambient master @s ~ ~ ~ 1 0.8
