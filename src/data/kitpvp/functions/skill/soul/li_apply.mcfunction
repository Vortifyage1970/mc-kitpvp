# 李朱俊泽魂石：开启 iLsacuL 计时（20 秒），并召出一只带抗性提升 V 的 iLsacuL（不再发蛋）
# 计时靠 #li_soul 强制 #li_active，与"场上有没有 kit=88 玩家"无关（见 tick）
scoreboard players set #li_soul kitpvp.game 400
# 计时归零：让这只猪从"第 0 刻"开始走，3 秒后必有一次复制、6 秒后必有一次引爆——
# 否则它会插进循环的任意相位，看起来像"不繁殖不爆"
scoreboard players set #litimer kitpvp.game 0
# 补位冷却归零（timer 里的兜底检测用，见 skill/soul/li_reseed）
scoreboard players set #li_reseed_cd kitpvp.game 0

# 种子猪：**照常参与复制与第 6 秒的引爆**（抗性提升 V = 100% 减伤，炸不死），
# 只有"每刻自爆"（apocalypse）和 ≥14 的计数把它排除——否则一只炸不死的猪会让开关永远关不掉。
# 它活着，下一圈才有的可复制：这是魂石能连着跑下去的唯一依据。
# 万一它还是没了（被玩家剁了 / 区块没加载 / 被推出世界），timer 里的兜底检测会在参战者身边补一只。
# 生命周期：20 秒后 li_expire 显式 kill；game/reset 与 li_purge 按 li_pig 兜底。
summon minecraft:pig ~ ~ ~ {Tags:["kitpvp.li_pig","kitpvp.soul_li_pig"],CustomName:'{"text":"iLsacuL","color":"light_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ActiveEffects:[{Id:11b,Amplifier:4b,Duration:-1,ShowParticles:0b}]}

title @s actionbar {"text":"魂石·iLsacuL：计时开启，获得一只抗性提升 V 的 iLsacuL（20 秒）","color":"light_purple"}
playsound minecraft:entity.pig.ambient master @s ~ ~ ~ 1 0.8
