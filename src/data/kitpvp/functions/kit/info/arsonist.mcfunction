# ===== 纵火狂 · 职业介绍卡片 =====
# 由 kit/list/* 里点击纵火狂条目时调用，@s = 查看者

tellraw @s [{"text":"┌──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"│ 职业名：","color":"gray"},{"text":"纵火狂","color":"gold","bold":true}]
tellraw @s [{"text":"│ 分类：","color":"gray"},{"text":"经典（表）","color":"white"}]
tellraw @s [{"text":"│ 简介：","color":"gray"},{"text":"把战场烧成灰烬的纵火者","color":"white"}]
tellraw @s [{"text":"│ 武器单次伤害：","color":"gray"},{"text":"5","color":"white"}]
tellraw @s [{"text":"│ 武器攻击速度：","color":"gray"},{"text":"1.6","color":"white"}]
tellraw @s [{"text":"│ 总护甲值：","color":"gray"},{"text":"11","color":"white"}]
tellraw @s [{"text":"│ 总护甲韧性：","color":"gray"},{"text":"0","color":"white"}]
tellraw @s [{"text":"│ 被动：","color":"gray"},{"text":"—","color":"dark_gray"}]
tellraw @s [{"text":"│ 技能：","color":"gray"},{"text":"燃烧瓶","color":"yellow"},{"text":" —— 投掷喷溅药水，落地生成 4x4 火焰，5 秒内无法手动熄灭","color":"white"}]
tellraw @s [{"text":"│ 技能冷却：","color":"gray"},{"text":"45 秒（开局 2 瓶，上限 2 瓶）","color":"white"}]
tellraw @s [{"text":"└──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"[ 确认选择 ]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/arsonist"},"hoverEvent":{"action":"show_text","contents":[{"text":"以纵火狂参战","color":"gray"}]}},{"text":" "},{"text":"[ 返回 ]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:lobby/menu"},"hoverEvent":{"action":"show_text","contents":[{"text":"回到主大厅菜单","color":"gray"}]}}]