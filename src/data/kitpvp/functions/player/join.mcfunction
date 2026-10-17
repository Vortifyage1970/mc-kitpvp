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
scoreboard players operation @s kitpvp.tainted_turret_last = @s kitpvp.tainted_turret_used
scoreboard players operation @s kitpvp.tainted_core_last = @s kitpvp.tainted_core_used
scoreboard players operation @s kitpvp.arsonist_last = @s kitpvp.arsonist_used
scoreboard players operation @s kitpvp.fisher_last = @s kitpvp.fisher_used
scoreboard players set @s kitpvp.arsonist_ammo 0
scoreboard players set @s kitpvp.soul_next 0
scoreboard players operation @s kitpvp.ender_last = @s kitpvp.ender_used
scoreboard players set @s kitpvp.ender_ammo 0
scoreboard players operation @s kitpvp.werewolf_last = @s kitpvp.werewolf_used
scoreboard players operation @s kitpvp.tamer_last = @s kitpvp.tamer_used
scoreboard players operation @s kitpvp.tainted_fisher_blue_last = @s kitpvp.tainted_fisher_blue_used
scoreboard players operation @s kitpvp.tainted_fisher_domain_last = @s kitpvp.tainted_fisher_domain_used
scoreboard players operation @s kitpvp.sun_flare_last = @s kitpvp.sun_flare_used
scoreboard players operation @s kitpvp.sun_spot_last = @s kitpvp.sun_spot_used
scoreboard players set @s kitpvp.sun_reload 0

function kitpvp:lobby/enter
