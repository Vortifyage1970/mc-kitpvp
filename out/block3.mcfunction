# 坦克统计快照：清场时把 last 推到 used，避免清场后下一刻误判
scoreboard players operation @s kitpvp.tank_last = @s kitpvp.tank_used
scoreboard players operation @s kitpvp.assassin_last = @s kitpvp.assassin_used
scoreboard players operation @s kitpvp.arsonist_last = @s kitpvp.arsonist_used
# 主大厅准备钓竿快照：同上
scoreboard players operation @s kitpvp.ready_last = @s kitpvp.ready_used
scoreboard players set @s kitpvp.soul_rand 0
scoreboard players set @s kitpvp.soul_bow_timer 0
scoreboard players operation @s kitpvp.soul_warrior_last = @s kitpvp.soul_warrior_used
scoreboard players operation @s kitpvp.soul_archer_last = @s kitpvp.soul_archer_used
scoreboard players set @s kitpvp.arsonist_ammo 2
tag @s remove kitpvp.soul_bow_held
tag @s remove kitpvp.arsonist_burst
