# ===== 通用职业分发入口 =====
# 前置：@s kitpvp.kit 已写好
# 用途：调试、或未来按分数重发（目前主流程不由它触发）

execute if score @s kitpvp.kit matches 1 run function kitpvp:kit/warrior
# execute if score @s kitpvp.kit matches 2 run function kitpvp:kit/archer
# …… 新增职业时按同格式追加
