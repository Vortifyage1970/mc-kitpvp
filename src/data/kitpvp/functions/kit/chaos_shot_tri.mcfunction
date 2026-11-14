# 三叉戟扔出去：先挂"待结算"，等它飞完/飞回来再扣次数——
# 否则第四下蓄力刚出手，chaos_use 立刻把它算成用尽，wipe 会把还在飞的三叉戟杀掉，等于白蓄力
scoreboard players operation @s kitpvp.chaos_tri_last = @s kitpvp.chaos_tri_used
execute if entity @s[tag=kitpvp.chaos_tri] run scoreboard players set @s kitpvp.chaos_tri_pending 1
execute if entity @s[tag=kitpvp.chaos_tri] run scoreboard players set @s kitpvp.chaos_tri_wait 0
