# ===== 切换调试无敌 =====
# 用 tag kitpvp.debug_god 记住状态，命令里用 execute if/unless 分派

execute if entity @s[tag=kitpvp.debug_god] run function kitpvp:debug/god_off
execute unless entity @s[tag=kitpvp.debug_god] run function kitpvp:debug/god_on
