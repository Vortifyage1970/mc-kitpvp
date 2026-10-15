# 首行无条件推进快照，漏写会每刻重复触发
# 令牌本身就是消耗品，所以"用"不等冷却——冷却只卡补货（同纵火狂，见 05 §9）
scoreboard players operation @s kitpvp.tainted_turret_last = @s kitpvp.tainted_turret_used

function kitpvp:skill/tainted_archer/turret_fire
