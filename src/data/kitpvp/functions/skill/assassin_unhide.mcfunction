# ===== 刺客：隐匿到期（5 秒到） =====
# 触发：tick.mcfunction 检测到 cd <= 500 且 tag=kitpvp.assassin_hidden
# @s = 刺客
#
# ⚠ 隐身效果本身的移除交给原版计时器（5 秒到自动消失），本函数不主动 clear。
#   这样即使玩家中途死亡重生，也不会出现"隐身碎片"残留。

tag @s remove kitpvp.assassin_hidden

title @s actionbar {"text":"隐匿结束","color":"gray"}
