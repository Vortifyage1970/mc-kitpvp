# iLsacuL 循环计时器：局内只要场上还有任意一只 iLsacuL（种子 / 复制体 / 地球召的）就一直走，12 秒 = 240 刻一圈
# 第 3 秒复制（封顶 16）/ 第 6 秒半径 5 自爆 / 第 9 秒什么都不做 / 第 12 秒收尾（≥40 才全部爆炸，≥16 静默清场）
scoreboard players add #litimer kitpvp.game 1
execute if score #litimer kitpvp.game matches 60 run function kitpvp:skill/li_zhujunze/copy_stage
execute if score #litimer kitpvp.game matches 120 run function kitpvp:skill/li_zhujunze/blast_stage
execute if score #litimer kitpvp.game matches 240.. run function kitpvp:skill/li_zhujunze/cycle_end

# "全部爆炸"安全阀（只在数量离谱时打开，一次炸完就关）
execute if score #liapoc kitpvp.game matches 1 run function kitpvp:skill/li_zhujunze/apocalypse
