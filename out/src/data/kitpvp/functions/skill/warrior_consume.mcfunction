# ===== 战士：金苹果被吃掉 → 进 40 秒冷却 =====
# 触发：tick.mcfunction 检测到 used > last
# @s = 吃掉苹果的战士

# 1. 快照推到当前值，防止下一刻重复触发
scoreboard players operation @s kitpvp.gapple_last = @s kitpvp.gapple_used

# 2. 摘掉"持有中"标记，进入 40 秒冷却
tag @s remove kitpvp.skill_ready
scoreboard players set @s kitpvp.cd 800

title @s actionbar {"text":"补给进入冷却：40 秒","color":"gray"}
playsound minecraft:entity.player.burp master @s ~ ~ ~ 0.5 1.0
