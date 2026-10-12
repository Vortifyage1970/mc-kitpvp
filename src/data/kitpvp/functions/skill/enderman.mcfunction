# ===== 末影人：末影珍珠补货（自动技能入口） =====
# 调用方：skill/dispatch（cd <= 0 时）
# 条件：ammo < 3
# @s = 末影人

execute if score @s kitpvp.ender_ammo matches ..2 run function kitpvp:skill/enderman_give
