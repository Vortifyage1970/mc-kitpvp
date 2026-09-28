# ===== 按 kit 分数重发职业装备 =====
# 每个职业函数内部自行负责：装备、属性、永久效果、命数、tag

execute if score @s kitpvp.kit matches 1 run function kitpvp:kit/warrior
# execute if score @s kitpvp.kit matches 2 run function kitpvp:kit/archer
# execute if score @s kitpvp.kit matches 3 run function kitpvp:kit/tank
# execute if score @s kitpvp.kit matches 4 run function kitpvp:kit/assassin
# …… 新增职业时按同格式追加
# ……