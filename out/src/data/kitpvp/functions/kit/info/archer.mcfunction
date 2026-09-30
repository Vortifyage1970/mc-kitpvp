# ===== 弓箭手 · 职业介绍卡片 =====
# 由 kit/list/* 里点击弓箭手条目时调用，@s = 查看者

tellraw @s [{"text":"┌──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"│ 职业名：","color":"gray"},{"text":"弓箭手","color":"aqua","bold":true}]
tellraw @s [{"text":"│ 分类：","color":"gray"},{"text":"经典（表）","color":"white"}]
tellraw @s [{"text":"│ 简介：","color":"gray"},{"text":"远程消耗的射手","color":"white"}]
tellraw @s [{"text":"│ 武器单次伤害：","color":"gray"},{"text":"5","color":"white"}]
tellraw @s [{"text":"│ 武器攻击速度：","color":"gray"},{"text":"1.6","color":"white"}]
tellraw @s [{"text":"│ 总护甲值：","color":"gray"},{"text":"9","color":"white"}]
tellraw @s [{"text":"│ 总护甲韧性：","color":"gray"},{"text":"0","color":"white"}]
tellraw @s [{"text":"│ 被动：","color":"gray"},{"text":"—","color":"dark_gray"}]
tellraw @s [{"text":"│ 技能：","color":"gray"},{"text":"换弹","color":"yellow"},{"text":" —— 丢出自己的弓并捡回，箭数重置为 12","color":"white"}]
tellraw @s [{"text":"│ 技能冷却：","color":"gray"},{"text":"无（拾取即重置）","color":"white"}]
tellraw @s [{"text":"└──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"[ 确认选择 ]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/archer"},"hoverEvent":{"action":"show_text","contents":[{"text":"以弓箭手参战","color":"gray"}]}},{"text":"  "},{"text":"[ 返回 ]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:lobby/menu"},"hoverEvent":{"action":"show_text","contents":[{"text":"回到主大厅菜单","color":"gray"}]}}]
