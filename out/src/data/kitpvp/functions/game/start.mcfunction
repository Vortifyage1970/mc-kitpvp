# ===== 开始游戏（入口）=====
# 触发：主大厅 [开始游戏] 按钮
# 职责：仅做人数检查，人数不足就打回，不进入实现层
#   1.20.1 无 return，所以用 execute if 控制流程

# 统计参战人数（tag=kitpvp.selected 由选职业确认时打上）
scoreboard players set #join_count kitpvp.game 0
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator] run scoreboard players add #join_count kitpvp.game 1

# 人数不足 → 提示，不进入实现
execute if score #join_count kitpvp.game matches ..1 run tellraw @a [{"text":"[!] ","color":"red","bold":true},{"text":"需要至少 2 名已选职业的玩家才能开始","color":"red"}]

# 人数足够 → 进入实现层
execute if score #join_count kitpvp.game matches 2.. run function kitpvp:game/start_impl
