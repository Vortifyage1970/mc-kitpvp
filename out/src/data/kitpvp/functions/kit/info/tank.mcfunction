# ===== 职业介绍：坦克 =====
# 由职业列表 / 菜单的 [ 查看 ] 按钮触发；@s = 查看者
# ⚠ 本文件的排版/数值需与现有 kit/info/warrior、kit/info/archer 对齐后再定稿；
#   这里「武器单次伤害 5」是按 warrior 的记法（铁剑 6 + 基础 1 = 7）推的，勿盲信。

tellraw @s [{"text":"┌──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"│ 职业名：","color":"gray"},{"text":"坦克","color":"yellow","bold":true}]
tellraw @s [{"text":"│ 分类：","color":"gray"},{"text":"经典（表）","color":"white"}]
tellraw @s [{"text":"│ 简介：","color":"gray"},{"text":"高护甲低速的肉盾","color":"white"}]
tellraw @s [{"text":"│ 武器单次伤害：","color":"gray"},{"text":"5","color":"white"}]
tellraw @s [{"text":"│ 武器攻击速度：","color":"gray"},{"text":"1.6","color":"white"}]
tellraw @s [{"text":"│ 总护甲值：","color":"gray"},{"text":"20","color":"white"}]
tellraw @s [{"text":"│ 总护甲韧性：","color":"gray"},{"text":"8","color":"white"}]
tellraw @s [{"text":"│ 被动：","color":"gray"},{"text":"—","color":"white"}]
tellraw @s [{"text":"│ 技能：","color":"gray"},{"text":"每 30 秒获得一面持续 15 秒的盾（耐久 80）","color":"white"}]
tellraw @s [{"text":"│ 技能冷却：","color":"gray"},{"text":"30 秒","color":"white"}]
tellraw @s [{"text":"└──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"[ 确认选择 ]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/tank"},"hoverEvent":{"action":"show_text","contents":[{"text":"选择坦克","color":"gray"}]}},{"text":"  "},{"text":"[ 返回 ]","color":"gray","clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list"},"hoverEvent":{"action":"show_text","contents":[{"text":"返回职业列表","color":"gray"}]}}]
