# ===== 幽灵 · 职业介绍卡片 =====
# 由 kit/list/classic 里点击幽灵条目时调用，@s = 查看者

tellraw @s [{"text":"┌──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"│ 职业名：","color":"gray"},{"text":"幽灵","color":"light_purple","bold":true}]
tellraw @s [{"text":"│ 分类：","color":"gray"},{"text":"经典（表）","color":"white"}]
tellraw @s [{"text":"│ 简介：","color":"gray"},{"text":"潜行无形的幽魂","color":"white"}]
tellraw @s [{"text":"│ 武器单次伤害：","color":"gray"},{"text":"7","color":"white"}]
tellraw @s [{"text":"│ 武器攻击速度：","color":"gray"},{"text":"1.0","color":"white"}]
tellraw @s [{"text":"│ 总护甲值：","color":"gray"},{"text":"5（穿金胸甲时）","color":"white"}]
tellraw @s [{"text":"│ 总护甲韧性：","color":"gray"},{"text":"0","color":"white"}]
tellraw @s [{"text":"│ 被动：","color":"gray"},{"text":"常态隐身 I、速度 I","color":"yellow"}]
tellraw @s [{"text":"│ 技能：","color":"gray"},{"text":"怨灵","color":"yellow"},{"text":" —— 每次受伤时获得 1 秒发光（无冷却）","color":"white"}]
tellraw @s [{"text":"│ 命数：","color":"gray"},{"text":"1 条（仅一次容错）","color":"red"}]
tellraw @s [{"text":"└──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"[ 确认选择 ]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/ghost"},"hoverEvent":{"action":"show_text","contents":[{"text":"以幽灵参战","color":"gray"}]}},{"text":" "},{"text":"[ 返回 ]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list/classic"},"hoverEvent":{"action":"show_text","contents":[{"text":"回到职业列表","color":"gray"}]}}]
