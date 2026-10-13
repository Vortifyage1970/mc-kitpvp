# 右键准备钓竿的切换入口：先推进 ready_last，否则每刻切换一次。
# 用 ready_pending 存"切换前"的状态：命令逐条执行，条件读的是当前状态，不夹这层会自我翻转。
scoreboard players operation @s kitpvp.ready_last = @s kitpvp.ready_used

tag @s remove kitpvp.ready_pending
execute if entity @s[tag=kitpvp.ready] run tag @s add kitpvp.ready_pending

execute if entity @s[tag=kitpvp.ready_pending] run function kitpvp:lobby/ready_off
execute unless entity @s[tag=kitpvp.ready_pending] run function kitpvp:lobby/ready_on

tag @s remove kitpvp.ready_pending
