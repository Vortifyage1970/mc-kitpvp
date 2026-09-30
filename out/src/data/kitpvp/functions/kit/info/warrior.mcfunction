# ===== 战士 · 职业介绍卡片 =====
# 由 kit/list/* 里点击战士条目时调用，@s = 查看者

tellraw @s [{"text":"┌──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"│ 职业名：","color":"gray"},{"text":"战士","color":"red","bold":true}]
tellraw @s [{"text":"│ 分类：","color":"gray"},{"text":"经典（表）","color":"white"}]
tellraw @s [{"text":"│ 简介：","color":"gray"},{"text":"铁甲冲锋的正面战士","color":"white"}]
tellraw @s [{"text":"│ 武器单次伤害：","color":"gray"},{"text":"7","color":"white"}]
tellraw @s [{"text":"│ 武器攻击速度：","color":"gray"},{"text":"1.6","color":"white"}]
tellraw @s [{"text":"│ 总护甲值：","color":"gray"},{"text":"15","color":"white"}]
tellraw @s [{"text":"│ 总护甲韧性：","color":"gray"},{"text":"0","color":"white"}]
tellraw @s [{"text":"│ 被动：","color":"gray"},{"text":"—","color":"dark_gray"}]
tellraw @s [{"text":"│ 技能：","color":"gray"},{"text":"补给","color":"yellow"},{"text":" —— 每 40 秒获得 1 个金苹果（上限 1）","color":"white"}]
tellraw @s [{"text":"│ 技能冷却：","color":"gray"},{"text":"40 秒","color":"white"}]
tellraw @s [{"text":"└──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"[ 确认选择 ]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/warrior"},"hoverEvent":{"action":"show_text","contents":[{"text":"以战士参战","color":"gray"}]}},{"text":"  "},{"text":"[ 返回 ]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:lobby/menu"},"hoverEvent":{"action":"show_text","contents":[{"text":"回到主大厅菜单","color":"gray"}]}}]
