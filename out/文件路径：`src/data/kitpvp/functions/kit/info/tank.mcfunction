# ===== 坦克 · 职业介绍卡片 =====
# 由 kit/list/classic 里点击坦克条目时调用，@s = 查看者

tellraw @s [{"text":"┌──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"│ 职业名：","color":"gray"},{"text":"坦克","color":"yellow","bold":true}]
tellraw @s [{"text":"│ 分类：","color":"gray"},{"text":"经典（表）","color":"white"}]
tellraw @s [{"text":"│ 简介：","color":"gray"},{"text":"高护甲低速的肉盾","color":"white"}]
tellraw @s [{"text":"│ 武器单次伤害：","color":"gray"},{"text":"4","color":"white"}]
tellraw @s [{"text":"│ 武器攻击速度：","color":"gray"},{"text":"1.6","color":"white"}]
tellraw @s [{"text":"│ 总护甲值：","color":"gray"},{"text":"20","color":"white"}]
tellraw @s [{"text":"│ 总护甲韧性：","color":"gray"},{"text":"8","color":"white"}]
tellraw @s [{"text":"│ 被动：","color":"gray"},{"text":"缓慢 I、挖掘疲劳 I","color":"yellow"}]
tellraw @s [{"text":"│ 技能：","color":"gray"},{"text":"举盾","color":"yellow"},{"text":" —— 右键\"举盾令牌\"，获得 1 个持续 15 秒、剩余耐久 80 的盾","color":"white"}]
tellraw @s [{"text":"│ 技能冷却：","color":"gray"},{"text":"30 秒（从给盾一瞬间起算）","color":"white"}]
tellraw @s [{"text":"└──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"[ 确认选择 ]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/tank"},"hoverEvent":{"action":"show_text","contents":[{"text":"以坦克参战","color":"gray"}]}},{"text":" "},{"text":"[ 返回 ]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:lobby/menu"},"hoverEvent":{"action":"show_text","contents":[{"text":"回到主大厅菜单","color":"gray"}]}}]
