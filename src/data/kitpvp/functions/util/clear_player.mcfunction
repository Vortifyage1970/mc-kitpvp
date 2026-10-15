# 把 @s 清到干净初始状态：背包 / 效果 / 经验 / tag / 分数 / 属性，最后回冒险模式。
# 会清掉 kitpvp.kit——调用方（kit/*）清完立刻写回本职业编号，不是 bug。
# 刻意不清 kitpvp.joined（清了 join 会重复触发）与 kitpvp.in_lobby（on_death 的位置判定依赖它）。
clear @s
effect clear @s
xp set @s 0 points
xp set @s 0 levels

ride @s dismount

tag @s remove kitpvp.selected
tag @s remove kitpvp.invincible
tag @s remove kitpvp.sudden_death
tag @s remove kitpvp.spectator
tag @s remove kitpvp.respawn_pending
tag @s remove kitpvp.death_immune
tag @s remove kitpvp.keep_inventory
tag @s remove kitpvp.shield_held
tag @s remove kitpvp.assassin_hidden
tag @s remove kitpvp.pirate_reload_cd
tag @s remove kitpvp.ready
tag @s remove kitpvp.ready_pending

scoreboard players set @s kitpvp.kit 0
scoreboard players set @s kitpvp.cd 0
scoreboard players set @s kitpvp.cd2 0
scoreboard players set @s kitpvp.inv 0
scoreboard players operation @s kitpvp.death_seen = @s kitpvp.death_detect
scoreboard players set @s kitpvp.item 0
scoreboard players set @s kitpvp.lives 3
scoreboard players set @s kitpvp.kills 0
scoreboard players set @s kitpvp.deaths 0
scoreboard players set @s kitpvp.alive 1
# 所有 *_last 快照推到当前 used，避免清场后下一刻误判"刚用过"（见 05 §7）
scoreboard players operation @s kitpvp.tank_last = @s kitpvp.tank_used
scoreboard players operation @s kitpvp.assassin_last = @s kitpvp.assassin_used
scoreboard players operation @s kitpvp.arsonist_last = @s kitpvp.arsonist_used
scoreboard players operation @s kitpvp.fisher_last = @s kitpvp.fisher_used
scoreboard players operation @s kitpvp.ready_last = @s kitpvp.ready_used
scoreboard players set @s kitpvp.soul_rand 0
scoreboard players set @s kitpvp.soul_next 0
scoreboard players set @s kitpvp.soul_bow_timer 0
scoreboard players set @s kitpvp.soul_pirate_timer 0
scoreboard players operation @s kitpvp.soul_warrior_last = @s kitpvp.soul_warrior_used
scoreboard players operation @s kitpvp.soul_archer_last = @s kitpvp.soul_archer_used
scoreboard players operation @s kitpvp.soul_pirate_last = @s kitpvp.soul_pirate_used
scoreboard players operation @s kitpvp.taint_turret_last = @s kitpvp.taint_turret_used
scoreboard players operation @s kitpvp.taint_core_last = @s kitpvp.taint_core_used
scoreboard players set @s kitpvp.turret_heal_cd 0
tag @s remove kitpvp.soul_bow_held
tag @s remove kitpvp.soul_pirate_held
tag @s remove kitpvp.arrow_user
tag @s remove kitpvp.soul_ghost_active
scoreboard players set @s kitpvp.soul_ghost_timer 0
scoreboard players set @s kitpvp.ghost_minion_cd 0
scoreboard players operation @s kitpvp.soul_ghost_last = @s kitpvp.soul_ghost_used
scoreboard players set @a kitpvp.fisher_no_tri 0
scoreboard players set @s kitpvp.ender_ammo 0
scoreboard players set @s kitpvp.arsonist_ammo 0
scoreboard players operation @s kitpvp.ender_last = @s kitpvp.ender_used
scoreboard players operation @s kitpvp.werewolf_last = @s kitpvp.werewolf_used
scoreboard players operation @s kitpvp.tamer_last = @s kitpvp.tamer_used
scoreboard players set @s kitpvp.werewolf_hit_cd 0

attribute @s minecraft:generic.max_health base set 20
attribute @s minecraft:generic.movement_speed base set 0.1
attribute @s minecraft:generic.attack_damage base set 1
attribute @s minecraft:generic.attack_speed base set 4
attribute @s minecraft:generic.knockback_resistance base set 0
attribute @s minecraft:generic.armor base set 0
attribute @s minecraft:generic.armor_toughness base set 0

gamemode adventure @s
# 1.20.1 无 /heal
effect give @s minecraft:instant_health 1 5 true
