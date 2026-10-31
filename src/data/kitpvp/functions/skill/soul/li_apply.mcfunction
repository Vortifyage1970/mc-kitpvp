# 李朱俊泽魂石：开启 iLsacuL 计时（20 秒），并召出一只带抗性提升 V 的 iLsacuL（不再发蛋）
# 计时靠 #li_soul 强制 #li_active，与"场上有没有 kit=88 玩家"无关（见 tick）
scoreboard players set #li_soul kitpvp.game 400

# 它是一只**正常的 iLsacuL**：第 3 秒被复制、第 6 秒被炸、第 12 秒计入 ≥14 的判定，全都照常参与。
# 抗性 V（100% 减伤）让它炸不死，所以只有"每刻自爆"（apocalypse）跳过它——否则一只炸不死的猪
# 会让每刻一朵苦力怕无限刷下去。它不影响那个开关的关闭条件（见 apocalypse）。
# 生命周期：20 秒后 li_expire 显式 kill；game/reset 与 li_purge 按 li_pig 兜底。
summon minecraft:pig ~ ~ ~ {Tags:["kitpvp.li_pig","kitpvp.soul_li_pig"],CustomName:'{"text":"iLsacuL","color":"light_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ActiveEffects:[{Id:11b,Amplifier:4b,Duration:-1,ShowParticles:0b}]}

title @s actionbar {"text":"魂石·iLsacuL：计时开启，获得一只抗性提升 V 的 iLsacuL（20 秒）","color":"light_purple"}
playsound minecraft:entity.pig.ambient master @s ~ ~ ~ 1 0.8
