# ===== 渔夫 · 职业介绍卡片 =====
# 由 kit/list/classic 里点击渔夫条目时调用，@s = 查看者

tellraw @s [{"text":"┌──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"│ 职业名：","color":"gray"},{"text":"渔夫","color":"blue","bold":true}]
tellraw @s [{"text":"│ 分类：","color":"gray"},{"text":"经典（表）","color":"white"}]
tellraw @s [{"text":"│ 简介：","color":"gray"},{"text":"以三叉戟与水流作战的猎手","color":"white"}]
tellraw @s [{"text":"│ 武器单次伤害：","color":"gray"},{"text":"7","color":"white"}]
tellraw @s [{"text":"│ 武器攻击速度：","color":"gray"},{"text":"1.0","color":"white"}]
tellraw @s [{"text":"│ 总护甲值：","color":"gray"},{"text":"15","color":"white"}]
tellraw @s [{"text":"│ 总护甲韧性：","color":"gray"},{"text":"0","color":"white"}]
tellraw @s [{"text":"│ 被动：","color":"gray"},{"text":"—","color":"dark_gray"}]
tellraw @s [{"text":"│ 技能：","color":"gray"},{"text":"寻回三叉戟（冷却 60 秒）","color":"blue"}]
tellraw @s [{"text":"│ 命数：","color":"gray"},{"text":"3","color":"white"}]
tellraw @s [{"text":"└──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"[ 确认选择 ]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/fisher"},"hoverEvent":{"action":"show_text","contents":"以渔夫参战"}},{"text":"  "},{"text":"[ 返回 ]","color":"yellow","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list/classic"},"hoverEvent":{"action":"show_text","contents":"回到「经典（表）」职业列表"}}]