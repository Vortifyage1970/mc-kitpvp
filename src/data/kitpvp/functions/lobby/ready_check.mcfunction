# ===== 主大厅：全员就绪 → 开局 =====
# 调用方：lobby/ready_on
#
# 三条守卫缺一不可：
#   1) 至少要有一名大厅玩家处于"已准备"
#      —— 没有这一条，大厅空着（@a 不含任何人）时也会判定"全员就绪"并开局
#   2) 不存在"在大厅但未准备"的玩家
#   3) 当前未开局（#state = 0）
#      —— 防止结算期间或已开局后被重复触发
#
# 本函数只在"有人刚进入准备"时被调用，不做每刻轮询。
# 如需覆盖"玩家中途退出导致剩下的人自动满足条件"，需要额外挂低频轮询，当前不做。

execute if entity @a[tag=kitpvp.in_lobby,tag=kitpvp.ready] unless entity @a[tag=kitpvp.in_lobby,tag=!kitpvp.ready] if score #state kitpvp.game matches 0 run function kitpvp:game/start
