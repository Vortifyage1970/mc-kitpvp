# 绊索陷阱：**丢出即进冷却**（判据 = minecraft.dropped:<物品>，精确到"按 Q 丢出"这一事件）
scoreboard players set #trap_dropped kitpvp.game 0
execute if score @s kitpvp.trap_hook_drop_used > @s kitpvp.trap_hook_drop_last run scoreboard players set #trap_dropped kitpvp.game 1
scoreboard players operation @s kitpvp.trap_hook_drop_last = @s kitpvp.trap_hook_drop_used
# 计时中再丢不重置（同 03 §2.13）
execute if score #trap_dropped kitpvp.game matches 1 if score @s kitpvp.trap_hook_cd matches ..0 run scoreboard players set @s kitpvp.trap_hook_cd 500
