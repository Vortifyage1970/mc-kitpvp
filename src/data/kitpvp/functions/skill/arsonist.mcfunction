# 自动补货：弹药 < 2 才补并进 45 秒冷却。cd 只由 arsonist_cast（投掷）与 arsonist_give（补货）两处各写 900
execute if score @s kitpvp.arsonist_ammo matches ..1 run function kitpvp:skill/arsonist_give
