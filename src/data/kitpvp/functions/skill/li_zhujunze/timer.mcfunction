# iLsacuL 循环计时器：只要场上还有这个职业（且局内）就一直走，12 秒 = 240 刻一圈
# 第 3 秒复制 / 第 6 秒半径 5 自爆 / 第 9 秒什么都不做 / 第 12 秒判定 ≥14 只就转入每刻自爆
scoreboard players add #litimer kitpvp.game 1
execute if score #litimer kitpvp.game matches 60 run function kitpvp:skill/li_zhujunze/copy_stage
execute if score #litimer kitpvp.game matches 120 run function kitpvp:skill/li_zhujunze/blast_stage
execute if score #litimer kitpvp.game matches 240.. run function kitpvp:skill/li_zhujunze/cycle_end

# 12 秒判定留下的"每刻半径 8 自爆"开关
execute if score #liapoc kitpvp.game matches 1 run function kitpvp:skill/li_zhujunze/apocalypse
