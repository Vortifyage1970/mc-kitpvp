# 从 B 进 → 从 A 出
execute if entity @e[tag=kitpvp.tep_a] if score @s kitpvp.tep_pid = @e[tag=kitpvp.tep_a,limit=1] kitpvp.tep_owner run function kitpvp:skill/enderman/exit_a
