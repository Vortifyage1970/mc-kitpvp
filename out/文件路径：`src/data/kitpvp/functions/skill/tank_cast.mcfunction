# ===== 坦克：举盾（主动技能入口） =====
# 触发：tick.mcfunction 检测到"刚用掉一个举盾令牌"
#       判据：kitpvp.tank_used > kitpvp.tank_last
# @s = 坦克
#
# 流程：
#   1. 推进快照，防止下一刻重复触发（漏写会造成无限连放）
#   2. cd <= 0 → 转交 skill/tank_fire 给盾、进冷却
#   3. cd > 0  → 冷却中，仅提示
#      极少数情况能走到这里：玩家捡起了自己/别人丢在地上的旧令牌又右键。
#      这种情况下令牌已消耗、技能不放，属于设计接受的惩罚。

scoreboard players operation @s kitpvp.tank_last = @s kitpvp.tank_used

execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/tank_fire
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"举盾冷却中","color":"gray"}
