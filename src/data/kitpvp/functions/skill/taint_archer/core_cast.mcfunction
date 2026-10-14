# 首行无条件推进快照，漏写会每刻重复触发
# 令牌持有上限 1，用不用不等冷却；冷却只卡补货，且走第二技能槽 cd2（与炮台互不顶掉）
scoreboard players operation @s kitpvp.taint_core_last = @s kitpvp.taint_core_used

function kitpvp:skill/taint_archer/core_fire
