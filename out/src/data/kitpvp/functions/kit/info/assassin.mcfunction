# ===== 职业介绍：刺客（kit = 4） =====
# 调用方：kit/list/classic.mcfunction 点击「刺客」
# 版式对齐 03-project-spec.md 2.3「职业选择界面」
#
# 底部两个按钮：
#   [ 确认选择 ] → /function kitpvp:kit/assassin
#   [ 返回 ]     → /function kitpvp:kit/list/classic
#
# 数值口径：
#   武器单次伤害 8 = 钻石剑 7 + 锋利 II（+1）
#   武器攻击速度 1.6 = 钻石剑默认攻速
#   总护甲值 7 = 皮革四件套 1 + 3 + 2 + 1
#   总护甲韧性 0
# 若本工程其它 info 页用的是"不含附魔"的口径，把 8 改回 7 即可。

tellraw @s [{"text":"┌──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"│ 职业名：","color":"gray"},{"text":"刺客","color":"dark_purple","bold":true}]
tellraw @s [{"text":"│ 分类：","color":"gray"},{"text":"经典（表）","color":"white"}]
tellraw @s [{"text":"│ 简介：","color":"gray"},{"text":"高速突进的暗杀者","color":"white"}]
tellraw @s [{"text":"│ 武器单次伤害：","color":"gray"},{"text":"8","color":"white"}]
tellraw @s [{"text":"│ 武器攻击速度：","color":"gray"},{"text":"1.6","color":"white"}]
tellraw @s [{"text":"│ 总护甲值：","color":"gray"},{"text":"7","color":"white"}]
tellraw @s [{"text":"│ 总护甲韧性：","color":"gray"},{"text":"0","color":"white"}]
tellraw @s [{"text":"│ 被动：","color":"gray"},{"text":"永久 速度 I","color":"white"}]
tellraw @s [{"text":"│ 技能：","color":"gray"},{"text":"隐匿","color":"dark_purple","hoverEvent":{"action":"show_text","contents":"右键「隐匿令牌」（末影人刷怪蛋）触发：5 秒隐身 + 速度 III"}}]
tellraw @s [{"text":"│ 技能冷却：","color":"gray"},{"text":"30 秒","color":"white"}]
tellraw @s [{"text":"│ 命数：","color":"gray"},{"text":"3","color":"white"}]
tellraw @s [{"text":"└──────────────────────────────","color":"dark_gray"}]
tellraw @s [{"text":"[ 确认选择 ]","color":"green","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/assassin"},"hoverEvent":{"action":"show_text","contents":"以刺客身份进入游戏"}},{"text":"  "},{"text":"[ 返回 ]","color":"yellow","bold":true,"clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list/classic"},"hoverEvent":{"action":"show_text","contents":"回到「经典（表）」职业列表"}}]
