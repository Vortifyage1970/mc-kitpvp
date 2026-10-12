# ===== 按 kit 分数重发职业装备 =====
# 每个职业函数内部自行负责：装备、属性、永久效果、命数、tag

execute if score @s kitpvp.kit matches 1 run function kitpvp:kit/warrior
execute if score @s kitpvp.kit matches 2 run function kitpvp:kit/archer
execute if score @s kitpvp.kit matches 3 run function kitpvp:kit/tank
execute if score @s kitpvp.kit matches 4 run function kitpvp:kit/assassin
execute if score @s kitpvp.kit matches 5 run function kitpvp:kit/arsonist
execute if score @s kitpvp.kit matches 6 run function kitpvp:kit/ghost
execute if score @s kitpvp.kit matches 7 run function kitpvp:kit/fisher
execute if score @s kitpvp.kit matches 8 run function kitpvp:kit/enderman
execute if score @s kitpvp.kit matches 9 run function kitpvp:kit/pirate
# …… 新增职业时按同格式追加
# ……