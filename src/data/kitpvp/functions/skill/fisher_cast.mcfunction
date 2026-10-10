# ===== 渔夫：寻回三叉戟（主动技能入口） =====
# 触发：tick.mcfunction 检测到"刚用掉一枚寻戟令牌"
#       判据：kitpvp.fisher_used > kitpvp.fisher_last
# @s = 渔夫
#
# 流程：
#   1. 推进快照，防止下一刻重复触发（漏写会造成无限连放）
#   2. cd <= 0 → 转交 skill/fisher_fire 判定并补戟
#   3. cd > 0  → 冷却中，仅提示
#      极少数情况能走到这里：玩家捡起了自己/别人丢在地上的旧令牌又右键。
#      这种情况下令牌已消耗、技能不放，属于设计接受的惩罚。

scoreboard players operation @s kitpvp.fisher_last = @s kitpvp.fisher_used

execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/fisher_fire
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"寻戟冷却中","color":"gray"}
