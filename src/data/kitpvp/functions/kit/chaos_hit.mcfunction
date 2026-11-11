# 每次打到人：混沌战士如果手上已经空了（武器刚碎），立刻换下一把
advancement revoke @s only kitpvp:player/chaos_hit
execute if score @s kitpvp.kit matches 45 unless data entity @s SelectedItem run function kitpvp:kit/chaos_next
