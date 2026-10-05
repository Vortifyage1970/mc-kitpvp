# ===== 纵火狂：喷溅药水投掷入口 =====
# 触发：tick.mcfunction 检测到 kitpvp.arsonist_used > kitpvp.arsonist_last
#       ⚠ 触发条件里不含 hold_fb_prev——任何喷溅药水投掷都要进这里，
#         否则投普通药水时 last 不推进，之后切到燃烧瓶会误触发一次施法。
# @s = 纵火狂
#
# 本函数只做两步：
#   1. 无条件推进 last（把"这次投掷"标记为已消费）
#   2. 只有当"上一刻手持燃烧瓶"时，才转交 arsonist_fire 做真施法

scoreboard players operation @s kitpvp.arsonist_last = @s kitpvp.arsonist_used

execute if entity @s[tag=kitpvp.hold_fb_prev] run function kitpvp:skill/arsonist_fire
