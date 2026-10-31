# 李朱俊泽魂石：开启 iLsacuL 计时（20 秒），并召出一只带抗性提升 V 的 iLsacuL（不再发蛋）
# 计时靠 #li_soul 强制 #li_active，与"场上有没有 kit=88 玩家"无关（见 tick）
scoreboard players set #li_soul kitpvp.game 400

# 抗性 V（100% 减伤）让它基本打不死，所以它**不参加**循环的复制 / 引爆 / ≥14 计数（那三处都排除了 soul_li_pig）：
# 否则一只炸不死的猪会让"每刻自爆"的开关永远关不掉（>14 的结束判定会卡死）。
# 生命周期由 #li_soul 决定：20 秒后 li_expire 显式清；game/reset 与 li_purge 按 li_pig 兜底。
summon minecraft:pig ~ ~ ~ {Tags:["kitpvp.li_pig","kitpvp.soul_li_pig"],CustomName:'{"text":"iLsacuL","color":"light_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ActiveEffects:[{Id:11b,Amplifier:4b,Duration:-1,ShowParticles:0b}]}

title @s actionbar {"text":"魂石·iLsacuL：计时开启，获得一只抗性提升 V 的 iLsacuL（20 秒）","color":"light_purple"}
playsound minecraft:entity.pig.ambient master @s ~ ~ ~ 1 0.8
