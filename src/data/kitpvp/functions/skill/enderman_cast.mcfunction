# ===== 末影人：末影珍珠投掷入口 =====
# 触发：tick.mcfunction 检测到 kitpvp.ender_used > kitpvp.ender_last
#       ⚠ 触发条件里不含 hold_ep_prev——任何末影珍珠投掷都要进这里，
#         否则投的是别处来的珍珠时 last 不推进，之后切到手里会误触发施法。
# @s = 末影人
#
# 首行快照推进是铁律，必须无条件执行。

scoreboard players operation @s kitpvp.ender_last = @s kitpvp.ender_used

execute if entity @s[tag=kitpvp.hold_ep_prev] run function kitpvp:skill/enderman_fire
