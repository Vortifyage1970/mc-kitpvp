# 李朱俊泽魂石：开启 iLsacuL 计时（20 秒），并召出一只当"种子"的 iLsacuL（不再发蛋）
# 计时靠 #li_soul 强制 #li_active，与"场上有没有 kit=88 玩家"无关（见 tick）
scoreboard players set #li_soul kitpvp.game 400
# 计时归零：让这只猪从"第 0 刻"开始走，3 秒后必有一次复制、6 秒后必有一次引爆——
# 否则它会插进循环的任意相位，看起来像"不繁殖不爆"
scoreboard players set #litimer kitpvp.game 0

# 种子猪：第 3 秒被复制、第 12 秒不计入 ≥14 的判定，**也不参与第 6 秒的引爆**（blast_stage 跳过它）。
# 以前它靠抗性提升 V 硬吃爆炸活下来；2026-11-10 去掉抗性 V 后改成"直接跳过引爆"，
# 否则一圈炸完种子就没了，魂石只剩一次循环（车主报的那个 bug）。
# 生命周期：20 秒后 li_expire 显式 kill；game/reset 与 li_purge 按 li_pig 兜底。
# 生成位置 = 调用方的位置（由 use_li 的 `at @e[魂石载体]` 给到，即蛋落点）
summon minecraft:pig ~ ~ ~ {Tags:["kitpvp.li_pig","kitpvp.soul_li_pig"],CustomName:'{"text":"iLsacuL","color":"light_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}]}

title @s actionbar {"text":"魂石·iLsacuL：计时开启，获得一只 iLsacuL（20 秒）","color":"light_purple"}
playsound minecraft:entity.pig.ambient master @s ~ ~ ~ 1 0.8
