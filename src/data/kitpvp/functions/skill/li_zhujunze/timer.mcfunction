# iLsacuL 循环计时器：只要场上还有这个职业（或魂石计时还开着、且局内）就一直走，12 秒 = 240 刻一圈
# 第 3 秒复制 / 第 6 秒半径 5 自爆 / 第 9 秒什么都不做 / 第 12 秒判定 ≥14 只就转入每刻自爆
scoreboard players add #litimer kitpvp.game 1
execute if score #litimer kitpvp.game matches 60 run function kitpvp:skill/li_zhujunze/copy_stage
execute if score #litimer kitpvp.game matches 120 run function kitpvp:skill/li_zhujunze/blast_stage
execute if score #litimer kitpvp.game matches 240.. run function kitpvp:skill/li_zhujunze/cycle_end

# 12 秒判定留下的"每刻半径 8 自爆"开关
execute if score #liapoc kitpvp.game matches 1 run function kitpvp:skill/li_zhujunze/apocalypse

# ---- 兜底检测（魂石专用）----
# 魂石计时还开着（#li_soul > 0）却没有 soul_li_pig 了 —— 种子没了，下一圈复制阶段会空转，循环直接停。
# 以前没有这一层：种子靠抗性提升 V 硬吃爆炸，一旦它因为别的原因消失（区块没加载 / 被玩家剁了），
# 整条循环就只剩"炸完就静止"。现在每 20 刻补一次，补到为止。
execute if score #li_reseed_cd kitpvp.game matches 1.. run scoreboard players remove #li_reseed_cd kitpvp.game 1
execute if score #li_soul kitpvp.game matches 1.. unless entity @e[tag=kitpvp.soul_li_pig] if score #li_reseed_cd kitpvp.game matches ..0 run function kitpvp:skill/soul/li_reseed
