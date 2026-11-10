# 从 A 进 → 从 B 出（tick 里已经 at 到 A；这里 @s = 玩家、位置 = A）
execute if entity @e[tag=kitpvp.tep_b] if score @s kitpvp.tep_pid = @e[tag=kitpvp.tep_b,limit=1] kitpvp.tep_owner run function kitpvp:skill/enderman/exit_b
