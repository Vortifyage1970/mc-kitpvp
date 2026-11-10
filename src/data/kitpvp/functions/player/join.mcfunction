# 玩家生命周期起点：由 tick 通过 [tag=!kitpvp.joined] 触发
tag @s add kitpvp.joined

scoreboard players set @s kitpvp.kit 0
scoreboard players set @s kitpvp.cd 0
scoreboard players set @s kitpvp.cd2 0
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3
scoreboard players set @s kitpvp.kills 0
scoreboard players set @s kitpvp.deaths 0
scoreboard players set @s kitpvp.inv 0
scoreboard players operation @s kitpvp.death_seen = @s kitpvp.death_detect
scoreboard players set @s kitpvp.item 0
# 所有 *_last 快照推到当前 used，避免老玩家一进服被误判"刚用过"
scoreboard players operation @s kitpvp.tank_last = @s kitpvp.tank_used
scoreboard players operation @s kitpvp.assassin_last = @s kitpvp.assassin_used
scoreboard players operation @s kitpvp.ready_last = @s kitpvp.ready_used
scoreboard players operation @s kitpvp.soul_warrior_last = @s kitpvp.soul_warrior_used
scoreboard players operation @s kitpvp.soul_archer_last = @s kitpvp.soul_archer_used
scoreboard players operation @s kitpvp.soul_pirate_last = @s kitpvp.soul_pirate_used
scoreboard players operation @s kitpvp.soul_fisher_last = @s kitpvp.soul_fisher_used
scoreboard players operation @s kitpvp.soul_tamer_last = @s kitpvp.soul_tamer_used
scoreboard players operation @s kitpvp.soul_sun_last = @s kitpvp.soul_sun_used
scoreboard players operation @s kitpvp.soul_mercury_last = @s kitpvp.soul_mercury_used
scoreboard players operation @s kitpvp.soul_venus_last = @s kitpvp.soul_venus_used
scoreboard players operation @s kitpvp.soul_slime_last = @s kitpvp.soul_slime_used
scoreboard players set @s kitpvp.bomb_small_cd 0
scoreboard players set @s kitpvp.bomb_big_cd 0
scoreboard players set @s kitpvp.bomb_fake_cd 0
scoreboard players set @s kitpvp.bomb_track_cd 0
scoreboard players set @s kitpvp.bomb_nuke_cd 0
scoreboard players add @s kitpvp.btid 0
scoreboard players operation @s kitpvp.bomb_last = @s kitpvp.bomb_used
scoreboard players operation @s kitpvp.tainted_turret_last = @s kitpvp.tainted_turret_used
scoreboard players operation @s kitpvp.tainted_core_last = @s kitpvp.tainted_core_used
scoreboard players operation @s kitpvp.arsonist_last = @s kitpvp.arsonist_used
scoreboard players operation @s kitpvp.fisher_last = @s kitpvp.fisher_used
scoreboard players set @s kitpvp.arsonist_ammo 0
scoreboard players set @s kitpvp.soul_next 0
scoreboard players set @s kitpvp.rocket_charge 0
scoreboard players operation @s kitpvp.tep_last = @s kitpvp.tep_used
# 传送门配对号：每名玩家一个，只在自己开的门里穿梭
scoreboard players add #tep_pid kitpvp.game 0
execute unless score @s kitpvp.tep_pid matches 1.. run scoreboard players operation @s kitpvp.tep_pid = #tep_pid kitpvp.game
execute unless score @s kitpvp.tep_pid matches 1.. run scoreboard players add #tep_pid kitpvp.game 1
execute if score #tep_pid kitpvp.game matches 65.. run scoreboard players set #tep_pid kitpvp.game 1
scoreboard players set @s kitpvp.tep_cd 0
scoreboard players set @s kitpvp.tep_ready 0
scoreboard players set @s kitpvp.tep_step 0
scoreboard players operation @s kitpvp.ender_last = @s kitpvp.ender_used
scoreboard players set @s kitpvp.ender_ammo 0
scoreboard players operation @s kitpvp.werewolf_last = @s kitpvp.werewolf_used
scoreboard players operation @s kitpvp.tamer_last = @s kitpvp.tamer_used
scoreboard players operation @s kitpvp.tainted_fisher_blue_last = @s kitpvp.tainted_fisher_blue_used
scoreboard players operation @s kitpvp.tainted_fisher_domain_last = @s kitpvp.tainted_fisher_domain_used
scoreboard players operation @s kitpvp.sun_flare_last = @s kitpvp.sun_flare_used
scoreboard players operation @s kitpvp.sun_spot_last = @s kitpvp.sun_spot_used
scoreboard players set @s kitpvp.sun_reload 0
scoreboard players operation @s kitpvp.alchemist_last = @s kitpvp.alchemist_used
scoreboard players operation @s kitpvp.alchemist_drink_last = @s kitpvp.alchemist_drink_used
scoreboard players set @s kitpvp.pa_type 0
scoreboard players set @s kitpvp.pa_type_prev 0
scoreboard players set @s kitpvp.pa_drink_type 0
scoreboard players set @s kitpvp.pa_drink_type_prev 0
scoreboard players operation @s kitpvp.ttamer_zombie_last = @s kitpvp.ttamer_zombie_used
scoreboard players operation @s kitpvp.ttamer_skeleton_last = @s kitpvp.ttamer_skeleton_used
scoreboard players operation @s kitpvp.ttamer_creeper_last = @s kitpvp.ttamer_creeper_used
scoreboard players operation @s kitpvp.ttamer_vindicator_last = @s kitpvp.ttamer_vindicator_used
scoreboard players operation @s kitpvp.ttamer_witch_last = @s kitpvp.ttamer_witch_used
scoreboard players operation @s kitpvp.ttamer_vex_last = @s kitpvp.ttamer_vex_used
scoreboard players operation @s kitpvp.ttamer_blaze_last = @s kitpvp.ttamer_blaze_used
scoreboard players operation @s kitpvp.venus_chill_last = @s kitpvp.venus_chill_used
scoreboard players operation @s kitpvp.venus_arm_last = @s kitpvp.venus_arm_used
scoreboard players operation @s kitpvp.venus_bomb_last = @s kitpvp.venus_bomb_used
scoreboard players set @s kitpvp.coldness 0
scoreboard players set @s kitpvp.venus_cd3 0
scoreboard players set @s kitpvp.venus_dog_timer 0
scoreboard players set @s kitpvp.civil_demon_timer 0
scoreboard players operation @s kitpvp.civil_last = @s kitpvp.civil_used
scoreboard players operation @s kitpvp.civil_demon_last = @s kitpvp.civil_demon_used
scoreboard players operation @s kitpvp.li_pig_last = @s kitpvp.li_pig_used
scoreboard players operation @s kitpvp.earth_last = @s kitpvp.earth_used
tag @s remove kitpvp.civil_demon
tag @s remove kitpvp.hold_cb
tag @s remove kitpvp.hold_cb_prev
scoreboard players add @s kitpvp.vtid 0

function kitpvp:lobby/enter
