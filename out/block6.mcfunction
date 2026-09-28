# 同步金苹果统计快照，防止上一个会话遗留的累计统计误触发冷却
scoreboard players operation @s kitpvp.gapple_last = @s kitpvp.gapple_used
