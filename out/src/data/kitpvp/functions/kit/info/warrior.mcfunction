# ===== 职业详情：战士 =====
# 由 kit/list 的 [战士] 按钮触发
# [确认选择] → kitpvp:kit/warrior（该函数负责清场 + 设 kit 分数 + 发装备）
# 数值说明：铁剑总伤害 6（玩家基础 1 + 铁剑 5），攻击速度 1.6（基础 4.0 - 铁剑 2.4）

tellraw @s [{"text":"┌─────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"│ 职业名：","color":"gray"},{"text":"战士","color":"green","bold":true}]
tellraw @s [{"text":"│ 分类：","color":"gray"},{"text":"经典（表）","color":"yellow"}]
tellraw @s [{"text":"│ 简介：","color":"gray"},{"text":"铁甲冲锋的正面战士","color":"white"}]
tellraw @s [{"text":"│ 武器单次伤害：","color":"gray"},{"text":"6","color":"white"}]
tellraw @s [{"text":"│ 武器攻击速度：","color":"gray"},{"text":"1.6","color":"white"}]
tellraw @s [{"text":"│ 总护甲值：","color":"gray"},{"text":"15","color":"white"}]
tellraw @s [{"text":"│ 总护甲韧性：","color":"gray"},{"text":"0","color":"white"}]
tellraw @s [{"text":"│ 被动：","color":"gray"},{"text":"—","color":"dark_gray"}]
tellraw @s [{"text":"│ 技能：","color":"gray"},{"text":"补给 — 每 40 秒获得 1 个金苹果（上限 1）","color":"aqua"}]
tellraw @s [{"text":"│ 技能冷却：","color":"gray"},{"text":"40 秒","color":"white"}]
tellraw @s [{"text":"└─────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"[ 确认选择 ]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/warrior"},"hoverEvent":{"action":"show_text","contents":[{"text":"装备此职业","color":"gray"}]}},{"text":"  "},{"text":"[ 返回 ]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list"},"hoverEvent":{"action":"show_text","contents":[{"text":"回到职业列表","color":"gray"}]}}]
