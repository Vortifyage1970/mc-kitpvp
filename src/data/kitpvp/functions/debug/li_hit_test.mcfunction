# 里·附魔师自测：模拟一次「命中玩家」（走 advancement 奖励函数的那段 kit=99 分支）
tellraw @s [{"text":"[自测] 模拟一次命中：领域内应该抽一张卡","color":"yellow"}]
execute if entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/li_ench/draw
execute unless entity @s[tag=kitpvp.ench_domain] run tellraw @s [{"text":"[自测] 你还没展开领域，先右键令牌","color":"red"}]
