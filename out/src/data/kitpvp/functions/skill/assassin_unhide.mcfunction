# ===== 刺客：隐匿到期（5 秒到） =====
# 触发：tick.mcfunction 检测到 cd <= 500 且 tag=kitpvp.assassin_hidden
# @s = 刺客
#
# 责任：
#   1. 重新挂回永久速度 I（隐匿期间被 speed III 顶掉）
#   2. 摘掉隐匿标记，防止 tick 重复触发
#   3. 提示本机玩家
#
# ⚠ 隐身效果本身的移除交给原版计时器（5 秒到自动消失），本函数不主动 clear。
#   这样即使玩家中途死亡重生，也不会出现"隐身碎片"残留。

function kitpvp:kit/assassin_passive
tag @s remove kitpvp.assassin_hidden

title @s actionbar {"text":"隐匿结束","color":"gray"}
