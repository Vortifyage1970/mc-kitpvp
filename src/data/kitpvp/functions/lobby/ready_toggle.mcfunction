# ===== 主大厅：准备 / 取消准备 切换 =====
# 触发：tick.mcfunction 检测到 ready_used > ready_last（右键了准备钓竿）
# @s = 在主大厅内的玩家
#
# ⚠ 为什么中间要夹一层 ready_pending：
#   如果写成
#     execute if entity @s[tag=kitpvp.ready] run function kitpvp:lobby/ready_off
#     execute unless entity @s[tag=kitpvp.ready] run function kitpvp:lobby/ready_on
#   第一条跑完 ready 被摘掉，第二条的条件立刻成立，同一刻又切回去。
#   命令是逐条执行的，条件读的是"当前"状态，不是"切换前"的状态。
#   所以先把切换前的状态快照进 ready_pending，两条分支都只读 pending。
#   ready_pending 不会在 ready_on / ready_off 里被改动，两个分支因此互斥且稳定。

# 1. 推进快照，防止下一刻重复触发（漏写会每刻切换一次）
scoreboard players operation @s kitpvp.ready_last = @s kitpvp.ready_used

# 2. 快照切换前的状态
tag @s remove kitpvp.ready_pending
execute if entity @s[tag=kitpvp.ready] run tag @s add kitpvp.ready_pending

# 3. 分流
execute if entity @s[tag=kitpvp.ready_pending] run function kitpvp:lobby/ready_off
execute unless entity @s[tag=kitpvp.ready_pending] run function kitpvp:lobby/ready_on

# 4. 收尾
tag @s remove kitpvp.ready_pending
