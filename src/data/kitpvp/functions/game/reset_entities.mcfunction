# 由 tools/gen_cleanup.py 从所有 summon 的 Tags 自动生成 —— 不要手改，改完跑一次工具。
# 每新增一种带 tag 的召唤物，重跑本工具即可；check.py 会拦「忘了重跑」的情况。

# ---- 必须先删（顺序有意义，见每行后面的理由）----
# 守卫：先删守卫，再让本体消失，否则会触发 threshold_death
kill @e[tag=kitpvp.earth_threshold_guard]
# 守卫：同上（hydrator_death）
kill @e[tag=kitpvp.earth_hydrator_guard]
# 时钟：先删时钟，本体消失后不再续播报
kill @e[tag=kitpvp.earth_leaker_clock]

# ---- 其余按 tag 清（216 个；来源写在每行上面的注释里）----
# kitpvp.arsonist_fire  <- place_one
kill @e[tag=kitpvp.arsonist_fire]
# kitpvp.assassin_token  <- give_item
kill @e[tag=kitpvp.assassin_token]
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
# kitpvp.brw_harm  <- brewer_drop
kill @e[tag=kitpvp.brw_harm]
# kitpvp.brw_nausea  <- brewer_drop
kill @e[tag=kitpvp.brw_nausea]
# kitpvp.brw_potion  <- brewer_drop
kill @e[tag=kitpvp.brw_potion]
# kitpvp.brw_resist  <- brewer_drop
kill @e[tag=kitpvp.brw_resist]
# kitpvp.brw_speed  <- brewer_drop
kill @e[tag=kitpvp.brw_speed]
# kitpvp.brw_strength  <- brewer_drop
kill @e[tag=kitpvp.brw_strength]
# kitpvp.burger_beast  <- burger_beast
kill @e[tag=kitpvp.burger_beast]
# kitpvp.bw_ball  <- babywhelp_shoot
kill @e[tag=kitpvp.bw_ball]
# kitpvp.civil_token  <- give_demon_token
kill @e[tag=kitpvp.civil_token]
# kitpvp.cizhi_token  <- give_token
kill @e[tag=kitpvp.cizhi_token]
# kitpvp.coser_paper  <- coser_paper
kill @e[tag=kitpvp.coser_paper]
# kitpvp.cz_target  <- pull
kill @e[tag=kitpvp.cz_target]
# kitpvp.debug_dummy  <- dummy
kill @e[tag=kitpvp.debug_dummy]
# kitpvp.earth_amino  <- earth_polypeptide, earth_polypeptide_betaturn
kill @e[tag=kitpvp.earth_amino]
# kitpvp.earth_atrain  <- earth_atrain
kill @e[tag=kitpvp.earth_atrain]
# kitpvp.earth_babywhelp  <- earth_babywhelp
kill @e[tag=kitpvp.earth_babywhelp]
# kitpvp.earth_boat1  <- earth_boatman_wet
kill @e[tag=kitpvp.earth_boat1]
# kitpvp.earth_boatman1  <- earth_boatman_wet
kill @e[tag=kitpvp.earth_boatman1]
# kitpvp.earth_bomb  <- earth_big_bomb, earth_tracker_bomb
kill @e[tag=kitpvp.earth_bomb]
# kitpvp.earth_brewer  <- earth_brewer
kill @e[tag=kitpvp.earth_brewer]
# kitpvp.earth_campfire  <- earth_campfire
kill @e[tag=kitpvp.earth_campfire]
# kitpvp.earth_capital_loot  <- capitalist_drop
kill @e[tag=kitpvp.earth_capital_loot]
# kitpvp.earth_capitalist  <- earth_capitalist
kill @e[tag=kitpvp.earth_capitalist]
# kitpvp.earth_capitalist_guard  <- earth_capitalist
kill @e[tag=kitpvp.earth_capitalist_guard]
# kitpvp.earth_captain  <- earth_captain
kill @e[tag=kitpvp.earth_captain]
# kitpvp.earth_cart_boat  <- earth_minecart, earth_minecart_plain
kill @e[tag=kitpvp.earth_cart_boat]
# kitpvp.earth_carto  <- earth_carto
kill @e[tag=kitpvp.earth_carto]
# kitpvp.earth_colorchanger  <- earth_colorchanger
kill @e[tag=kitpvp.earth_colorchanger]
# kitpvp.earth_cop  <- earth_cop
kill @e[tag=kitpvp.earth_cop]
# kitpvp.earth_cop_blink  <- earth_cop_blink
kill @e[tag=kitpvp.earth_cop_blink]
# kitpvp.earth_cop_cart  <- earth_cop, earth_cop_blink, earth_cop_cleaner
kill @e[tag=kitpvp.earth_cop_cart]
# kitpvp.earth_cop_cleaner  <- earth_cop_cleaner
kill @e[tag=kitpvp.earth_cop_cleaner]
# kitpvp.earth_coser  <- earth_coser
kill @e[tag=kitpvp.earth_coser]
# kitpvp.earth_cyclic  <- earth_cyclic
kill @e[tag=kitpvp.earth_cyclic]
# kitpvp.earth_disruptor  <- earth_disruptor
kill @e[tag=kitpvp.earth_disruptor]
# kitpvp.earth_dominion  <- earth_dominion
kill @e[tag=kitpvp.earth_dominion]
# kitpvp.earth_dublinn  <- earth_dublinn
kill @e[tag=kitpvp.earth_dublinn]
# kitpvp.earth_dublinn_zombie  <- earth_dublinn
kill @e[tag=kitpvp.earth_dublinn_zombie]
# kitpvp.earth_explainer  <- earth_explainer
kill @e[tag=kitpvp.earth_explainer]
# kitpvp.earth_farmer  <- earth_farmer
kill @e[tag=kitpvp.earth_farmer]
# kitpvp.earth_firework  <- dominion_firework
kill @e[tag=kitpvp.earth_firework]
# kitpvp.earth_fw_mark  <- dominion_firework
kill @e[tag=kitpvp.earth_fw_mark]
# kitpvp.earth_gatherer  <- earth_gatherer
kill @e[tag=kitpvp.earth_gatherer]
# kitpvp.earth_gearbox  <- earth_gearbox
kill @e[tag=kitpvp.earth_gearbox]
# kitpvp.earth_gentleman  <- earth_gentleman
kill @e[tag=kitpvp.earth_gentleman]
# kitpvp.earth_grass  <- earth_grass
kill @e[tag=kitpvp.earth_grass]
# kitpvp.earth_hacker  <- earth_hacker
kill @e[tag=kitpvp.earth_hacker]
# kitpvp.earth_hive  <- earth_hive
kill @e[tag=kitpvp.earth_hive]
# kitpvp.earth_hydrator  <- earth_hydrator
kill @e[tag=kitpvp.earth_hydrator]
# kitpvp.earth_ilsacul  <- earth_ilsacul, li_pig_copy
kill @e[tag=kitpvp.earth_ilsacul]
# kitpvp.earth_janitor  <- earth_janitor
kill @e[tag=kitpvp.earth_janitor]
# kitpvp.earth_jar  <- earth_jar, earth_jar_small
kill @e[tag=kitpvp.earth_jar]
# kitpvp.earth_jar_guard  <- earth_jar, earth_jar_small
kill @e[tag=kitpvp.earth_jar_guard]
# kitpvp.earth_jupiter  <- earth_jupiter
kill @e[tag=kitpvp.earth_jupiter]
# kitpvp.earth_jupiter_guard  <- earth_jupiter
kill @e[tag=kitpvp.earth_jupiter_guard]
# kitpvp.earth_leaker  <- earth_leaker
kill @e[tag=kitpvp.earth_leaker]
# kitpvp.earth_leaker_1  <- earth_leaker
kill @e[tag=kitpvp.earth_leaker_1]
# kitpvp.earth_leaker_2  <- earth_leaker
kill @e[tag=kitpvp.earth_leaker_2]
# kitpvp.earth_leaker_3  <- earth_leaker
kill @e[tag=kitpvp.earth_leaker_3]
# kitpvp.earth_levitate  <- earth_ascend, earth_ascend2
kill @e[tag=kitpvp.earth_levitate]
# kitpvp.earth_lowflyer  <- earth_lowflyer_a, earth_lowflyer_b
kill @e[tag=kitpvp.earth_lowflyer]
# kitpvp.earth_lowflyer_body  <- earth_lowflyer_b
kill @e[tag=kitpvp.earth_lowflyer_body]
# kitpvp.earth_lowflyer_carrier  <- earth_lowflyer_a
kill @e[tag=kitpvp.earth_lowflyer_carrier]
# kitpvp.earth_manhole  <- earth_manhole
kill @e[tag=kitpvp.earth_manhole]
# kitpvp.earth_medium  <- earth_medium
kill @e[tag=kitpvp.earth_medium]
# kitpvp.earth_minecart  <- earth_minecart, earth_minecart_plain
kill @e[tag=kitpvp.earth_minecart]
# kitpvp.earth_minecart_boat  <- earth_minecart, earth_minecart_plain
kill @e[tag=kitpvp.earth_minecart_boat]
# kitpvp.earth_minion  <- earth_ascend, earth_ascend2, earth_astronaut, earth_atrain, earth_axe, earth_babywhelp, earth_big_bomb, earth_boatman_wet, earth_brewer, earth_brick_fire, earth_brick_knockback, earth_campfire, earth_capitalist, earth_captain, earth_carto, earth_colorchanger, earth_cop, earth_cop_blink, earth_cop_cleaner, earth_coser, earth_cyclic, earth_dispenser, earth_disruptor, earth_dominion, earth_dublinn, earth_explainer, earth_farmer, earth_fisher1, earth_fisher2, earth_forester, earth_gatherer, earth_gearbox, earth_gentleman, earth_ghost_minion, earth_grass, earth_grass_pop, earth_hacker, earth_hive, earth_hydrator, earth_ilsacul, earth_janitor, earth_jar, earth_jar_small, earth_jupiter, earth_leaker, earth_lowflyer_a, earth_lowflyer_b, earth_manhole, earth_medium, earth_mercury, earth_minecart, earth_minecart_plain, earth_mobilizer, earth_mortar, earth_noteblock, earth_ollama, earth_phoenix, earth_pluto, earth_polypeptide, earth_polypeptide_betaturn, earth_qin, earth_retainer, earth_saturn, earth_sheep, earth_skater, earth_sparky, earth_spellblade, earth_spoon, earth_stone, earth_supporter_fast, earth_supporter_slow, earth_tandem, earth_target, earth_threshold, earth_tracker_bomb, earth_turret, earth_twinstar_a, earth_twinstar_b, earth_vagrant, earth_venus, earth_winner, li_pig_copy, phoenix_reborn
kill @e[tag=kitpvp.earth_minion]
# kitpvp.earth_mobilizer  <- earth_mobilizer
kill @e[tag=kitpvp.earth_mobilizer]
# kitpvp.earth_mobilizer_guard  <- earth_mobilizer
kill @e[tag=kitpvp.earth_mobilizer_guard]
# kitpvp.earth_mortar  <- earth_mortar
kill @e[tag=kitpvp.earth_mortar]
# kitpvp.earth_mount  <- earth_boatman_wet, earth_cop, earth_cop_blink, earth_cop_cleaner, earth_dublinn, earth_fisher1, earth_fisher2, earth_minecart, earth_minecart_plain, earth_qin, earth_retainer
kill @e[tag=kitpvp.earth_mount]
# kitpvp.earth_noteblock  <- earth_noteblock
kill @e[tag=kitpvp.earth_noteblock]
# kitpvp.earth_noteblock_guard  <- earth_noteblock
kill @e[tag=kitpvp.earth_noteblock_guard]
# kitpvp.earth_ollama  <- earth_ollama
kill @e[tag=kitpvp.earth_ollama]
# kitpvp.earth_phoenix  <- earth_phoenix, phoenix_reborn
kill @e[tag=kitpvp.earth_phoenix]
# kitpvp.earth_phoenix_guard  <- earth_phoenix_pair
kill @e[tag=kitpvp.earth_phoenix_guard]
# kitpvp.earth_pluto  <- earth_pluto
kill @e[tag=kitpvp.earth_pluto]
# kitpvp.earth_pluto_carrier  <- earth_pluto
kill @e[tag=kitpvp.earth_pluto_carrier]
# kitpvp.earth_pluto_parrot  <- earth_pluto
kill @e[tag=kitpvp.earth_pluto_parrot]
# kitpvp.earth_polypeptide  <- earth_polypeptide
kill @e[tag=kitpvp.earth_polypeptide]
# kitpvp.earth_polypeptide_betaturn  <- earth_polypeptide_betaturn
kill @e[tag=kitpvp.earth_polypeptide_betaturn]
# kitpvp.earth_polypeptide_betaturn_a  <- earth_polypeptide_betaturn
kill @e[tag=kitpvp.earth_polypeptide_betaturn_a]
# kitpvp.earth_polypeptide_betaturn_tail1  <- earth_polypeptide_betaturn
kill @e[tag=kitpvp.earth_polypeptide_betaturn_tail1]
# kitpvp.earth_polypeptide_betaturn_tail2  <- earth_polypeptide_betaturn
kill @e[tag=kitpvp.earth_polypeptide_betaturn_tail2]
# kitpvp.earth_polypeptide_betaturn_tail3  <- earth_polypeptide_betaturn
kill @e[tag=kitpvp.earth_polypeptide_betaturn_tail3]
# kitpvp.earth_polypeptide_betaturn_tail4  <- earth_polypeptide_betaturn
kill @e[tag=kitpvp.earth_polypeptide_betaturn_tail4]
# kitpvp.earth_polypeptide_betaturn_tail5  <- earth_polypeptide_betaturn
kill @e[tag=kitpvp.earth_polypeptide_betaturn_tail5]
# kitpvp.earth_qin  <- earth_qin
kill @e[tag=kitpvp.earth_qin]
# kitpvp.earth_qin_bear  <- earth_qin
kill @e[tag=kitpvp.earth_qin_bear]
# kitpvp.earth_retainer  <- earth_retainer
kill @e[tag=kitpvp.earth_retainer]
# kitpvp.earth_retainer_mount  <- earth_retainer
kill @e[tag=kitpvp.earth_retainer_mount]
# kitpvp.earth_ring_1  <- earth_cyclic
kill @e[tag=kitpvp.earth_ring_1]
# kitpvp.earth_ring_2  <- earth_cyclic
kill @e[tag=kitpvp.earth_ring_2]
# kitpvp.earth_ring_3  <- earth_cyclic
kill @e[tag=kitpvp.earth_ring_3]
# kitpvp.earth_ring_4  <- earth_cyclic
kill @e[tag=kitpvp.earth_ring_4]
# kitpvp.earth_ring_5  <- earth_cyclic
kill @e[tag=kitpvp.earth_ring_5]
# kitpvp.earth_ring_6  <- earth_cyclic
kill @e[tag=kitpvp.earth_ring_6]
# kitpvp.earth_ring_7  <- earth_cyclic
kill @e[tag=kitpvp.earth_ring_7]
# kitpvp.earth_ring_8  <- earth_cyclic
kill @e[tag=kitpvp.earth_ring_8]
# kitpvp.earth_saturn  <- earth_saturn
kill @e[tag=kitpvp.earth_saturn]
# kitpvp.earth_sheep  <- earth_sheep
kill @e[tag=kitpvp.earth_sheep]
# kitpvp.earth_skater  <- earth_skater
kill @e[tag=kitpvp.earth_skater]
# kitpvp.earth_snow  <- snow_place
kill @e[tag=kitpvp.earth_snow]
# kitpvp.earth_sparky  <- earth_sparky
kill @e[tag=kitpvp.earth_sparky]
# kitpvp.earth_spellblade  <- earth_spellblade
kill @e[tag=kitpvp.earth_spellblade]
# kitpvp.earth_spoon  <- earth_spoon
kill @e[tag=kitpvp.earth_spoon]
# kitpvp.earth_supporter  <- earth_supporter_fast, earth_supporter_slow
kill @e[tag=kitpvp.earth_supporter]
# kitpvp.earth_tandem  <- earth_tandem
kill @e[tag=kitpvp.earth_tandem]
# kitpvp.earth_tandem_a  <- earth_tandem
kill @e[tag=kitpvp.earth_tandem_a]
# kitpvp.earth_tandem_b  <- earth_tandem
kill @e[tag=kitpvp.earth_tandem_b]
# kitpvp.earth_threshold  <- earth_threshold
kill @e[tag=kitpvp.earth_threshold]
# kitpvp.earth_token  <- give_egg
kill @e[tag=kitpvp.earth_token]
# kitpvp.earth_tracker  <- earth_tracker_bomb
kill @e[tag=kitpvp.earth_tracker]
# kitpvp.earth_twinstar_a  <- earth_twinstar_a
kill @e[tag=kitpvp.earth_twinstar_a]
# kitpvp.earth_twinstar_b  <- earth_twinstar_b
kill @e[tag=kitpvp.earth_twinstar_b]
# kitpvp.earth_twinstar_guard_a  <- earth_twinstar_a
kill @e[tag=kitpvp.earth_twinstar_guard_a]
# kitpvp.earth_twinstar_guard_b  <- earth_twinstar_b
kill @e[tag=kitpvp.earth_twinstar_guard_b]
# kitpvp.earth_vagrant  <- earth_vagrant
kill @e[tag=kitpvp.earth_vagrant]
# kitpvp.earth_venus  <- earth_venus
kill @e[tag=kitpvp.earth_venus]
# kitpvp.earth_winner  <- earth_winner
kill @e[tag=kitpvp.earth_winner]
# kitpvp.ench_bench  <- apply_chest_blast_protection, apply_chest_fire_protection, apply_chest_projectile_protection, apply_chest_protection, apply_chest_thorns, apply_feet_blast_protection, apply_feet_depth_strider, apply_feet_feather_falling, apply_feet_fire_protection, apply_feet_frost_walker, apply_feet_projectile_protection, apply_feet_protection, apply_feet_soul_speed, apply_head_blast_protection, apply_head_fire_protection, apply_head_projectile_protection, apply_head_protection, apply_head_respiration, apply_legs_blast_protection, apply_legs_fire_protection, apply_legs_projectile_protection, apply_legs_protection, apply_legs_thorns, apply_sword_fire_aspect, apply_sword_knockback, apply_sword_sharpness, apply_sword_smite, apply_sword_sweeping, ench_force, ench_steps, ench_steps2
kill @e[tag=kitpvp.ench_bench]
# kitpvp.fisher_token  <- give_egg
kill @e[tag=kitpvp.fisher_token]
# kitpvp.gatherer_self  <- earth_gatherer
kill @e[tag=kitpvp.gatherer_self]
# kitpvp.ghost_minion  <- ghost_minion
kill @e[tag=kitpvp.ghost_minion]
# kitpvp.halley_token  <- give_egg
kill @e[tag=kitpvp.halley_token]
# kitpvp.hive_orb  <- hive_give
kill @e[tag=kitpvp.hive_orb]
# kitpvp.lf_anchor  <- earth_lowflyer
kill @e[tag=kitpvp.lf_anchor]
# kitpvp.lf_spawning  <- earth_lowflyer_a
kill @e[tag=kitpvp.lf_spawning]
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
# kitpvp.mo_aim  <- mortar_fire
kill @e[tag=kitpvp.mo_aim]
# kitpvp.mo_shell  <- mortar_fire
kill @e[tag=kitpvp.mo_shell]
# kitpvp.nb_dying  <- noteblock_death
kill @e[tag=kitpvp.nb_dying]
# kitpvp.phx_egg  <- phoenix_egg
kill @e[tag=kitpvp.phx_egg]
# kitpvp.pluto_parrot  <- pluto_parrot
kill @e[tag=kitpvp.pluto_parrot]
# kitpvp.sat_orbit  <- earth_saturn
kill @e[tag=kitpvp.sat_orbit]
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
# kitpvp.spoon_loot  <- spoon_hit
kill @e[tag=kitpvp.spoon_loot]
# kitpvp.sun_flare_token  <- give_flare
kill @e[tag=kitpvp.sun_flare_token]
# kitpvp.sun_spot_token  <- give_spot
kill @e[tag=kitpvp.sun_spot_token]
# kitpvp.sup_veil  <- earth_supporter_slow
kill @e[tag=kitpvp.sup_veil]
# kitpvp.sup_wait  <- earth_supporter_fast, earth_supporter_slow
kill @e[tag=kitpvp.sup_wait]
# kitpvp.sw_bench  <- sw_in_1, sw_in_10, sw_in_11, sw_in_12, sw_in_13, sw_in_14, sw_in_15, sw_in_16, sw_in_17, sw_in_18, sw_in_19, sw_in_2, sw_in_20, sw_in_21, sw_in_22, sw_in_23, sw_in_24, sw_in_25, sw_in_26, sw_in_27, sw_in_28, sw_in_29, sw_in_3, sw_in_30, sw_in_31, sw_in_32, sw_in_33, sw_in_34, sw_in_35, sw_in_36, sw_in_37, sw_in_4, sw_in_5, sw_in_6, sw_in_7, sw_in_8, sw_in_9
kill @e[tag=kitpvp.sw_bench]
# kitpvp.tainted_fisher_blue_token  <- give_blue
kill @e[tag=kitpvp.tainted_fisher_blue_token]
# kitpvp.tainted_fisher_domain_token  <- give_domain
kill @e[tag=kitpvp.tainted_fisher_domain_token]
# kitpvp.tamer_wolf  <- give_egg
kill @e[tag=kitpvp.tamer_wolf]
# kitpvp.ten_test  <- summon_ten
kill @e[tag=kitpvp.ten_test]
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
# kitpvp.trap_boom_mob  <- trigger_boom
kill @e[tag=kitpvp.trap_boom_mob]
# kitpvp.trap_worm  <- trap_worm, trigger_worm
kill @e[tag=kitpvp.trap_worm]
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
