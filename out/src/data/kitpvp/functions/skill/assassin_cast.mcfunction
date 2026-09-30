# ===== 刺客：隐匿（主动技能入口） =====
# 触发：tick.mcfunction 检测到"刚用掉一个隐匿令牌"
#       判据：kitpvp.assassin_used > kitpvp.assassin_last
# @s = 刺客
#
# 流程：
#   1. 推进快照，防止下一刻重复触发（漏写会造成无限连放）
#   2. cd <= 0 → 转交 skill/assassin_fire 释放技能
#   3. cd > 0  → 冷却中，仅提示
#      极少数情况能走到这里：玩家捡起了自己/别人丢在地上的旧令牌又右键。

scoreboard players operation @s kitpvp.assassin_last = @s kitpvp.assassin_used

execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/assassin_fire
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"隐匿冷却中","color":"gray"}
