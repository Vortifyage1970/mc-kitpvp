# 三叉戟扔出去那一刻手上已经空了（而且忠诚会飞回来），所以只能按"当前武器是三叉戟"的 tag 判定
scoreboard players operation @s kitpvp.chaos_tri_last = @s kitpvp.chaos_tri_used
execute if entity @s[tag=kitpvp.chaos_tri] run function kitpvp:kit/chaos_use
