# @s = 飞龙宝宝：重置冷却，挑一个"能打的人"，然后从嘴里吐一颗火球
# 能打的人 = 20 格内、非创造/旁观/观战、且**不是召唤者本人**
scoreboard players set @s kitpvp.bw_cd 100
# ⚠ earth_owner 的 0 表示"还没分配槽位"，不能拿 0 去比：owner=0 时跳过"排除主人"这一步，
#   否则会把所有 etid 还没分配到的玩家一起排除掉（mortar_tick 踩过的同一个坑）
scoreboard players set #bw_owner kitpvp.game 0
scoreboard players operation #bw_owner kitpvp.game = @s kitpvp.earth_owner
tag @a remove kitpvp.bw_tgt
execute if score #bw_owner kitpvp.game matches 1.. as @a[distance=..20,gamemode=!spectator,gamemode=!creative,tag=!kitpvp.spectator] unless score @s kitpvp.etid = #bw_owner kitpvp.game run tag @s add kitpvp.bw_tgt
execute unless score #bw_owner kitpvp.game matches 1.. as @a[distance=..20,gamemode=!spectator,gamemode=!creative,tag=!kitpvp.spectator] run tag @s add kitpvp.bw_tgt
execute if entity @a[tag=kitpvp.bw_tgt] run function kitpvp:skill/earth/babywhelp_shoot
