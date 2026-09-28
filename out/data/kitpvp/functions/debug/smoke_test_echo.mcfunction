# 由 kitpvp:debug/smoke_test 通过 schedule 调用，延迟 3 秒
# 作用：验证 schedule 定时器，并清理冒烟测试产生的一切状态

tellraw @s '{"text":"[9/9] schedule 回显 OK —— 3 秒定时器正常","color":"green"}'
playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 1 1.2
bossbar set kitpvp:smoke value 9

# 收尾清理（顺序：先解除玩家绑定，再删容器）
data remove storage kitpvp:smoke test
team leave @s
team remove smoke_red
tag @s remove kitpvp.smoke
bossbar remove kitpvp:smoke
scoreboard objectives remove kitpvp.smoketest

tellraw @s '[{"text":"冒烟测试结束。","bold":true,"color":"gold"},{"text":"若 1-9 全部出现，说明 1.20.1 基础能力可用。","color":"gray"}]'
