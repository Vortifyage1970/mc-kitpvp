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
tag @s remove kitpvp.tank_handout
tag @s remove kitpvp.assassin_handout
tag @s remove kitpvp.fisher_handout
tag @s remove kitpvp.tainted_fisher_cang
tag @s remove kitpvp.tainted_fisher_domain
tag @s remove kitpvp.tainted_fisher_handout
tag @s remove kitpvp.tainted_fisher_self
tag @s remove kitpvp.sun_flare
tag @s remove kitpvp.sun_self
tag @s remove kitpvp.alchemist_elixir_used
tag @s remove kitpvp.venus_dog_dead
tag @s remove kitpvp.civil_demon
tag @s remove kitpvp.hold_cb
tag @s remove kitpvp.hold_cb_prev
tag @s remove kitpvp.hold_pa
tag @s remove kitpvp.hold_pa_prev
tag @s remove kitpvp.hold_pa_drink
tag @s remove kitpvp.hold_pa_drink_prev
tag @s remove kitpvp.in_water
tag @s remove kitpvp.ready
tag @s remove kitpvp.ready_pending

# 只有正在离开金星职业的玩家才清理自己的舔狗；其他职业的 vtid 可能与金星玩家重合
execute if score @s kitpvp.kit matches 67 run scoreboard players add @s kitpvp.vtid 0
execute if score @s kitpvp.kit matches 67 run scoreboard players operation #vtid kitpvp.game = @s kitpvp.vtid
execute if score @s kitpvp.kit matches 67 as @e[type=minecraft:wolf,tag=kitpvp.venus_dog] if score @s kitpvp.dog_owner = #vtid kitpvp.game run kill @s
execute if score @s kitpvp.kit matches 76 run function kitpvp:skill/pluto/despawn
scoreboard players set @s kitpvp.parrot_miss 0

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
# 出生点编号每局由 map/*/spawn_N 重写，先归零（见 04 §十一）
scoreboard players set @s kitpvp.spawn_slot 0
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
scoreboard players set @s kitpvp.soul_fisher_timer 0
scoreboard players set @s kitpvp.soul_zombie_timer 0
scoreboard players operation @s kitpvp.soul_warrior_last = @s kitpvp.soul_warrior_used
scoreboard players operation @s kitpvp.soul_archer_last = @s kitpvp.soul_archer_used
scoreboard players operation @s kitpvp.soul_pirate_last = @s kitpvp.soul_pirate_used
scoreboard players operation @s kitpvp.soul_fisher_last = @s kitpvp.soul_fisher_used
scoreboard players operation @s kitpvp.soul_zombie_last = @s kitpvp.soul_zombie_used
scoreboard players operation @s kitpvp.soul_earth_last = @s kitpvp.soul_earth_used
scoreboard players operation @s kitpvp.soul_li_last = @s kitpvp.soul_li_used
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
scoreboard players set @s kitpvp.turret_heal_cd 0
tag @s remove kitpvp.soul_bow_held
tag @s remove kitpvp.soul_pirate_held
# 僵尸魂石的 +20 生命上限是修饰符，不清掉会跟着带到别的职业 / 下一局（不存在时该命令静默失败）
tag @s remove kitpvp.soul_zombie_active
attribute @s minecraft:generic.max_health modifier remove 00000000-0000-0000-0000-000000000014
tag @s remove kitpvp.soul_fisher_active
tag @s remove kitpvp.arrow_user
tag @s remove kitpvp.soul_ghost_active
tag @s remove kitpvp.soul_venus_owner
tag @s remove kitpvp.soul_sun_owner
# 蓄力火箭跳：tag 是"能不能蓄力"的总开关（里·史莱姆与史莱姆魂石共用），换职业必须摘掉
tag @s remove kitpvp.rocket_jump
tag @s remove kitpvp.rocket_full
tag @s remove kitpvp.rocket_air
tag @s remove kitpvp.soul_slime_active
scoreboard players set @s kitpvp.rocket_charge 0
scoreboard players set @s kitpvp.soul_slime_timer 0
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
scoreboard players operation @s kitpvp.tainted_fisher_blue_last = @s kitpvp.tainted_fisher_blue_used
scoreboard players operation @s kitpvp.tainted_fisher_domain_last = @s kitpvp.tainted_fisher_domain_used
scoreboard players set @s kitpvp.tainted_fisher_cang_timer 0
scoreboard players set @s kitpvp.tainted_fisher_domain_timer 0
scoreboard players set @s kitpvp.sun_flare_timer 0
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


# 水星常驻的 +0.2 移速是玩家身上的属性修饰符，不摘掉会跟着带到别的职业（不存在时该命令静默失败）
attribute @s minecraft:generic.movement_speed modifier remove 00000000-0000-0000-0000-000000000066
# Notch 模式的 +10 攻击（不存在时静默失败）
attribute @s minecraft:generic.attack_damage modifier remove 00000000-0000-0000-0000-000000000077

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
