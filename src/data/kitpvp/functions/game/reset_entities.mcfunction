# 由 tools/gen_cleanup.py 从所有 summon 的 Tags 自动生成 —— 不要手改，改完跑一次工具。
# 每新增一种带 tag 的召唤物，重跑本工具即可；check.py 会拦「忘了重跑」的情况。

# ---- 必须先删（顺序有意义，见每行后面的理由）----
# 守卫：先删守卫，再让本体消失，否则会触发 threshold_death
kill @e[tag=kitpvp.earth_threshold_guard]
# 守卫：同上（hydrator_death）
kill @e[tag=kitpvp.earth_hydrator_guard]
# 时钟：先删时钟，本体消失后不再续播报
kill @e[tag=kitpvp.earth_leaker_clock]

# ---- 其余按 tag 清（111 个；来源写在每行上面的注释里）----
# kitpvp.arsonist_fire  <- place_one
kill @e[tag=kitpvp.arsonist_fire]
# kitpvp.bomb  <- bomber_big, bomber_fake, bomber_nuke, bomber_small, bomber_track
kill @e[tag=kitpvp.bomb]
# kitpvp.bomb_big  <- bomber_big
kill @e[tag=kitpvp.bomb_big]
# kitpvp.bomb_big_token  <- give_big
kill @e[tag=kitpvp.bomb_big_token]
# kitpvp.bomb_fake  <- bomber_fake
kill @e[tag=kitpvp.bomb_fake]
# kitpvp.bomb_fake_token  <- give_fake
kill @e[tag=kitpvp.bomb_fake_token]
# kitpvp.bomb_nuke  <- bomber_nuke
kill @e[tag=kitpvp.bomb_nuke]
# kitpvp.bomb_nuke_token  <- give_nuke
kill @e[tag=kitpvp.bomb_nuke_token]
# kitpvp.bomb_rider  <- bomber_track
kill @e[tag=kitpvp.bomb_rider]
# kitpvp.bomb_small  <- bomber_small
kill @e[tag=kitpvp.bomb_small]
# kitpvp.bomb_small_token  <- give_small
kill @e[tag=kitpvp.bomb_small_token]
# kitpvp.bomb_token  <- give_big, give_fake, give_nuke, give_small, give_track
kill @e[tag=kitpvp.bomb_token]
# kitpvp.bomb_track  <- bomber_track
kill @e[tag=kitpvp.bomb_track]
# kitpvp.bomb_track_token  <- give_track
kill @e[tag=kitpvp.bomb_track_token]
# kitpvp.burger_beast  <- burger_beast
kill @e[tag=kitpvp.burger_beast]
# kitpvp.civil_token  <- give_demon_token
kill @e[tag=kitpvp.civil_token]
# kitpvp.debug_dummy  <- dummy
kill @e[tag=kitpvp.debug_dummy]
# kitpvp.earth_boat1  <- earth_boatman_wet
kill @e[tag=kitpvp.earth_boat1]
# kitpvp.earth_boatman1  <- earth_boatman_wet
kill @e[tag=kitpvp.earth_boatman1]
# kitpvp.earth_bomb  <- earth_big_bomb, earth_tracker_bomb
kill @e[tag=kitpvp.earth_bomb]
# kitpvp.earth_cart_boat  <- earth_minecart, earth_minecart_plain
kill @e[tag=kitpvp.earth_cart_boat]
# kitpvp.earth_disruptor  <- earth_disruptor
kill @e[tag=kitpvp.earth_disruptor]
# kitpvp.earth_dominion  <- earth_dominion
kill @e[tag=kitpvp.earth_dominion]
# kitpvp.earth_farmer  <- earth_farmer
kill @e[tag=kitpvp.earth_farmer]
# kitpvp.earth_firework  <- dominion_firework
kill @e[tag=kitpvp.earth_firework]
# kitpvp.earth_fw_mark  <- dominion_firework
kill @e[tag=kitpvp.earth_fw_mark]
# kitpvp.earth_gatherer  <- earth_gatherer
kill @e[tag=kitpvp.earth_gatherer]
# kitpvp.earth_grass  <- earth_grass
kill @e[tag=kitpvp.earth_grass]
# kitpvp.earth_hacker  <- earth_hacker
kill @e[tag=kitpvp.earth_hacker]
# kitpvp.earth_hydrator  <- earth_hydrator
kill @e[tag=kitpvp.earth_hydrator]
# kitpvp.earth_ilsacul  <- earth_ilsacul, li_pig_copy
kill @e[tag=kitpvp.earth_ilsacul]
# kitpvp.earth_leaker  <- earth_leaker
kill @e[tag=kitpvp.earth_leaker]
# kitpvp.earth_leaker_1  <- earth_leaker
kill @e[tag=kitpvp.earth_leaker_1]
# kitpvp.earth_leaker_2  <- earth_leaker
kill @e[tag=kitpvp.earth_leaker_2]
# kitpvp.earth_leaker_3  <- earth_leaker
kill @e[tag=kitpvp.earth_leaker_3]
# kitpvp.earth_levitate  <- earth_ascend
kill @e[tag=kitpvp.earth_levitate]
# kitpvp.earth_manhole  <- earth_manhole
kill @e[tag=kitpvp.earth_manhole]
# kitpvp.earth_minecart  <- earth_minecart, earth_minecart_plain
kill @e[tag=kitpvp.earth_minecart]
# kitpvp.earth_minecart_boat  <- earth_minecart, earth_minecart_plain
kill @e[tag=kitpvp.earth_minecart_boat]
# kitpvp.earth_minion  <- earth_ascend, earth_astronaut, earth_axe, earth_big_bomb, earth_boatman_wet, earth_brick_fire, earth_brick_knockback, earth_dispenser, earth_disruptor, earth_dominion, earth_farmer, earth_fisher1, earth_fisher2, earth_forester, earth_gatherer, earth_ghost_minion, earth_grass, earth_grass_pop, earth_hacker, earth_hydrator, earth_ilsacul, earth_leaker, earth_manhole, earth_mercury, earth_minecart, earth_minecart_plain, earth_qin, earth_retainer, earth_sheep, earth_skater, earth_stone, earth_target, earth_threshold, earth_tracker_bomb, earth_turret, li_pig_copy
kill @e[tag=kitpvp.earth_minion]
# kitpvp.earth_mount  <- earth_boatman_wet, earth_fisher1, earth_fisher2, earth_minecart, earth_minecart_plain, earth_qin, earth_retainer
kill @e[tag=kitpvp.earth_mount]
# kitpvp.earth_qin  <- earth_qin
kill @e[tag=kitpvp.earth_qin]
# kitpvp.earth_qin_bear  <- earth_qin
kill @e[tag=kitpvp.earth_qin_bear]
# kitpvp.earth_retainer  <- earth_retainer
kill @e[tag=kitpvp.earth_retainer]
# kitpvp.earth_retainer_mount  <- earth_retainer
kill @e[tag=kitpvp.earth_retainer_mount]
# kitpvp.earth_sheep  <- earth_sheep
kill @e[tag=kitpvp.earth_sheep]
# kitpvp.earth_skater  <- earth_skater
kill @e[tag=kitpvp.earth_skater]
# kitpvp.earth_threshold  <- earth_threshold
kill @e[tag=kitpvp.earth_threshold]
# kitpvp.earth_token  <- give_egg
kill @e[tag=kitpvp.earth_token]
# kitpvp.earth_tracker  <- earth_tracker_bomb
kill @e[tag=kitpvp.earth_tracker]
# kitpvp.gatherer_self  <- earth_gatherer
kill @e[tag=kitpvp.gatherer_self]
# kitpvp.ghost_minion  <- ghost_minion
kill @e[tag=kitpvp.ghost_minion]
# kitpvp.halley_token  <- give_egg
kill @e[tag=kitpvp.halley_token]
# kitpvp.li_bomb  <- boom5, boom8
kill @e[tag=kitpvp.li_bomb]
# kitpvp.li_pig  <- earth_ilsacul, give_egg, li_apply, li_pig_copy
kill @e[tag=kitpvp.li_pig]
# kitpvp.mars_controller  <- giant_spawn
kill @e[tag=kitpvp.mars_controller]
# kitpvp.mars_giant  <- giant_spawn
kill @e[tag=kitpvp.mars_giant]
# kitpvp.mars_token  <- mars
kill @e[tag=kitpvp.mars_token]
# kitpvp.mars_wild  <- wild_random, wild_spawn
kill @e[tag=kitpvp.mars_wild]
# kitpvp.pluto_parrot  <- pluto_parrot
kill @e[tag=kitpvp.pluto_parrot]
# kitpvp.soul_earth_marker  <- earth_apply
kill @e[tag=kitpvp.soul_earth_marker]
# kitpvp.soul_ep_token  <- give
kill @e[tag=kitpvp.soul_ep_token]
# kitpvp.soul_farm_leader  <- soul_farm_leader
kill @e[tag=kitpvp.soul_farm_leader]
# kitpvp.soul_farm_token  <- give
kill @e[tag=kitpvp.soul_farm_token]
# kitpvp.soul_fisher_token  <- give
kill @e[tag=kitpvp.soul_fisher_token]
# kitpvp.soul_li_pig  <- li_apply
kill @e[tag=kitpvp.soul_li_pig]
# kitpvp.soul_mars_controller  <- mars_spawn
kill @e[tag=kitpvp.soul_mars_controller]
# kitpvp.soul_mars_giant  <- mars_spawn
kill @e[tag=kitpvp.soul_mars_giant]
# kitpvp.soul_mars_token  <- give
kill @e[tag=kitpvp.soul_mars_token]
# kitpvp.soul_mars_wild  <- mars_wild_spawn
kill @e[tag=kitpvp.soul_mars_wild]
# kitpvp.soul_mercury_token  <- give
kill @e[tag=kitpvp.soul_mercury_token]
# kitpvp.soul_slime_token  <- give
kill @e[tag=kitpvp.soul_slime_token]
# kitpvp.soul_sun_token  <- give
kill @e[tag=kitpvp.soul_sun_token]
# kitpvp.soul_tamer_animal  <- tamer_animal
kill @e[tag=kitpvp.soul_tamer_animal]
# kitpvp.soul_tamer_marker  <- tamer_apply
kill @e[tag=kitpvp.soul_tamer_marker]
# kitpvp.soul_tamer_token  <- give
kill @e[tag=kitpvp.soul_tamer_token]
# kitpvp.soul_tamer_wolf  <- tamer_wave
kill @e[tag=kitpvp.soul_tamer_wolf]
# kitpvp.soul_venus_bomb  <- venus_end
kill @e[tag=kitpvp.soul_venus_bomb]
# kitpvp.soul_venus_dog  <- venus_apply
kill @e[tag=kitpvp.soul_venus_dog]
# kitpvp.soul_venus_token  <- give
kill @e[tag=kitpvp.soul_venus_token]
# kitpvp.spawn_anchor  <- spawn_1, spawn_2, spawn_3, spawn_4, spawn_5, spawn_6, spawn_7, spawn_8, spawn_9
kill @e[tag=kitpvp.spawn_anchor]
# kitpvp.sun_flare_token  <- give_flare
kill @e[tag=kitpvp.sun_flare_token]
# kitpvp.sun_spot_token  <- give_spot
kill @e[tag=kitpvp.sun_spot_token]
# kitpvp.tainted_fisher_blue_token  <- give_blue
kill @e[tag=kitpvp.tainted_fisher_blue_token]
# kitpvp.tainted_fisher_domain_token  <- give_domain
kill @e[tag=kitpvp.tainted_fisher_domain_token]
# kitpvp.tamer_wolf  <- give_egg
kill @e[tag=kitpvp.tamer_wolf]
# kitpvp.tep_a  <- portal_place
kill @e[tag=kitpvp.tep_a]
# kitpvp.tep_b  <- portal_place
kill @e[tag=kitpvp.tep_b]
# kitpvp.tep_p  <- portal_place
kill @e[tag=kitpvp.tep_p]
# kitpvp.tep_portal  <- portal_place
kill @e[tag=kitpvp.tep_portal]
# kitpvp.tep_r  <- portal_place
kill @e[tag=kitpvp.tep_r]
# kitpvp.test_dummy  <- zombie_iron_armor, zombie_iron_helmet
kill @e[tag=kitpvp.test_dummy]
# kitpvp.tf_leader  <- soul_farm_leader, tainted_farmer_leader
kill @e[tag=kitpvp.tf_leader]
# kitpvp.tf_stone  <- tainted_farmer_stone
kill @e[tag=kitpvp.tf_stone]
# kitpvp.tf_wood  <- tainted_farmer_wood
kill @e[tag=kitpvp.tf_wood]
# kitpvp.token_core  <- give_token_core
kill @e[tag=kitpvp.token_core]
# kitpvp.token_turret  <- give_token_turret
kill @e[tag=kitpvp.token_turret]
# kitpvp.tt_minion  <- tainted_tamer_blaze, tainted_tamer_creeper, tainted_tamer_skeleton, tainted_tamer_vex, tainted_tamer_vindicator, tainted_tamer_witch, tainted_tamer_zombie
kill @e[tag=kitpvp.tt_minion]
# kitpvp.tt_spawn  <- give1, give2
kill @e[tag=kitpvp.tt_spawn]
# kitpvp.tt_spawn_blaze  <- give2
kill @e[tag=kitpvp.tt_spawn_blaze]
# kitpvp.tt_spawn_creeper  <- give1
kill @e[tag=kitpvp.tt_spawn_creeper]
# kitpvp.tt_spawn_skeleton  <- give1
kill @e[tag=kitpvp.tt_spawn_skeleton]
# kitpvp.tt_spawn_vex  <- give2
kill @e[tag=kitpvp.tt_spawn_vex]
# kitpvp.tt_spawn_vindicator  <- give2
kill @e[tag=kitpvp.tt_spawn_vindicator]
# kitpvp.tt_spawn_witch  <- give2
kill @e[tag=kitpvp.tt_spawn_witch]
# kitpvp.tt_spawn_zombie  <- give1
kill @e[tag=kitpvp.tt_spawn_zombie]
# kitpvp.turret  <- turret
kill @e[tag=kitpvp.turret]
# kitpvp.venus_bomb_creeper  <- venus_bomb
kill @e[tag=kitpvp.venus_bomb_creeper]
# kitpvp.venus_dog  <- venus_dog
kill @e[tag=kitpvp.venus_dog]
# kitpvp.venus_token  <- give_arm, give_bomb, give_chill
kill @e[tag=kitpvp.venus_token]
# kitpvp.werewolf_token  <- give_egg
kill @e[tag=kitpvp.werewolf_token]
