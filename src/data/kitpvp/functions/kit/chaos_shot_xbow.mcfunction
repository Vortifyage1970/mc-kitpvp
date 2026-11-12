# 弓/弩/三叉戟用了一次：推进快照，若手上是对应类武器就扣一次
scoreboard players operation @s kitpvp.chaos_xbow_last = @s kitpvp.chaos_xbow_used
execute if data entity @s SelectedItem.tag.ChaosXbow run function kitpvp:kit/chaos_use
