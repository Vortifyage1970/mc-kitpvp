# 数据包目录结构（1.20.1）

> 本文件由每次改动后重新扫描 `src/` 生成，是**唯一的函数/文件清单权威**。
> 任何新增、改名的函数或数据文件，都必须重新扫描后更新本文件。
> 只写目录树，不写解释。找不到的文件 = 不存在，不要假设。
>
> ⚠ `skill/sun/noise/` 是**纯文案池**（128 个 .mcfunction，每份 = 4 行文本 + 1 行 playsound）。
> **不要读里面的内容**——它只为「随机刷屏」存在，读它纯粹浪费 token；要确认文件在不在，看本目录树就够。

## 目录树

```
D:\MC-KITPVP\SRC
│  pack.mcmeta
├─data
│   ├─kitpvp
│   │   ├─advancements
│   │   │   └─player
│   │   │       ├─archer_pickup.json
│   │   │       ├─campfire_touch.json
│   │   │       ├─captain_shield.json
│   │   │       ├─carto_hit.json
│   │   │       ├─chaos_hit.json
│   │   │       ├─coser_give.json
│   │   │       ├─ench_hit.json
│   │   │       ├─ench_hurt.json
│   │   │       ├─ghost_hurt.json
│   │   │       ├─ghost_soul_attack.json
│   │   │       ├─hive_struck.json
│   │   │       ├─lectern_teleport_1.json
│   │   │       ├─lectern_teleport_2.json
│   │   │       ├─lobby_launch.json
│   │   │       ├─mars_hit.json
│   │   │       ├─pirate_pickup.json
│   │   │       ├─spoon_hit.json
│   │   │       ├─sun_bow_pickup.json
│   │   │       ├─tainted_archer_hit_turret.json
│   │   │       ├─tainted_bow_pickup.json
│   │   │       ├─toronto_cart_1.json
│   │   │       ├─toronto_cart_10.json
│   │   │       ├─toronto_cart_11.json
│   │   │       ├─toronto_cart_2.json
│   │   │       ├─toronto_cart_3.json
│   │   │       ├─toronto_cart_4.json
│   │   │       ├─toronto_cart_5.json
│   │   │       ├─toronto_cart_6.json
│   │   │       ├─toronto_cart_7.json
│   │   │       ├─toronto_cart_8.json
│   │   │       ├─toronto_cart_9.json
│   │   │       ├─vagrant_spit.json
│   │   │       ├─werewolf_hit.json
│   │   │       ├─werewolf_kill.json
│   │   │       └─zhuzhiwu_hit.json
│   │   ├─functions
│   │   │   ├─debug
│   │   │   │   ├─babywhelp_probe.mcfunction
│   │   │   │   ├─babywhelp_test.mcfunction
│   │   │   │   ├─betaturn_check.mcfunction
│   │   │   │   ├─build.mcfunction
│   │   │   │   ├─carto_all.mcfunction
│   │   │   │   ├─dummy.mcfunction
│   │   │   │   ├─dummy_clear.mcfunction
│   │   │   │   ├─ench_5min.mcfunction
│   │   │   │   ├─ench_8min.mcfunction
│   │   │   │   ├─ench_armor.mcfunction
│   │   │   │   ├─ench_book.mcfunction
│   │   │   │   ├─ench_charge.mcfunction
│   │   │   │   ├─ench_charge_b.mcfunction
│   │   │   │   ├─ench_check.mcfunction
│   │   │   │   ├─ench_force.mcfunction
│   │   │   │   ├─ench_info.mcfunction
│   │   │   │   ├─ench_rebuild.mcfunction
│   │   │   │   ├─ench_state.mcfunction
│   │   │   │   ├─ench_steps.mcfunction
│   │   │   │   ├─ench_steps2.mcfunction
│   │   │   │   ├─ench_test.mcfunction
│   │   │   │   ├─force_reset.mcfunction
│   │   │   │   ├─janitor_count.mcfunction
│   │   │   │   ├─jar_test.mcfunction
│   │   │   │   ├─jar_test_b.mcfunction
│   │   │   │   ├─jar_test_c.mcfunction
│   │   │   │   ├─lf_state.mcfunction
│   │   │   │   ├─lowflyer_check.mcfunction
│   │   │   │   ├─manhole_check.mcfunction
│   │   │   │   ├─manhole_test.mcfunction
│   │   │   │   ├─music.mcfunction
│   │   │   │   ├─music_rumbling.mcfunction
│   │   │   │   ├─music_stop.mcfunction
│   │   │   │   ├─notch_mode.mcfunction
│   │   │   │   ├─off.mcfunction
│   │   │   │   ├─ollama_banner.mcfunction
│   │   │   │   ├─ollama_banner_all.mcfunction
│   │   │   │   ├─on.mcfunction
│   │   │   │   ├─phoenix_check.mcfunction
│   │   │   │   ├─phoenix_test.mcfunction
│   │   │   │   ├─play.mcfunction
│   │   │   │   ├─selfcheck.mcfunction
│   │   │   │   ├─solo_start.mcfunction
│   │   │   │   ├─status.mcfunction
│   │   │   │   ├─suicide.mcfunction
│   │   │   │   ├─summon_ten.mcfunction
│   │   │   │   ├─summon_ten_one.mcfunction
│   │   │   │   ├─tandem_check.mcfunction
│   │   │   │   └─version.mcfunction
│   │   │   ├─game
│   │   │   │   ├─check_winner.mcfunction
│   │   │   │   ├─end.mcfunction
│   │   │   │   ├─li_purge.mcfunction
│   │   │   │   ├─li_purge_verify.mcfunction
│   │   │   │   ├─reset.mcfunction
│   │   │   │   ├─reset_entities.mcfunction
│   │   │   │   ├─soul_tick.mcfunction
│   │   │   │   ├─start.mcfunction
│   │   │   │   ├─start_impl.mcfunction
│   │   │   │   ├─sudden_death_start.mcfunction
│   │   │   │   ├─sudden_drop.mcfunction
│   │   │   │   ├─timer_tick.mcfunction
│   │   │   │   └─wolf_sweep.mcfunction
│   │   │   ├─kit
│   │   │   │   ├─info
│   │   │   │   │   ├─alchemist.mcfunction
│   │   │   │   │   ├─archer.mcfunction
│   │   │   │   │   ├─arsonist.mcfunction
│   │   │   │   │   ├─assassin.mcfunction
│   │   │   │   │   ├─bomber.mcfunction
│   │   │   │   │   ├─burger.mcfunction
│   │   │   │   │   ├─chaos.mcfunction
│   │   │   │   │   ├─chaos_archer.mcfunction
│   │   │   │   │   ├─civil.mcfunction
│   │   │   │   │   ├─earth.mcfunction
│   │   │   │   │   ├─enchanter.mcfunction
│   │   │   │   │   ├─enderman.mcfunction
│   │   │   │   │   ├─farmer.mcfunction
│   │   │   │   │   ├─fisher.mcfunction
│   │   │   │   │   ├─ghost.mcfunction
│   │   │   │   │   ├─halley.mcfunction
│   │   │   │   │   ├─li_zhujunze.mcfunction
│   │   │   │   │   ├─mars.mcfunction
│   │   │   │   │   ├─mercury.mcfunction
│   │   │   │   │   ├─pirate.mcfunction
│   │   │   │   │   ├─pluto.mcfunction
│   │   │   │   │   ├─poisoner.mcfunction
│   │   │   │   │   ├─slime.mcfunction
│   │   │   │   │   ├─sun.mcfunction
│   │   │   │   │   ├─tainted_archer.mcfunction
│   │   │   │   │   ├─tainted_arsonist.mcfunction
│   │   │   │   │   ├─tainted_bomber.mcfunction
│   │   │   │   │   ├─tainted_enderman.mcfunction
│   │   │   │   │   ├─tainted_farmer.mcfunction
│   │   │   │   │   ├─tainted_fisher.mcfunction
│   │   │   │   │   ├─tainted_ghost.mcfunction
│   │   │   │   │   ├─tainted_slime.mcfunction
│   │   │   │   │   ├─tainted_tamer.mcfunction
│   │   │   │   │   ├─tainted_tank.mcfunction
│   │   │   │   │   ├─tainted_warrior.mcfunction
│   │   │   │   │   ├─tamer.mcfunction
│   │   │   │   │   ├─tank.mcfunction
│   │   │   │   │   ├─venus.mcfunction
│   │   │   │   │   ├─warrior.mcfunction
│   │   │   │   │   ├─werewolf.mcfunction
│   │   │   │   │   ├─zhanshishi.mcfunction
│   │   │   │   │   ├─zhuzhiwu.mcfunction
│   │   │   │   │   └─zombie.mcfunction
│   │   │   │   ├─list
│   │   │   │   │   ├─astral.mcfunction
│   │   │   │   │   ├─classic.mcfunction
│   │   │   │   │   ├─classic_chaos.mcfunction
│   │   │   │   │   ├─classic_tainted.mcfunction
│   │   │   │   │   ├─history.mcfunction
│   │   │   │   │   ├─meme.mcfunction
│   │   │   │   │   └─operator.mcfunction
│   │   │   │   ├─alchemist.mcfunction
│   │   │   │   ├─archer.mcfunction
│   │   │   │   ├─arsonist.mcfunction
│   │   │   │   ├─assassin.mcfunction
│   │   │   │   ├─bomber.mcfunction
│   │   │   │   ├─burger.mcfunction
│   │   │   │   ├─chaos.mcfunction
│   │   │   │   ├─chaos_archer.mcfunction
│   │   │   │   ├─chaos_arrow_check.mcfunction
│   │   │   │   ├─chaos_arrow_spent.mcfunction
│   │   │   │   ├─chaos_break.mcfunction
│   │   │   │   ├─chaos_farm.mcfunction
│   │   │   │   ├─chaos_give_1.mcfunction
│   │   │   │   ├─chaos_give_10.mcfunction
│   │   │   │   ├─chaos_give_11.mcfunction
│   │   │   │   ├─chaos_give_12.mcfunction
│   │   │   │   ├─chaos_give_13.mcfunction
│   │   │   │   ├─chaos_give_14.mcfunction
│   │   │   │   ├─chaos_give_15.mcfunction
│   │   │   │   ├─chaos_give_16.mcfunction
│   │   │   │   ├─chaos_give_17.mcfunction
│   │   │   │   ├─chaos_give_18.mcfunction
│   │   │   │   ├─chaos_give_19.mcfunction
│   │   │   │   ├─chaos_give_2.mcfunction
│   │   │   │   ├─chaos_give_20.mcfunction
│   │   │   │   ├─chaos_give_21.mcfunction
│   │   │   │   ├─chaos_give_3.mcfunction
│   │   │   │   ├─chaos_give_4.mcfunction
│   │   │   │   ├─chaos_give_5.mcfunction
│   │   │   │   ├─chaos_give_6.mcfunction
│   │   │   │   ├─chaos_give_7.mcfunction
│   │   │   │   ├─chaos_give_8.mcfunction
│   │   │   │   ├─chaos_give_9.mcfunction
│   │   │   │   ├─chaos_hit.mcfunction
│   │   │   │   ├─chaos_next.mcfunction
│   │   │   │   ├─chaos_shot_bow.mcfunction
│   │   │   │   ├─chaos_shot_tri.mcfunction
│   │   │   │   ├─chaos_shot_xbow.mcfunction
│   │   │   │   ├─chaos_skill.mcfunction
│   │   │   │   ├─chaos_skill_do.mcfunction
│   │   │   │   ├─chaos_start.mcfunction
│   │   │   │   ├─chaos_tri_settle.mcfunction
│   │   │   │   ├─chaos_use.mcfunction
│   │   │   │   ├─chaos_wipe.mcfunction
│   │   │   │   ├─chaos_xbow_check.mcfunction
│   │   │   │   ├─chaos_xbow_fired.mcfunction
│   │   │   │   ├─civil.mcfunction
│   │   │   │   ├─earth.mcfunction
│   │   │   │   ├─enchanter.mcfunction
│   │   │   │   ├─enderman.mcfunction
│   │   │   │   ├─farmer.mcfunction
│   │   │   │   ├─fisher.mcfunction
│   │   │   │   ├─ghost.mcfunction
│   │   │   │   ├─halley.mcfunction
│   │   │   │   ├─li_zhujunze.mcfunction
│   │   │   │   ├─list.mcfunction
│   │   │   │   ├─mars.mcfunction
│   │   │   │   ├─mercury.mcfunction
│   │   │   │   ├─pirate.mcfunction
│   │   │   │   ├─pluto.mcfunction
│   │   │   │   ├─poisoner.mcfunction
│   │   │   │   ├─random.mcfunction
│   │   │   │   ├─random_astral.mcfunction
│   │   │   │   ├─random_classic.mcfunction
│   │   │   │   ├─random_tainted.mcfunction
│   │   │   │   ├─slime.mcfunction
│   │   │   │   ├─sun.mcfunction
│   │   │   │   ├─tainted_archer.mcfunction
│   │   │   │   ├─tainted_arsonist.mcfunction
│   │   │   │   ├─tainted_bomber.mcfunction
│   │   │   │   ├─tainted_enderman.mcfunction
│   │   │   │   ├─tainted_farmer.mcfunction
│   │   │   │   ├─tainted_fisher.mcfunction
│   │   │   │   ├─tainted_ghost.mcfunction
│   │   │   │   ├─tainted_slime.mcfunction
│   │   │   │   ├─tainted_tamer.mcfunction
│   │   │   │   ├─tainted_tank.mcfunction
│   │   │   │   ├─tainted_warrior.mcfunction
│   │   │   │   ├─tamer.mcfunction
│   │   │   │   ├─tank.mcfunction
│   │   │   │   ├─venus.mcfunction
│   │   │   │   ├─warrior.mcfunction
│   │   │   │   ├─werewolf.mcfunction
│   │   │   │   ├─zhanshishi.mcfunction
│   │   │   │   ├─zhuzhiwu.mcfunction
│   │   │   │   └─zombie.mcfunction
│   │   │   ├─lobby
│   │   │   │   ├─build.mcfunction
│   │   │   │   ├─build_pads.mcfunction
│   │   │   │   ├─build_stands.mcfunction
│   │   │   │   ├─display_lock.mcfunction
│   │   │   │   ├─enter.mcfunction
│   │   │   │   ├─exit.mcfunction
│   │   │   │   ├─give_items.mcfunction
│   │   │   │   ├─launch.mcfunction
│   │   │   │   ├─lectern_teleport_1.mcfunction
│   │   │   │   ├─lectern_teleport_2.mcfunction
│   │   │   │   ├─menu.mcfunction
│   │   │   │   ├─pad.mcfunction
│   │   │   │   ├─pad_enter.mcfunction
│   │   │   │   ├─ready_check.mcfunction
│   │   │   │   ├─ready_off.mcfunction
│   │   │   │   ├─ready_on.mcfunction
│   │   │   │   ├─ready_toggle.mcfunction
│   │   │   │   ├─reset_self.mcfunction
│   │   │   │   ├─spawn.mcfunction
│   │   │   │   ├─teleport.mcfunction
│   │   │   │   ├─tp_to_kit.mcfunction
│   │   │   │   └─tp_to_main.mcfunction
│   │   │   ├─map
│   │   │   │   ├─arena
│   │   │   │   │   ├─distribute.mcfunction
│   │   │   │   │   ├─pass.mcfunction
│   │   │   │   │   ├─restore.mcfunction
│   │   │   │   │   ├─spawn_1.mcfunction
│   │   │   │   │   ├─spawn_2.mcfunction
│   │   │   │   │   ├─spawn_3.mcfunction
│   │   │   │   │   ├─spawn_4.mcfunction
│   │   │   │   │   ├─spawn_5.mcfunction
│   │   │   │   │   ├─spawn_6.mcfunction
│   │   │   │   │   ├─spawn_7.mcfunction
│   │   │   │   │   ├─spawn_8.mcfunction
│   │   │   │   │   └─spawn_9.mcfunction
│   │   │   │   ├─cobblestone
│   │   │   │   │   ├─distribute.mcfunction
│   │   │   │   │   ├─pass.mcfunction
│   │   │   │   │   ├─restore.mcfunction
│   │   │   │   │   ├─spawn_1.mcfunction
│   │   │   │   │   ├─spawn_2.mcfunction
│   │   │   │   │   ├─spawn_3.mcfunction
│   │   │   │   │   ├─spawn_4.mcfunction
│   │   │   │   │   ├─spawn_5.mcfunction
│   │   │   │   │   ├─spawn_6.mcfunction
│   │   │   │   │   └─spawn_7.mcfunction
│   │   │   │   ├─desert
│   │   │   │   │   ├─decor.mcfunction
│   │   │   │   │   ├─distribute.mcfunction
│   │   │   │   │   ├─pass.mcfunction
│   │   │   │   │   ├─restore.mcfunction
│   │   │   │   │   ├─spawn_1.mcfunction
│   │   │   │   │   ├─spawn_2.mcfunction
│   │   │   │   │   ├─spawn_3.mcfunction
│   │   │   │   │   ├─spawn_4.mcfunction
│   │   │   │   │   ├─spawn_5.mcfunction
│   │   │   │   │   ├─spawn_6.mcfunction
│   │   │   │   │   ├─spawn_7.mcfunction
│   │   │   │   │   ├─spawn_8.mcfunction
│   │   │   │   │   └─spawn_9.mcfunction
│   │   │   │   ├─earth
│   │   │   │   │   ├─distribute.mcfunction
│   │   │   │   │   ├─pass.mcfunction
│   │   │   │   │   ├─restore.mcfunction
│   │   │   │   │   ├─spawn_1.mcfunction
│   │   │   │   │   ├─spawn_2.mcfunction
│   │   │   │   │   ├─spawn_3.mcfunction
│   │   │   │   │   ├─spawn_4.mcfunction
│   │   │   │   │   ├─spawn_5.mcfunction
│   │   │   │   │   ├─spawn_6.mcfunction
│   │   │   │   │   ├─spawn_7.mcfunction
│   │   │   │   │   ├─spawn_8.mcfunction
│   │   │   │   │   └─spawn_9.mcfunction
│   │   │   │   ├─mansion
│   │   │   │   │   ├─decor.mcfunction
│   │   │   │   │   ├─distribute.mcfunction
│   │   │   │   │   ├─pass.mcfunction
│   │   │   │   │   ├─restore.mcfunction
│   │   │   │   │   ├─spawn_1.mcfunction
│   │   │   │   │   ├─spawn_2.mcfunction
│   │   │   │   │   ├─spawn_3.mcfunction
│   │   │   │   │   ├─spawn_4.mcfunction
│   │   │   │   │   ├─spawn_5.mcfunction
│   │   │   │   │   ├─spawn_6.mcfunction
│   │   │   │   │   ├─spawn_7.mcfunction
│   │   │   │   │   ├─spawn_8.mcfunction
│   │   │   │   │   └─spawn_9.mcfunction
│   │   │   │   ├─ocean
│   │   │   │   │   ├─distribute.mcfunction
│   │   │   │   │   ├─pass.mcfunction
│   │   │   │   │   ├─restore.mcfunction
│   │   │   │   │   ├─spawn_1.mcfunction
│   │   │   │   │   ├─spawn_2.mcfunction
│   │   │   │   │   ├─spawn_3.mcfunction
│   │   │   │   │   ├─spawn_4.mcfunction
│   │   │   │   │   ├─spawn_5.mcfunction
│   │   │   │   │   ├─spawn_6.mcfunction
│   │   │   │   │   ├─spawn_7.mcfunction
│   │   │   │   │   └─spawn_8.mcfunction
│   │   │   │   ├─snow
│   │   │   │   │   ├─distribute.mcfunction
│   │   │   │   │   ├─pass.mcfunction
│   │   │   │   │   ├─restore.mcfunction
│   │   │   │   │   ├─spawn_1.mcfunction
│   │   │   │   │   ├─spawn_2.mcfunction
│   │   │   │   │   ├─spawn_3.mcfunction
│   │   │   │   │   ├─spawn_4.mcfunction
│   │   │   │   │   ├─spawn_5.mcfunction
│   │   │   │   │   └─spawn_6.mcfunction
│   │   │   │   ├─toronto
│   │   │   │   │   ├─cart_1.mcfunction
│   │   │   │   │   ├─cart_10.mcfunction
│   │   │   │   │   ├─cart_11.mcfunction
│   │   │   │   │   ├─cart_2.mcfunction
│   │   │   │   │   ├─cart_3.mcfunction
│   │   │   │   │   ├─cart_4.mcfunction
│   │   │   │   │   ├─cart_5.mcfunction
│   │   │   │   │   ├─cart_6.mcfunction
│   │   │   │   │   ├─cart_7.mcfunction
│   │   │   │   │   ├─cart_8.mcfunction
│   │   │   │   │   ├─cart_9.mcfunction
│   │   │   │   │   ├─distribute.mcfunction
│   │   │   │   │   ├─pass.mcfunction
│   │   │   │   │   ├─restore.mcfunction
│   │   │   │   │   ├─spawn_1.mcfunction
│   │   │   │   │   ├─spawn_2.mcfunction
│   │   │   │   │   ├─spawn_3.mcfunction
│   │   │   │   │   ├─spawn_4.mcfunction
│   │   │   │   │   ├─spawn_5.mcfunction
│   │   │   │   │   ├─spawn_6.mcfunction
│   │   │   │   │   ├─spawn_7.mcfunction
│   │   │   │   │   ├─spawn_8.mcfunction
│   │   │   │   │   └─spawn_9.mcfunction
│   │   │   │   ├─xian
│   │   │   │   │   ├─distribute.mcfunction
│   │   │   │   │   ├─pass.mcfunction
│   │   │   │   │   ├─restore.mcfunction
│   │   │   │   │   ├─spawn_1.mcfunction
│   │   │   │   │   ├─spawn_2.mcfunction
│   │   │   │   │   ├─spawn_3.mcfunction
│   │   │   │   │   ├─spawn_4.mcfunction
│   │   │   │   │   ├─spawn_5.mcfunction
│   │   │   │   │   └─spawn_6.mcfunction
│   │   │   │   ├─distribute.mcfunction
│   │   │   │   ├─random.mcfunction
│   │   │   │   ├─restore.mcfunction
│   │   │   │   ├─select_arena.mcfunction
│   │   │   │   ├─select_cobblestone.mcfunction
│   │   │   │   ├─select_desert.mcfunction
│   │   │   │   ├─select_earth.mcfunction
│   │   │   │   ├─select_mansion.mcfunction
│   │   │   │   ├─select_menu.mcfunction
│   │   │   │   ├─select_ocean.mcfunction
│   │   │   │   ├─select_snow.mcfunction
│   │   │   │   ├─select_toronto.mcfunction
│   │   │   │   └─select_xian.mcfunction
│   │   │   ├─music
│   │   │   │   ├─winning
│   │   │   │   │   ├─notes
│   │   │   │   │   │   ├─0.mcfunction
│   │   │   │   │   │   ├─10.mcfunction
│   │   │   │   │   │   ├─102.mcfunction
│   │   │   │   │   │   ├─104.mcfunction
│   │   │   │   │   │   ├─128.mcfunction
│   │   │   │   │   │   ├─14.mcfunction
│   │   │   │   │   │   ├─16.mcfunction
│   │   │   │   │   │   ├─20.mcfunction
│   │   │   │   │   │   ├─24.mcfunction
│   │   │   │   │   │   ├─32.mcfunction
│   │   │   │   │   │   ├─37.mcfunction
│   │   │   │   │   │   ├─4.mcfunction
│   │   │   │   │   │   ├─42.mcfunction
│   │   │   │   │   │   ├─48.mcfunction
│   │   │   │   │   │   ├─53.mcfunction
│   │   │   │   │   │   ├─58.mcfunction
│   │   │   │   │   │   ├─64.mcfunction
│   │   │   │   │   │   ├─70.mcfunction
│   │   │   │   │   │   ├─72.mcfunction
│   │   │   │   │   │   ├─78.mcfunction
│   │   │   │   │   │   ├─80.mcfunction
│   │   │   │   │   │   ├─86.mcfunction
│   │   │   │   │   │   ├─88.mcfunction
│   │   │   │   │   │   ├─94.mcfunction
│   │   │   │   │   │   └─96.mcfunction
│   │   │   │   │   ├─tree
│   │   │   │   │   │   ├─0_1.mcfunction
│   │   │   │   │   │   ├─0_127.mcfunction
│   │   │   │   │   │   ├─0_15.mcfunction
│   │   │   │   │   │   ├─0_255.mcfunction
│   │   │   │   │   │   ├─0_3.mcfunction
│   │   │   │   │   │   ├─0_31.mcfunction
│   │   │   │   │   │   ├─0_63.mcfunction
│   │   │   │   │   │   ├─0_7.mcfunction
│   │   │   │   │   │   ├─100_103.mcfunction
│   │   │   │   │   │   ├─102_103.mcfunction
│   │   │   │   │   │   ├─104_105.mcfunction
│   │   │   │   │   │   ├─104_107.mcfunction
│   │   │   │   │   │   ├─104_111.mcfunction
│   │   │   │   │   │   ├─10_11.mcfunction
│   │   │   │   │   │   ├─128_129.mcfunction
│   │   │   │   │   │   ├─128_131.mcfunction
│   │   │   │   │   │   ├─128_135.mcfunction
│   │   │   │   │   │   ├─128_143.mcfunction
│   │   │   │   │   │   ├─128_159.mcfunction
│   │   │   │   │   │   ├─128_191.mcfunction
│   │   │   │   │   │   ├─128_255.mcfunction
│   │   │   │   │   │   ├─12_15.mcfunction
│   │   │   │   │   │   ├─14_15.mcfunction
│   │   │   │   │   │   ├─16_17.mcfunction
│   │   │   │   │   │   ├─16_19.mcfunction
│   │   │   │   │   │   ├─16_23.mcfunction
│   │   │   │   │   │   ├─16_31.mcfunction
│   │   │   │   │   │   ├─20_21.mcfunction
│   │   │   │   │   │   ├─20_23.mcfunction
│   │   │   │   │   │   ├─24_25.mcfunction
│   │   │   │   │   │   ├─24_27.mcfunction
│   │   │   │   │   │   ├─24_31.mcfunction
│   │   │   │   │   │   ├─32_33.mcfunction
│   │   │   │   │   │   ├─32_35.mcfunction
│   │   │   │   │   │   ├─32_39.mcfunction
│   │   │   │   │   │   ├─32_47.mcfunction
│   │   │   │   │   │   ├─32_63.mcfunction
│   │   │   │   │   │   ├─36_37.mcfunction
│   │   │   │   │   │   ├─36_39.mcfunction
│   │   │   │   │   │   ├─40_43.mcfunction
│   │   │   │   │   │   ├─40_47.mcfunction
│   │   │   │   │   │   ├─42_43.mcfunction
│   │   │   │   │   │   ├─48_49.mcfunction
│   │   │   │   │   │   ├─48_51.mcfunction
│   │   │   │   │   │   ├─48_55.mcfunction
│   │   │   │   │   │   ├─48_63.mcfunction
│   │   │   │   │   │   ├─4_5.mcfunction
│   │   │   │   │   │   ├─4_7.mcfunction
│   │   │   │   │   │   ├─52_53.mcfunction
│   │   │   │   │   │   ├─52_55.mcfunction
│   │   │   │   │   │   ├─56_59.mcfunction
│   │   │   │   │   │   ├─56_63.mcfunction
│   │   │   │   │   │   ├─58_59.mcfunction
│   │   │   │   │   │   ├─64_127.mcfunction
│   │   │   │   │   │   ├─64_65.mcfunction
│   │   │   │   │   │   ├─64_67.mcfunction
│   │   │   │   │   │   ├─64_71.mcfunction
│   │   │   │   │   │   ├─64_79.mcfunction
│   │   │   │   │   │   ├─64_95.mcfunction
│   │   │   │   │   │   ├─68_71.mcfunction
│   │   │   │   │   │   ├─70_71.mcfunction
│   │   │   │   │   │   ├─72_73.mcfunction
│   │   │   │   │   │   ├─72_75.mcfunction
│   │   │   │   │   │   ├─72_79.mcfunction
│   │   │   │   │   │   ├─76_79.mcfunction
│   │   │   │   │   │   ├─78_79.mcfunction
│   │   │   │   │   │   ├─80_81.mcfunction
│   │   │   │   │   │   ├─80_83.mcfunction
│   │   │   │   │   │   ├─80_87.mcfunction
│   │   │   │   │   │   ├─80_95.mcfunction
│   │   │   │   │   │   ├─84_87.mcfunction
│   │   │   │   │   │   ├─86_87.mcfunction
│   │   │   │   │   │   ├─88_89.mcfunction
│   │   │   │   │   │   ├─88_91.mcfunction
│   │   │   │   │   │   ├─88_95.mcfunction
│   │   │   │   │   │   ├─8_11.mcfunction
│   │   │   │   │   │   ├─8_15.mcfunction
│   │   │   │   │   │   ├─92_95.mcfunction
│   │   │   │   │   │   ├─94_95.mcfunction
│   │   │   │   │   │   ├─96_103.mcfunction
│   │   │   │   │   │   ├─96_111.mcfunction
│   │   │   │   │   │   ├─96_127.mcfunction
│   │   │   │   │   │   ├─96_97.mcfunction
│   │   │   │   │   │   └─96_99.mcfunction
│   │   │   │   │   ├─load.mcfunction
│   │   │   │   │   ├─pause.mcfunction
│   │   │   │   │   ├─play.mcfunction
│   │   │   │   │   ├─stop.mcfunction
│   │   │   │   │   ├─tick.mcfunction
│   │   │   │   │   └─uninstall.mcfunction
│   │   │   │   └─yu_ai
│   │   │   │       ├─ev_0000.mcfunction
│   │   │   │       ├─ev_0001.mcfunction
│   │   │   │       ├─ev_0002.mcfunction
│   │   │   │       ├─ev_0003.mcfunction
│   │   │   │       ├─ev_0004.mcfunction
│   │   │   │       ├─ev_0005.mcfunction
│   │   │   │       ├─ev_0006.mcfunction
│   │   │   │       ├─ev_0007.mcfunction
│   │   │   │       ├─ev_0008.mcfunction
│   │   │   │       ├─ev_0009.mcfunction
│   │   │   │       ├─ev_0010.mcfunction
│   │   │   │       ├─ev_0011.mcfunction
│   │   │   │       ├─ev_0012.mcfunction
│   │   │   │       ├─ev_0013.mcfunction
│   │   │   │       ├─ev_0014.mcfunction
│   │   │   │       ├─ev_0015.mcfunction
│   │   │   │       ├─ev_0016.mcfunction
│   │   │   │       ├─ev_0017.mcfunction
│   │   │   │       ├─ev_0018.mcfunction
│   │   │   │       ├─ev_0019.mcfunction
│   │   │   │       ├─ev_0020.mcfunction
│   │   │   │       ├─ev_0021.mcfunction
│   │   │   │       ├─ev_0022.mcfunction
│   │   │   │       ├─ev_0023.mcfunction
│   │   │   │       ├─ev_0024.mcfunction
│   │   │   │       ├─ev_0025.mcfunction
│   │   │   │       ├─ev_0026.mcfunction
│   │   │   │       ├─ev_0027.mcfunction
│   │   │   │       ├─ev_0028.mcfunction
│   │   │   │       ├─ev_0029.mcfunction
│   │   │   │       ├─ev_0030.mcfunction
│   │   │   │       ├─ev_0031.mcfunction
│   │   │   │       ├─ev_0032.mcfunction
│   │   │   │       ├─ev_0033.mcfunction
│   │   │   │       ├─ev_0034.mcfunction
│   │   │   │       ├─ev_0035.mcfunction
│   │   │   │       ├─ev_0036.mcfunction
│   │   │   │       ├─ev_0037.mcfunction
│   │   │   │       ├─ev_0038.mcfunction
│   │   │   │       ├─ev_0039.mcfunction
│   │   │   │       ├─ev_0040.mcfunction
│   │   │   │       ├─ev_0041.mcfunction
│   │   │   │       ├─ev_0042.mcfunction
│   │   │   │       ├─ev_0043.mcfunction
│   │   │   │       ├─ev_0044.mcfunction
│   │   │   │       ├─ev_0045.mcfunction
│   │   │   │       ├─ev_0046.mcfunction
│   │   │   │       ├─ev_0047.mcfunction
│   │   │   │       ├─ev_0048.mcfunction
│   │   │   │       ├─ev_0049.mcfunction
│   │   │   │       ├─ev_0050.mcfunction
│   │   │   │       ├─ev_0051.mcfunction
│   │   │   │       ├─ev_0052.mcfunction
│   │   │   │       ├─ev_0053.mcfunction
│   │   │   │       ├─ev_0054.mcfunction
│   │   │   │       ├─ev_0055.mcfunction
│   │   │   │       ├─ev_0056.mcfunction
│   │   │   │       ├─ev_0057.mcfunction
│   │   │   │       ├─ev_0058.mcfunction
│   │   │   │       ├─ev_0059.mcfunction
│   │   │   │       ├─ev_0060.mcfunction
│   │   │   │       ├─ev_0061.mcfunction
│   │   │   │       ├─ev_0062.mcfunction
│   │   │   │       ├─ev_0063.mcfunction
│   │   │   │       ├─ev_0064.mcfunction
│   │   │   │       ├─ev_0065.mcfunction
│   │   │   │       ├─ev_0066.mcfunction
│   │   │   │       ├─ev_0067.mcfunction
│   │   │   │       ├─ev_0068.mcfunction
│   │   │   │       ├─ev_0069.mcfunction
│   │   │   │       ├─ev_0070.mcfunction
│   │   │   │       ├─ev_0071.mcfunction
│   │   │   │       ├─ev_0072.mcfunction
│   │   │   │       ├─ev_0073.mcfunction
│   │   │   │       ├─ev_0074.mcfunction
│   │   │   │       ├─ev_0075.mcfunction
│   │   │   │       ├─ev_0076.mcfunction
│   │   │   │       ├─ev_0077.mcfunction
│   │   │   │       ├─ev_0078.mcfunction
│   │   │   │       ├─ev_0079.mcfunction
│   │   │   │       ├─ev_0080.mcfunction
│   │   │   │       ├─ev_0081.mcfunction
│   │   │   │       ├─ev_0082.mcfunction
│   │   │   │       ├─ev_0083.mcfunction
│   │   │   │       ├─ev_0084.mcfunction
│   │   │   │       ├─ev_0085.mcfunction
│   │   │   │       ├─ev_0086.mcfunction
│   │   │   │       ├─ev_0087.mcfunction
│   │   │   │       ├─ev_0088.mcfunction
│   │   │   │       ├─ev_0089.mcfunction
│   │   │   │       ├─ev_0090.mcfunction
│   │   │   │       ├─ev_0091.mcfunction
│   │   │   │       ├─ev_0092.mcfunction
│   │   │   │       ├─ev_0093.mcfunction
│   │   │   │       ├─ev_0094.mcfunction
│   │   │   │       ├─ev_0095.mcfunction
│   │   │   │       ├─ev_0096.mcfunction
│   │   │   │       ├─ev_0097.mcfunction
│   │   │   │       ├─ev_0098.mcfunction
│   │   │   │       ├─ev_0099.mcfunction
│   │   │   │       ├─ev_0100.mcfunction
│   │   │   │       ├─ev_0101.mcfunction
│   │   │   │       ├─ev_0102.mcfunction
│   │   │   │       ├─ev_0103.mcfunction
│   │   │   │       ├─ev_0104.mcfunction
│   │   │   │       ├─ev_0105.mcfunction
│   │   │   │       ├─ev_0106.mcfunction
│   │   │   │       ├─ev_0107.mcfunction
│   │   │   │       ├─ev_0108.mcfunction
│   │   │   │       ├─ev_0109.mcfunction
│   │   │   │       ├─ev_0110.mcfunction
│   │   │   │       ├─ev_0111.mcfunction
│   │   │   │       ├─ev_0112.mcfunction
│   │   │   │       ├─ev_0113.mcfunction
│   │   │   │       ├─start.mcfunction
│   │   │   │       └─stop.mcfunction
│   │   │   ├─player
│   │   │   │   ├─after_death.mcfunction
│   │   │   │   ├─death_dispatch.mcfunction
│   │   │   │   ├─eliminate.mcfunction
│   │   │   │   ├─end_invincible.mcfunction
│   │   │   │   ├─invincible.mcfunction
│   │   │   │   ├─join.mcfunction
│   │   │   │   ├─on_death.mcfunction
│   │   │   │   └─spawn_anchor.mcfunction
│   │   │   ├─skill
│   │   │   │   ├─alchemist
│   │   │   │   │   ├─cast.mcfunction
│   │   │   │   │   ├─clear_elixir.mcfunction
│   │   │   │   │   ├─clear_splash.mcfunction
│   │   │   │   │   ├─elixir_cast.mcfunction
│   │   │   │   │   ├─elixir_deny.mcfunction
│   │   │   │   │   ├─elixir_fire.mcfunction
│   │   │   │   │   ├─elixir_fire_res.mcfunction
│   │   │   │   │   ├─elixir_slow_fall.mcfunction
│   │   │   │   │   ├─elixir_strength.mcfunction
│   │   │   │   │   ├─elixir_turtle.mcfunction
│   │   │   │   │   ├─fire.mcfunction
│   │   │   │   │   ├─fire_invis.mcfunction
│   │   │   │   │   ├─fire_jump.mcfunction
│   │   │   │   │   ├─fire_regen.mcfunction
│   │   │   │   │   ├─fire_speed.mcfunction
│   │   │   │   │   ├─give_elixir.mcfunction
│   │   │   │   │   ├─give_elixir_fire_res.mcfunction
│   │   │   │   │   ├─give_elixir_slow_fall.mcfunction
│   │   │   │   │   ├─give_elixir_strength.mcfunction
│   │   │   │   │   ├─give_elixir_turtle.mcfunction
│   │   │   │   │   ├─give_invis.mcfunction
│   │   │   │   │   ├─give_jump.mcfunction
│   │   │   │   │   ├─give_regen.mcfunction
│   │   │   │   │   ├─give_speed.mcfunction
│   │   │   │   │   ├─give_splash.mcfunction
│   │   │   │   │   ├─refill_full.mcfunction
│   │   │   │   │   ├─refill_splash.mcfunction
│   │   │   │   │   └─restock_elixir.mcfunction
│   │   │   │   ├─archer
│   │   │   │   │   ├─give_bow.mcfunction
│   │   │   │   │   ├─pickup.mcfunction
│   │   │   │   │   ├─refill.mcfunction
│   │   │   │   │   ├─return.mcfunction
│   │   │   │   │   └─steal.mcfunction
│   │   │   │   ├─arsonist
│   │   │   │   │   ├─auto.mcfunction
│   │   │   │   │   ├─burst.mcfunction
│   │   │   │   │   ├─cast.mcfunction
│   │   │   │   │   ├─fire.mcfunction
│   │   │   │   │   ├─flame_tick.mcfunction
│   │   │   │   │   ├─give.mcfunction
│   │   │   │   │   ├─place.mcfunction
│   │   │   │   │   └─place_one.mcfunction
│   │   │   │   ├─assassin
│   │   │   │   │   ├─cast.mcfunction
│   │   │   │   │   ├─dispatch.mcfunction
│   │   │   │   │   ├─fire.mcfunction
│   │   │   │   │   ├─give_item.mcfunction
│   │   │   │   │   ├─handout.mcfunction
│   │   │   │   │   ├─passive.mcfunction
│   │   │   │   │   └─unhide.mcfunction
│   │   │   │   ├─bomber
│   │   │   │   │   ├─big_cast.mcfunction
│   │   │   │   │   ├─dispatch.mcfunction
│   │   │   │   │   ├─fake_cast.mcfunction
│   │   │   │   │   ├─give_big.mcfunction
│   │   │   │   │   ├─give_fake.mcfunction
│   │   │   │   │   ├─give_nuke.mcfunction
│   │   │   │   │   ├─give_small.mcfunction
│   │   │   │   │   ├─give_track.mcfunction
│   │   │   │   │   ├─nuke_cast.mcfunction
│   │   │   │   │   ├─refill.mcfunction
│   │   │   │   │   ├─refill_big.mcfunction
│   │   │   │   │   ├─refill_fake.mcfunction
│   │   │   │   │   ├─refill_small.mcfunction
│   │   │   │   │   ├─refill_track.mcfunction
│   │   │   │   │   ├─small_cast.mcfunction
│   │   │   │   │   └─track_cast.mcfunction
│   │   │   │   ├─burger
│   │   │   │   │   ├─announce.mcfunction
│   │   │   │   │   ├─assign_slot.mcfunction
│   │   │   │   │   ├─charge.mcfunction
│   │   │   │   │   └─summon.mcfunction
│   │   │   │   ├─chaos_archer
│   │   │   │   │   ├─arrow.mcfunction
│   │   │   │   │   └─cast.mcfunction
│   │   │   │   ├─civil
│   │   │   │   │   ├─auto.mcfunction
│   │   │   │   │   ├─cast.mcfunction
│   │   │   │   │   ├─demon_cast.mcfunction
│   │   │   │   │   ├─demon_end.mcfunction
│   │   │   │   │   ├─demon_spit_burst.mcfunction
│   │   │   │   │   ├─demon_start.mcfunction
│   │   │   │   │   ├─give_demon_spit.mcfunction
│   │   │   │   │   ├─give_demon_token.mcfunction
│   │   │   │   │   ├─give_spit.mcfunction
│   │   │   │   │   ├─refill_demon.mcfunction
│   │   │   │   │   └─spit_burst.mcfunction
│   │   │   │   ├─earth
│   │   │   │   │   ├─auto.mcfunction
│   │   │   │   │   ├─babywhelp_ball.mcfunction
│   │   │   │   │   ├─babywhelp_fire.mcfunction
│   │   │   │   │   ├─babywhelp_fizzle.mcfunction
│   │   │   │   │   ├─babywhelp_hit.mcfunction
│   │   │   │   │   ├─babywhelp_shoot.mcfunction
│   │   │   │   │   ├─babywhelp_tick.mcfunction
│   │   │   │   │   ├─brewer_break.mcfunction
│   │   │   │   │   ├─brewer_drop.mcfunction
│   │   │   │   │   ├─burn_tick.mcfunction
│   │   │   │   │   ├─campfire_ignite.mcfunction
│   │   │   │   │   ├─campfire_out.mcfunction
│   │   │   │   │   ├─campfire_touch.mcfunction
│   │   │   │   │   ├─capitalist_death.mcfunction
│   │   │   │   │   ├─capitalist_drop.mcfunction
│   │   │   │   │   ├─captain_blocked.mcfunction
│   │   │   │   │   ├─captain_tick.mcfunction
│   │   │   │   │   ├─carto_line.mcfunction
│   │   │   │   │   ├─carto_try.mcfunction
│   │   │   │   │   ├─cast.mcfunction
│   │   │   │   │   ├─colorchanger_shift.mcfunction
│   │   │   │   │   ├─cop_blink_jaunt.mcfunction
│   │   │   │   │   ├─cop_blink_track.mcfunction
│   │   │   │   │   ├─coser_meow.mcfunction
│   │   │   │   │   ├─coser_paper.mcfunction
│   │   │   │   │   ├─coser_try.mcfunction
│   │   │   │   │   ├─disrupt.mcfunction
│   │   │   │   │   ├─dominion_firework.mcfunction
│   │   │   │   │   ├─dominion_smoke.mcfunction
│   │   │   │   │   ├─dublinn_strike.mcfunction
│   │   │   │   │   ├─explainer_leave.mcfunction
│   │   │   │   │   ├─gearbox_aura.mcfunction
│   │   │   │   │   ├─give_egg.mcfunction
│   │   │   │   │   ├─grass_probe.mcfunction
│   │   │   │   │   ├─hive_give.mcfunction
│   │   │   │   │   ├─hive_struck.mcfunction
│   │   │   │   │   ├─hydrator_death.mcfunction
│   │   │   │   │   ├─janitor_sweep.mcfunction
│   │   │   │   │   ├─jar_pop.mcfunction
│   │   │   │   │   ├─junk_serial.mcfunction
│   │   │   │   │   ├─jupiter_death.mcfunction
│   │   │   │   │   ├─leaker_report.mcfunction
│   │   │   │   │   ├─leaker_tick.mcfunction
│   │   │   │   │   ├─levitate_end.mcfunction
│   │   │   │   │   ├─levitate_start.mcfunction
│   │   │   │   │   ├─link.mcfunction
│   │   │   │   │   ├─lowflyer_tick.mcfunction
│   │   │   │   │   ├─manhole_pop.mcfunction
│   │   │   │   │   ├─manhole_try.mcfunction
│   │   │   │   │   ├─minecart_stop.mcfunction
│   │   │   │   │   ├─mobilizer_beep.mcfunction
│   │   │   │   │   ├─mobilizer_cancel.mcfunction
│   │   │   │   │   ├─mobilizer_check.mcfunction
│   │   │   │   │   ├─mobilizer_end.mcfunction
│   │   │   │   │   ├─mobilizer_prompt.mcfunction
│   │   │   │   │   ├─mobilizer_punish.mcfunction
│   │   │   │   │   ├─mobilizer_ready.mcfunction
│   │   │   │   │   ├─mortar_burst.mcfunction
│   │   │   │   │   ├─mortar_fire.mcfunction
│   │   │   │   │   ├─mortar_shell_tick.mcfunction
│   │   │   │   │   ├─mortar_tick.mcfunction
│   │   │   │   │   ├─nograv_chase.mcfunction
│   │   │   │   │   ├─nograv_step.mcfunction
│   │   │   │   │   ├─noteblock_cascade.mcfunction
│   │   │   │   │   ├─noteblock_death.mcfunction
│   │   │   │   │   ├─noteblock_note.mcfunction
│   │   │   │   │   ├─ollama_banner.mcfunction
│   │   │   │   │   ├─ollama_banner_1.mcfunction
│   │   │   │   │   ├─ollama_banner_2.mcfunction
│   │   │   │   │   ├─ollama_banner_3.mcfunction
│   │   │   │   │   ├─ollama_banner_4.mcfunction
│   │   │   │   │   ├─ollama_banner_5.mcfunction
│   │   │   │   │   ├─ollama_banner_all.mcfunction
│   │   │   │   │   ├─ollama_cry.mcfunction
│   │   │   │   │   ├─phoenix_egg.mcfunction
│   │   │   │   │   ├─phoenix_guard.mcfunction
│   │   │   │   │   ├─phoenix_hatch.mcfunction
│   │   │   │   │   ├─phoenix_reborn.mcfunction
│   │   │   │   │   ├─pluto_die.mcfunction
│   │   │   │   │   ├─pluto_tick.mcfunction
│   │   │   │   │   ├─random.mcfunction
│   │   │   │   │   ├─ring_follow.mcfunction
│   │   │   │   │   ├─ring_pos_0.mcfunction
│   │   │   │   │   ├─ring_pos_1.mcfunction
│   │   │   │   │   ├─ring_pos_10.mcfunction
│   │   │   │   │   ├─ring_pos_11.mcfunction
│   │   │   │   │   ├─ring_pos_12.mcfunction
│   │   │   │   │   ├─ring_pos_13.mcfunction
│   │   │   │   │   ├─ring_pos_14.mcfunction
│   │   │   │   │   ├─ring_pos_15.mcfunction
│   │   │   │   │   ├─ring_pos_2.mcfunction
│   │   │   │   │   ├─ring_pos_3.mcfunction
│   │   │   │   │   ├─ring_pos_4.mcfunction
│   │   │   │   │   ├─ring_pos_5.mcfunction
│   │   │   │   │   ├─ring_pos_6.mcfunction
│   │   │   │   │   ├─ring_pos_7.mcfunction
│   │   │   │   │   ├─ring_pos_8.mcfunction
│   │   │   │   │   ├─ring_pos_9.mcfunction
│   │   │   │   │   ├─saturn_tick.mcfunction
│   │   │   │   │   ├─sheep_aura.mcfunction
│   │   │   │   │   ├─skater_call.mcfunction
│   │   │   │   │   ├─skater_ice.mcfunction
│   │   │   │   │   ├─skater_skate.mcfunction
│   │   │   │   │   ├─skater_tick.mcfunction
│   │   │   │   │   ├─snow_clear.mcfunction
│   │   │   │   │   ├─snow_place.mcfunction
│   │   │   │   │   ├─sparky_burst.mcfunction
│   │   │   │   │   ├─sparky_charge_sfx.mcfunction
│   │   │   │   │   ├─sparky_fire.mcfunction
│   │   │   │   │   ├─sparky_tick.mcfunction
│   │   │   │   │   ├─spellblade_hit.mcfunction
│   │   │   │   │   ├─spoon_hit.mcfunction
│   │   │   │   │   ├─spoon_try.mcfunction
│   │   │   │   │   ├─summon.mcfunction
│   │   │   │   │   ├─supporter_land.mcfunction
│   │   │   │   │   ├─supporter_lift.mcfunction
│   │   │   │   │   ├─tandem_alone.mcfunction
│   │   │   │   │   ├─tandem_apply.mcfunction
│   │   │   │   │   ├─threshold_death.mcfunction
│   │   │   │   │   ├─twinstar_died_a.mcfunction
│   │   │   │   │   ├─twinstar_died_b.mcfunction
│   │   │   │   │   ├─twinstar_revive_a.mcfunction
│   │   │   │   │   ├─twinstar_revive_b.mcfunction
│   │   │   │   │   ├─vagrant_spit.mcfunction
│   │   │   │   │   └─venus_chill_mark.mcfunction
│   │   │   │   ├─enchanter
│   │   │   │   │   ├─apply_chest_blast_protection.mcfunction
│   │   │   │   │   ├─apply_chest_fire_protection.mcfunction
│   │   │   │   │   ├─apply_chest_projectile_protection.mcfunction
│   │   │   │   │   ├─apply_chest_protection.mcfunction
│   │   │   │   │   ├─apply_chest_thorns.mcfunction
│   │   │   │   │   ├─apply_feet_blast_protection.mcfunction
│   │   │   │   │   ├─apply_feet_depth_strider.mcfunction
│   │   │   │   │   ├─apply_feet_feather_falling.mcfunction
│   │   │   │   │   ├─apply_feet_fire_protection.mcfunction
│   │   │   │   │   ├─apply_feet_frost_walker.mcfunction
│   │   │   │   │   ├─apply_feet_projectile_protection.mcfunction
│   │   │   │   │   ├─apply_feet_protection.mcfunction
│   │   │   │   │   ├─apply_feet_soul_speed.mcfunction
│   │   │   │   │   ├─apply_head_blast_protection.mcfunction
│   │   │   │   │   ├─apply_head_fire_protection.mcfunction
│   │   │   │   │   ├─apply_head_projectile_protection.mcfunction
│   │   │   │   │   ├─apply_head_protection.mcfunction
│   │   │   │   │   ├─apply_head_respiration.mcfunction
│   │   │   │   │   ├─apply_legs_blast_protection.mcfunction
│   │   │   │   │   ├─apply_legs_fire_protection.mcfunction
│   │   │   │   │   ├─apply_legs_projectile_protection.mcfunction
│   │   │   │   │   ├─apply_legs_protection.mcfunction
│   │   │   │   │   ├─apply_legs_thorns.mcfunction
│   │   │   │   │   ├─apply_sword_fire_aspect.mcfunction
│   │   │   │   │   ├─apply_sword_knockback.mcfunction
│   │   │   │   │   ├─apply_sword_sharpness.mcfunction
│   │   │   │   │   ├─apply_sword_smite.mcfunction
│   │   │   │   │   ├─apply_sword_sweeping.mcfunction
│   │   │   │   │   ├─assign_slot.mcfunction
│   │   │   │   │   ├─book_fx.mcfunction
│   │   │   │   │   ├─book_gain.mcfunction
│   │   │   │   │   ├─book_hold.mcfunction
│   │   │   │   │   ├─book_page.mcfunction
│   │   │   │   │   ├─book_passive.mcfunction
│   │   │   │   │   ├─ench_check.mcfunction
│   │   │   │   │   ├─ench_hit.mcfunction
│   │   │   │   │   ├─ench_hurt.mcfunction
│   │   │   │   │   ├─fill_ap.mcfunction
│   │   │   │   │   ├─fill_sw.mcfunction
│   │   │   │   │   ├─hud.mcfunction
│   │   │   │   │   ├─hud_calc.mcfunction
│   │   │   │   │   ├─hud_clear.mcfunction
│   │   │   │   │   ├─hud_show.mcfunction
│   │   │   │   │   ├─name_refresh.mcfunction
│   │   │   │   │   ├─roll_all_armor.mcfunction
│   │   │   │   │   ├─roll_chest.mcfunction
│   │   │   │   │   ├─roll_chest_feet.mcfunction
│   │   │   │   │   ├─roll_feet.mcfunction
│   │   │   │   │   ├─roll_head.mcfunction
│   │   │   │   │   ├─roll_head_chest.mcfunction
│   │   │   │   │   ├─roll_head_legs.mcfunction
│   │   │   │   │   ├─roll_legs.mcfunction
│   │   │   │   │   ├─roll_legs_feet.mcfunction
│   │   │   │   │   ├─roll_sword.mcfunction
│   │   │   │   │   ├─sw_find.mcfunction
│   │   │   │   │   ├─sw_in_1.mcfunction
│   │   │   │   │   ├─sw_in_10.mcfunction
│   │   │   │   │   ├─sw_in_11.mcfunction
│   │   │   │   │   ├─sw_in_12.mcfunction
│   │   │   │   │   ├─sw_in_13.mcfunction
│   │   │   │   │   ├─sw_in_14.mcfunction
│   │   │   │   │   ├─sw_in_15.mcfunction
│   │   │   │   │   ├─sw_in_16.mcfunction
│   │   │   │   │   ├─sw_in_17.mcfunction
│   │   │   │   │   ├─sw_in_18.mcfunction
│   │   │   │   │   ├─sw_in_19.mcfunction
│   │   │   │   │   ├─sw_in_2.mcfunction
│   │   │   │   │   ├─sw_in_20.mcfunction
│   │   │   │   │   ├─sw_in_21.mcfunction
│   │   │   │   │   ├─sw_in_22.mcfunction
│   │   │   │   │   ├─sw_in_23.mcfunction
│   │   │   │   │   ├─sw_in_24.mcfunction
│   │   │   │   │   ├─sw_in_25.mcfunction
│   │   │   │   │   ├─sw_in_26.mcfunction
│   │   │   │   │   ├─sw_in_27.mcfunction
│   │   │   │   │   ├─sw_in_28.mcfunction
│   │   │   │   │   ├─sw_in_29.mcfunction
│   │   │   │   │   ├─sw_in_3.mcfunction
│   │   │   │   │   ├─sw_in_30.mcfunction
│   │   │   │   │   ├─sw_in_31.mcfunction
│   │   │   │   │   ├─sw_in_32.mcfunction
│   │   │   │   │   ├─sw_in_33.mcfunction
│   │   │   │   │   ├─sw_in_34.mcfunction
│   │   │   │   │   ├─sw_in_35.mcfunction
│   │   │   │   │   ├─sw_in_36.mcfunction
│   │   │   │   │   ├─sw_in_37.mcfunction
│   │   │   │   │   ├─sw_in_4.mcfunction
│   │   │   │   │   ├─sw_in_5.mcfunction
│   │   │   │   │   ├─sw_in_6.mcfunction
│   │   │   │   │   ├─sw_in_7.mcfunction
│   │   │   │   │   ├─sw_in_8.mcfunction
│   │   │   │   │   ├─sw_in_9.mcfunction
│   │   │   │   │   ├─sw_out_1.mcfunction
│   │   │   │   │   ├─sw_out_10.mcfunction
│   │   │   │   │   ├─sw_out_11.mcfunction
│   │   │   │   │   ├─sw_out_12.mcfunction
│   │   │   │   │   ├─sw_out_13.mcfunction
│   │   │   │   │   ├─sw_out_14.mcfunction
│   │   │   │   │   ├─sw_out_15.mcfunction
│   │   │   │   │   ├─sw_out_16.mcfunction
│   │   │   │   │   ├─sw_out_17.mcfunction
│   │   │   │   │   ├─sw_out_18.mcfunction
│   │   │   │   │   ├─sw_out_19.mcfunction
│   │   │   │   │   ├─sw_out_2.mcfunction
│   │   │   │   │   ├─sw_out_20.mcfunction
│   │   │   │   │   ├─sw_out_21.mcfunction
│   │   │   │   │   ├─sw_out_22.mcfunction
│   │   │   │   │   ├─sw_out_23.mcfunction
│   │   │   │   │   ├─sw_out_24.mcfunction
│   │   │   │   │   ├─sw_out_25.mcfunction
│   │   │   │   │   ├─sw_out_26.mcfunction
│   │   │   │   │   ├─sw_out_27.mcfunction
│   │   │   │   │   ├─sw_out_28.mcfunction
│   │   │   │   │   ├─sw_out_29.mcfunction
│   │   │   │   │   ├─sw_out_3.mcfunction
│   │   │   │   │   ├─sw_out_30.mcfunction
│   │   │   │   │   ├─sw_out_31.mcfunction
│   │   │   │   │   ├─sw_out_32.mcfunction
│   │   │   │   │   ├─sw_out_33.mcfunction
│   │   │   │   │   ├─sw_out_34.mcfunction
│   │   │   │   │   ├─sw_out_35.mcfunction
│   │   │   │   │   ├─sw_out_36.mcfunction
│   │   │   │   │   ├─sw_out_37.mcfunction
│   │   │   │   │   ├─sw_out_4.mcfunction
│   │   │   │   │   ├─sw_out_5.mcfunction
│   │   │   │   │   ├─sw_out_6.mcfunction
│   │   │   │   │   ├─sw_out_7.mcfunction
│   │   │   │   │   ├─sw_out_8.mcfunction
│   │   │   │   │   ├─sw_out_9.mcfunction
│   │   │   │   │   ├─sw_return.mcfunction
│   │   │   │   │   ├─sw_roll.mcfunction
│   │   │   │   │   ├─sw_up.mcfunction
│   │   │   │   │   ├─sw_wait.mcfunction
│   │   │   │   │   ├─tick.mcfunction
│   │   │   │   │   ├─up_armor.mcfunction
│   │   │   │   │   ├─up_armor_do.mcfunction
│   │   │   │   │   └─up_sword.mcfunction
│   │   │   │   ├─enderman
│   │   │   │   │   ├─arrive.mcfunction
│   │   │   │   │   ├─auto.mcfunction
│   │   │   │   │   ├─cast.mcfunction
│   │   │   │   │   ├─ent_through_a.mcfunction
│   │   │   │   │   ├─ent_through_b.mcfunction
│   │   │   │   │   ├─ent_through_p.mcfunction
│   │   │   │   │   ├─ent_through_r.mcfunction
│   │   │   │   │   ├─enter_a.mcfunction
│   │   │   │   │   ├─enter_b.mcfunction
│   │   │   │   │   ├─enter_p.mcfunction
│   │   │   │   │   ├─enter_r.mcfunction
│   │   │   │   │   ├─exit_a.mcfunction
│   │   │   │   │   ├─exit_b.mcfunction
│   │   │   │   │   ├─exit_p.mcfunction
│   │   │   │   │   ├─exit_r.mcfunction
│   │   │   │   │   ├─fire.mcfunction
│   │   │   │   │   ├─give.mcfunction
│   │   │   │   │   ├─kit_use.mcfunction
│   │   │   │   │   ├─portal_close.mcfunction
│   │   │   │   │   ├─portal_place.mcfunction
│   │   │   │   │   ├─portal_puff.mcfunction
│   │   │   │   │   ├─portal_puff_a.mcfunction
│   │   │   │   │   ├─portal_puff_b.mcfunction
│   │   │   │   │   ├─portal_ray.mcfunction
│   │   │   │   │   ├─portal_tick.mcfunction
│   │   │   │   │   ├─soul_use.mcfunction
│   │   │   │   │   └─use_dispatch.mcfunction
│   │   │   │   ├─farmer
│   │   │   │   │   ├─cultivate.mcfunction
│   │   │   │   │   ├─eat_bread.mcfunction
│   │   │   │   │   ├─grow.mcfunction
│   │   │   │   │   └─harvest.mcfunction
│   │   │   │   ├─fisher
│   │   │   │   │   ├─cast.mcfunction
│   │   │   │   │   ├─fire.mcfunction
│   │   │   │   │   ├─give_egg.mcfunction
│   │   │   │   │   ├─handout.mcfunction
│   │   │   │   │   └─refill.mcfunction
│   │   │   │   ├─ghost
│   │   │   │   │   ├─hurt.mcfunction
│   │   │   │   │   └─passive.mcfunction
│   │   │   │   ├─halley
│   │   │   │   │   ├─auto.mcfunction
│   │   │   │   │   ├─burn.mcfunction
│   │   │   │   │   ├─cast.mcfunction
│   │   │   │   │   ├─give_egg.mcfunction
│   │   │   │   │   ├─heat.mcfunction
│   │   │   │   │   ├─heat_warn.mcfunction
│   │   │   │   │   └─near.mcfunction
│   │   │   │   ├─li_zhujunze
│   │   │   │   │   ├─apocalypse.mcfunction
│   │   │   │   │   ├─auto.mcfunction
│   │   │   │   │   ├─blast_stage.mcfunction
│   │   │   │   │   ├─boom5.mcfunction
│   │   │   │   │   ├─boom8.mcfunction
│   │   │   │   │   ├─cast.mcfunction
│   │   │   │   │   ├─copy_stage.mcfunction
│   │   │   │   │   ├─cycle_end.mcfunction
│   │   │   │   │   ├─give_egg.mcfunction
│   │   │   │   │   └─timer.mcfunction
│   │   │   │   ├─mars
│   │   │   │   │   ├─curse.mcfunction
│   │   │   │   │   ├─curse_hit.mcfunction
│   │   │   │   │   ├─dispatch.mcfunction
│   │   │   │   │   ├─domain_cast.mcfunction
│   │   │   │   │   ├─giant_end.mcfunction
│   │   │   │   │   ├─giant_spawn.mcfunction
│   │   │   │   │   ├─giant_tick.mcfunction
│   │   │   │   │   ├─hit.mcfunction
│   │   │   │   │   ├─music_on.mcfunction
│   │   │   │   │   ├─music_stop.mcfunction
│   │   │   │   │   ├─song_end.mcfunction
│   │   │   │   │   ├─target.mcfunction
│   │   │   │   │   ├─wild_hit.mcfunction
│   │   │   │   │   ├─wild_kill.mcfunction
│   │   │   │   │   ├─wild_random.mcfunction
│   │   │   │   │   ├─wild_spawn.mcfunction
│   │   │   │   │   └─wild_tick.mcfunction
│   │   │   │   ├─mercury
│   │   │   │   │   └─passive.mcfunction
│   │   │   │   ├─pirate
│   │   │   │   │   ├─fire.mcfunction
│   │   │   │   │   ├─give_crossbow.mcfunction
│   │   │   │   │   ├─pickup.mcfunction
│   │   │   │   │   ├─reload.mcfunction
│   │   │   │   │   ├─return.mcfunction
│   │   │   │   │   └─steal.mcfunction
│   │   │   │   ├─pluto
│   │   │   │   │   ├─check.mcfunction
│   │   │   │   │   ├─despawn.mcfunction
│   │   │   │   │   ├─die.mcfunction
│   │   │   │   │   ├─enter_map.mcfunction
│   │   │   │   │   ├─follow.mcfunction
│   │   │   │   │   ├─mount.mcfunction
│   │   │   │   │   ├─passive.mcfunction
│   │   │   │   │   ├─respawn.mcfunction
│   │   │   │   │   └─spawn.mcfunction
│   │   │   │   ├─poisoner
│   │   │   │   │   ├─auto.mcfunction
│   │   │   │   │   ├─cast.mcfunction
│   │   │   │   │   ├─cloud_dot.mcfunction
│   │   │   │   │   ├─cloud_tick.mcfunction
│   │   │   │   │   ├─execute_hit.mcfunction
│   │   │   │   │   ├─give.mcfunction
│   │   │   │   │   ├─hit.mcfunction
│   │   │   │   │   ├─passive.mcfunction
│   │   │   │   │   └─poison_hit.mcfunction
│   │   │   │   ├─slime
│   │   │   │   │   └─passive.mcfunction
│   │   │   │   ├─soul
│   │   │   │   │   ├─archer_apply.mcfunction
│   │   │   │   │   ├─bow_expire.mcfunction
│   │   │   │   │   ├─dispatch_warrior.mcfunction
│   │   │   │   │   ├─earth_apply.mcfunction
│   │   │   │   │   ├─earth_assign.mcfunction
│   │   │   │   │   ├─earth_step.mcfunction
│   │   │   │   │   ├─earth_team_id.mcfunction
│   │   │   │   │   ├─enchanter_apply.mcfunction
│   │   │   │   │   ├─enchanter_expire.mcfunction
│   │   │   │   │   ├─fisher_expire.mcfunction
│   │   │   │   │   ├─fisher_open.mcfunction
│   │   │   │   │   ├─fisher_tick.mcfunction
│   │   │   │   │   ├─ghost_apply.mcfunction
│   │   │   │   │   ├─ghost_expire.mcfunction
│   │   │   │   │   ├─ghost_hurt.mcfunction
│   │   │   │   │   ├─give.mcfunction
│   │   │   │   │   ├─li_apply.mcfunction
│   │   │   │   │   ├─mars_expire.mcfunction
│   │   │   │   │   ├─mars_spawn.mcfunction
│   │   │   │   │   ├─mars_tick.mcfunction
│   │   │   │   │   ├─mars_wild_spawn.mcfunction
│   │   │   │   │   ├─mars_wild_tick.mcfunction
│   │   │   │   │   ├─pirate_expire.mcfunction
│   │   │   │   │   ├─slime_apply.mcfunction
│   │   │   │   │   ├─slime_expire.mcfunction
│   │   │   │   │   ├─soul_ep_expire.mcfunction
│   │   │   │   │   ├─sun_apply.mcfunction
│   │   │   │   │   ├─sun_at.mcfunction
│   │   │   │   │   ├─sun_hit.mcfunction
│   │   │   │   │   ├─sun_mark.mcfunction
│   │   │   │   │   ├─tamer_animal.mcfunction
│   │   │   │   │   ├─tamer_apply.mcfunction
│   │   │   │   │   ├─tamer_at.mcfunction
│   │   │   │   │   ├─tamer_tick.mcfunction
│   │   │   │   │   ├─tamer_wave.mcfunction
│   │   │   │   │   ├─use_archer.mcfunction
│   │   │   │   │   ├─use_assassin.mcfunction
│   │   │   │   │   ├─use_earth.mcfunction
│   │   │   │   │   ├─use_enchanter.mcfunction
│   │   │   │   │   ├─use_ep.mcfunction
│   │   │   │   │   ├─use_farm.mcfunction
│   │   │   │   │   ├─use_fisher.mcfunction
│   │   │   │   │   ├─use_ghost.mcfunction
│   │   │   │   │   ├─use_li.mcfunction
│   │   │   │   │   ├─use_mars.mcfunction
│   │   │   │   │   ├─use_mercury.mcfunction
│   │   │   │   │   ├─use_pirate.mcfunction
│   │   │   │   │   ├─use_slime.mcfunction
│   │   │   │   │   ├─use_sun.mcfunction
│   │   │   │   │   ├─use_tamer.mcfunction
│   │   │   │   │   ├─use_tank.mcfunction
│   │   │   │   │   ├─use_venus.mcfunction
│   │   │   │   │   ├─use_warrior.mcfunction
│   │   │   │   │   ├─use_zombie.mcfunction
│   │   │   │   │   ├─venus_apply.mcfunction
│   │   │   │   │   ├─venus_at.mcfunction
│   │   │   │   │   ├─venus_buff.mcfunction
│   │   │   │   │   ├─venus_end.mcfunction
│   │   │   │   │   ├─venus_tick.mcfunction
│   │   │   │   │   ├─zombie_apply.mcfunction
│   │   │   │   │   └─zombie_expire.mcfunction
│   │   │   │   ├─sun
│   │   │   │   │   ├─noise
│   │   │   │   │   │   ├─1.mcfunction
│   │   │   │   │   │   ├─10.mcfunction
│   │   │   │   │   │   ├─100.mcfunction
│   │   │   │   │   │   ├─101.mcfunction
│   │   │   │   │   │   ├─102.mcfunction
│   │   │   │   │   │   ├─103.mcfunction
│   │   │   │   │   │   ├─104.mcfunction
│   │   │   │   │   │   ├─105.mcfunction
│   │   │   │   │   │   ├─106.mcfunction
│   │   │   │   │   │   ├─107.mcfunction
│   │   │   │   │   │   ├─108.mcfunction
│   │   │   │   │   │   ├─109.mcfunction
│   │   │   │   │   │   ├─11.mcfunction
│   │   │   │   │   │   ├─110.mcfunction
│   │   │   │   │   │   ├─111.mcfunction
│   │   │   │   │   │   ├─112.mcfunction
│   │   │   │   │   │   ├─113.mcfunction
│   │   │   │   │   │   ├─114.mcfunction
│   │   │   │   │   │   ├─115.mcfunction
│   │   │   │   │   │   ├─116.mcfunction
│   │   │   │   │   │   ├─117.mcfunction
│   │   │   │   │   │   ├─118.mcfunction
│   │   │   │   │   │   ├─119.mcfunction
│   │   │   │   │   │   ├─12.mcfunction
│   │   │   │   │   │   ├─120.mcfunction
│   │   │   │   │   │   ├─121.mcfunction
│   │   │   │   │   │   ├─122.mcfunction
│   │   │   │   │   │   ├─123.mcfunction
│   │   │   │   │   │   ├─124.mcfunction
│   │   │   │   │   │   ├─125.mcfunction
│   │   │   │   │   │   ├─126.mcfunction
│   │   │   │   │   │   ├─127.mcfunction
│   │   │   │   │   │   ├─128.mcfunction
│   │   │   │   │   │   ├─13.mcfunction
│   │   │   │   │   │   ├─14.mcfunction
│   │   │   │   │   │   ├─15.mcfunction
│   │   │   │   │   │   ├─16.mcfunction
│   │   │   │   │   │   ├─17.mcfunction
│   │   │   │   │   │   ├─18.mcfunction
│   │   │   │   │   │   ├─19.mcfunction
│   │   │   │   │   │   ├─2.mcfunction
│   │   │   │   │   │   ├─20.mcfunction
│   │   │   │   │   │   ├─21.mcfunction
│   │   │   │   │   │   ├─22.mcfunction
│   │   │   │   │   │   ├─23.mcfunction
│   │   │   │   │   │   ├─24.mcfunction
│   │   │   │   │   │   ├─25.mcfunction
│   │   │   │   │   │   ├─26.mcfunction
│   │   │   │   │   │   ├─27.mcfunction
│   │   │   │   │   │   ├─28.mcfunction
│   │   │   │   │   │   ├─29.mcfunction
│   │   │   │   │   │   ├─3.mcfunction
│   │   │   │   │   │   ├─30.mcfunction
│   │   │   │   │   │   ├─31.mcfunction
│   │   │   │   │   │   ├─32.mcfunction
│   │   │   │   │   │   ├─33.mcfunction
│   │   │   │   │   │   ├─34.mcfunction
│   │   │   │   │   │   ├─35.mcfunction
│   │   │   │   │   │   ├─36.mcfunction
│   │   │   │   │   │   ├─37.mcfunction
│   │   │   │   │   │   ├─38.mcfunction
│   │   │   │   │   │   ├─39.mcfunction
│   │   │   │   │   │   ├─4.mcfunction
│   │   │   │   │   │   ├─40.mcfunction
│   │   │   │   │   │   ├─41.mcfunction
│   │   │   │   │   │   ├─42.mcfunction
│   │   │   │   │   │   ├─43.mcfunction
│   │   │   │   │   │   ├─44.mcfunction
│   │   │   │   │   │   ├─45.mcfunction
│   │   │   │   │   │   ├─46.mcfunction
│   │   │   │   │   │   ├─47.mcfunction
│   │   │   │   │   │   ├─48.mcfunction
│   │   │   │   │   │   ├─49.mcfunction
│   │   │   │   │   │   ├─5.mcfunction
│   │   │   │   │   │   ├─50.mcfunction
│   │   │   │   │   │   ├─51.mcfunction
│   │   │   │   │   │   ├─52.mcfunction
│   │   │   │   │   │   ├─53.mcfunction
│   │   │   │   │   │   ├─54.mcfunction
│   │   │   │   │   │   ├─55.mcfunction
│   │   │   │   │   │   ├─56.mcfunction
│   │   │   │   │   │   ├─57.mcfunction
│   │   │   │   │   │   ├─58.mcfunction
│   │   │   │   │   │   ├─59.mcfunction
│   │   │   │   │   │   ├─6.mcfunction
│   │   │   │   │   │   ├─60.mcfunction
│   │   │   │   │   │   ├─61.mcfunction
│   │   │   │   │   │   ├─62.mcfunction
│   │   │   │   │   │   ├─63.mcfunction
│   │   │   │   │   │   ├─64.mcfunction
│   │   │   │   │   │   ├─65.mcfunction
│   │   │   │   │   │   ├─66.mcfunction
│   │   │   │   │   │   ├─67.mcfunction
│   │   │   │   │   │   ├─68.mcfunction
│   │   │   │   │   │   ├─69.mcfunction
│   │   │   │   │   │   ├─7.mcfunction
│   │   │   │   │   │   ├─70.mcfunction
│   │   │   │   │   │   ├─71.mcfunction
│   │   │   │   │   │   ├─72.mcfunction
│   │   │   │   │   │   ├─73.mcfunction
│   │   │   │   │   │   ├─74.mcfunction
│   │   │   │   │   │   ├─75.mcfunction
│   │   │   │   │   │   ├─76.mcfunction
│   │   │   │   │   │   ├─77.mcfunction
│   │   │   │   │   │   ├─78.mcfunction
│   │   │   │   │   │   ├─79.mcfunction
│   │   │   │   │   │   ├─8.mcfunction
│   │   │   │   │   │   ├─80.mcfunction
│   │   │   │   │   │   ├─81.mcfunction
│   │   │   │   │   │   ├─82.mcfunction
│   │   │   │   │   │   ├─83.mcfunction
│   │   │   │   │   │   ├─84.mcfunction
│   │   │   │   │   │   ├─85.mcfunction
│   │   │   │   │   │   ├─86.mcfunction
│   │   │   │   │   │   ├─87.mcfunction
│   │   │   │   │   │   ├─88.mcfunction
│   │   │   │   │   │   ├─89.mcfunction
│   │   │   │   │   │   ├─9.mcfunction
│   │   │   │   │   │   ├─90.mcfunction
│   │   │   │   │   │   ├─91.mcfunction
│   │   │   │   │   │   ├─92.mcfunction
│   │   │   │   │   │   ├─93.mcfunction
│   │   │   │   │   │   ├─94.mcfunction
│   │   │   │   │   │   ├─95.mcfunction
│   │   │   │   │   │   ├─96.mcfunction
│   │   │   │   │   │   ├─97.mcfunction
│   │   │   │   │   │   ├─98.mcfunction
│   │   │   │   │   │   └─99.mcfunction
│   │   │   │   │   ├─flare_cast.mcfunction
│   │   │   │   │   ├─flare_end.mcfunction
│   │   │   │   │   ├─flare_fire.mcfunction
│   │   │   │   │   ├─flare_hit.mcfunction
│   │   │   │   │   ├─flare_tick.mcfunction
│   │   │   │   │   ├─give_bow.mcfunction
│   │   │   │   │   ├─give_flare.mcfunction
│   │   │   │   │   ├─give_spot.mcfunction
│   │   │   │   │   ├─noise_pick.mcfunction
│   │   │   │   │   ├─passive.mcfunction
│   │   │   │   │   ├─pickup.mcfunction
│   │   │   │   │   ├─refill.mcfunction
│   │   │   │   │   ├─refill_flare.mcfunction
│   │   │   │   │   ├─refill_give_flare.mcfunction
│   │   │   │   │   ├─refill_give_spot.mcfunction
│   │   │   │   │   ├─refill_spot.mcfunction
│   │   │   │   │   ├─return.mcfunction
│   │   │   │   │   ├─spot_cast.mcfunction
│   │   │   │   │   ├─spot_fire.mcfunction
│   │   │   │   │   ├─spot_hit.mcfunction
│   │   │   │   │   └─steal.mcfunction
│   │   │   │   ├─tainted_archer
│   │   │   │   │   ├─core_apply.mcfunction
│   │   │   │   │   ├─core_fire.mcfunction
│   │   │   │   │   ├─dispatch.mcfunction
│   │   │   │   │   ├─give_bow.mcfunction
│   │   │   │   │   ├─give_token_core.mcfunction
│   │   │   │   │   ├─give_token_turret.mcfunction
│   │   │   │   │   ├─pickup.mcfunction
│   │   │   │   │   ├─refill_bow.mcfunction
│   │   │   │   │   ├─refill_core.mcfunction
│   │   │   │   │   ├─refill_tokens.mcfunction
│   │   │   │   │   ├─refill_turret.mcfunction
│   │   │   │   │   ├─return_bow.mcfunction
│   │   │   │   │   ├─steal_bow.mcfunction
│   │   │   │   │   ├─team_slot.mcfunction
│   │   │   │   │   ├─turret_cast.mcfunction
│   │   │   │   │   ├─turret_fire.mcfunction
│   │   │   │   │   ├─turret_from_molten.mcfunction
│   │   │   │   │   ├─turret_heal.mcfunction
│   │   │   │   │   ├─turret_hit.mcfunction
│   │   │   │   │   └─turret_to_molten.mcfunction
│   │   │   │   ├─tainted_bomber
│   │   │   │   │   ├─big_cast.mcfunction
│   │   │   │   │   ├─dispatch.mcfunction
│   │   │   │   │   ├─nuke_cast.mcfunction
│   │   │   │   │   ├─refill.mcfunction
│   │   │   │   │   ├─refill_big.mcfunction
│   │   │   │   │   ├─refill_nuke.mcfunction
│   │   │   │   │   ├─refill_track.mcfunction
│   │   │   │   │   ├─small_cast.mcfunction
│   │   │   │   │   └─track_cast.mcfunction
│   │   │   │   ├─tainted_farmer
│   │   │   │   │   ├─leader_tick.mcfunction
│   │   │   │   │   ├─rally_dispatch.mcfunction
│   │   │   │   │   ├─rally_do.mcfunction
│   │   │   │   │   ├─rally_refill.mcfunction
│   │   │   │   │   ├─rise_dispatch.mcfunction
│   │   │   │   │   ├─rise_summon.mcfunction
│   │   │   │   │   ├─team_slot.mcfunction
│   │   │   │   │   ├─wave_stone.mcfunction
│   │   │   │   │   └─wave_wood.mcfunction
│   │   │   │   ├─tainted_fisher
│   │   │   │   │   ├─blue_ball.mcfunction
│   │   │   │   │   ├─blue_cast.mcfunction
│   │   │   │   │   ├─blue_start.mcfunction
│   │   │   │   │   ├─cang_release.mcfunction
│   │   │   │   │   ├─cang_tick.mcfunction
│   │   │   │   │   ├─domain_cast.mcfunction
│   │   │   │   │   ├─domain_end.mcfunction
│   │   │   │   │   ├─domain_open.mcfunction
│   │   │   │   │   ├─domain_start.mcfunction
│   │   │   │   │   ├─domain_tick.mcfunction
│   │   │   │   │   ├─give_blue.mcfunction
│   │   │   │   │   ├─give_domain.mcfunction
│   │   │   │   │   ├─handout.mcfunction
│   │   │   │   │   └─water_passive.mcfunction
│   │   │   │   ├─tainted_ghost
│   │   │   │   │   └─passive.mcfunction
│   │   │   │   ├─tainted_slime
│   │   │   │   │   ├─charge.mcfunction
│   │   │   │   │   ├─land.mcfunction
│   │   │   │   │   └─passive.mcfunction
│   │   │   │   ├─tainted_tamer
│   │   │   │   │   ├─cast1.mcfunction
│   │   │   │   │   ├─cast2.mcfunction
│   │   │   │   │   ├─give1.mcfunction
│   │   │   │   │   ├─give2.mcfunction
│   │   │   │   │   ├─link.mcfunction
│   │   │   │   │   ├─refill1.mcfunction
│   │   │   │   │   ├─refill2.mcfunction
│   │   │   │   │   ├─restock1.mcfunction
│   │   │   │   │   ├─restock2.mcfunction
│   │   │   │   │   ├─spawn_blaze.mcfunction
│   │   │   │   │   ├─spawn_creeper.mcfunction
│   │   │   │   │   ├─spawn_skeleton.mcfunction
│   │   │   │   │   ├─spawn_vex.mcfunction
│   │   │   │   │   ├─spawn_vindicator.mcfunction
│   │   │   │   │   ├─spawn_witch.mcfunction
│   │   │   │   │   ├─spawn_zombie.mcfunction
│   │   │   │   │   ├─start_cd1.mcfunction
│   │   │   │   │   └─start_cd2.mcfunction
│   │   │   │   ├─tainted_tank
│   │   │   │   │   └─passive.mcfunction
│   │   │   │   ├─tamer
│   │   │   │   │   ├─auto.mcfunction
│   │   │   │   │   ├─cast.mcfunction
│   │   │   │   │   ├─fire.mcfunction
│   │   │   │   │   └─give_egg.mcfunction
│   │   │   │   ├─tank
│   │   │   │   │   ├─cast.mcfunction
│   │   │   │   │   ├─dispatch.mcfunction
│   │   │   │   │   ├─expire.mcfunction
│   │   │   │   │   ├─fire.mcfunction
│   │   │   │   │   ├─give_egg.mcfunction
│   │   │   │   │   ├─handout.mcfunction
│   │   │   │   │   └─passive.mcfunction
│   │   │   │   ├─venus
│   │   │   │   │   ├─arm_cast.mcfunction
│   │   │   │   │   ├─arm_expire.mcfunction
│   │   │   │   │   ├─arm_fire.mcfunction
│   │   │   │   │   ├─arm_refresh.mcfunction
│   │   │   │   │   ├─bomb_cast.mcfunction
│   │   │   │   │   ├─bomb_fire.mcfunction
│   │   │   │   │   ├─chill_apply.mcfunction
│   │   │   │   │   ├─chill_cast.mcfunction
│   │   │   │   │   ├─chill_expire.mcfunction
│   │   │   │   │   ├─chill_fire.mcfunction
│   │   │   │   │   ├─chill_mark.mcfunction
│   │   │   │   │   ├─dog_alive_check.mcfunction
│   │   │   │   │   ├─dog_follow.mcfunction
│   │   │   │   │   ├─dog_respawn.mcfunction
│   │   │   │   │   ├─give_arm.mcfunction
│   │   │   │   │   ├─give_bomb.mcfunction
│   │   │   │   │   ├─give_chill.mcfunction
│   │   │   │   │   ├─refill_arm.mcfunction
│   │   │   │   │   ├─refill_bomb.mcfunction
│   │   │   │   │   ├─refill_chill.mcfunction
│   │   │   │   │   └─summon_dog.mcfunction
│   │   │   │   ├─werewolf
│   │   │   │   │   ├─auto.mcfunction
│   │   │   │   │   ├─bite.mcfunction
│   │   │   │   │   ├─cast.mcfunction
│   │   │   │   │   ├─feed.mcfunction
│   │   │   │   │   ├─fire.mcfunction
│   │   │   │   │   ├─give_egg.mcfunction
│   │   │   │   │   ├─hit.mcfunction
│   │   │   │   │   └─kill.mcfunction
│   │   │   │   ├─zhanshishi
│   │   │   │   │   ├─assign_slot.mcfunction
│   │   │   │   │   ├─check_boom.mcfunction
│   │   │   │   │   ├─check_float.mcfunction
│   │   │   │   │   ├─check_hook.mcfunction
│   │   │   │   │   ├─check_poison.mcfunction
│   │   │   │   │   ├─check_worm.mcfunction
│   │   │   │   │   ├─drop_hook.mcfunction
│   │   │   │   │   ├─drop_worm.mcfunction
│   │   │   │   │   ├─give_boom.mcfunction
│   │   │   │   │   ├─give_float.mcfunction
│   │   │   │   │   ├─give_hook.mcfunction
│   │   │   │   │   ├─give_poison.mcfunction
│   │   │   │   │   ├─give_worm.mcfunction
│   │   │   │   │   ├─pick_boom.mcfunction
│   │   │   │   │   ├─pick_float.mcfunction
│   │   │   │   │   ├─pick_hook.mcfunction
│   │   │   │   │   ├─pick_poison.mcfunction
│   │   │   │   │   ├─pick_worm.mcfunction
│   │   │   │   │   ├─refill_boom.mcfunction
│   │   │   │   │   ├─refill_float.mcfunction
│   │   │   │   │   ├─refill_hook.mcfunction
│   │   │   │   │   ├─refill_worm.mcfunction
│   │   │   │   │   ├─scan_fallback.mcfunction
│   │   │   │   │   ├─team_maintain.mcfunction
│   │   │   │   │   ├─trigger_boom.mcfunction
│   │   │   │   │   ├─trigger_float.mcfunction
│   │   │   │   │   ├─trigger_hook.mcfunction
│   │   │   │   │   ├─trigger_poison.mcfunction
│   │   │   │   │   └─trigger_worm.mcfunction
│   │   │   │   ├─zhuzhiwu
│   │   │   │   │   ├─buff_tick.mcfunction
│   │   │   │   │   ├─cizhi_apply.mcfunction
│   │   │   │   │   ├─cizhi_cast.mcfunction
│   │   │   │   │   ├─cizhi_remove.mcfunction
│   │   │   │   │   ├─dispatch.mcfunction
│   │   │   │   │   ├─give_token.mcfunction
│   │   │   │   │   ├─hit.mcfunction
│   │   │   │   │   ├─hit_roll.mcfunction
│   │   │   │   │   ├─pull.mcfunction
│   │   │   │   │   └─refill.mcfunction
│   │   │   │   ├─zombie
│   │   │   │   │   └─passive.mcfunction
│   │   │   │   └─dispatch.mcfunction
│   │   │   ├─summon
│   │   │   │   ├─bomber_big.mcfunction
│   │   │   │   ├─bomber_fake.mcfunction
│   │   │   │   ├─bomber_nuke.mcfunction
│   │   │   │   ├─bomber_nuke_warn.mcfunction
│   │   │   │   ├─bomber_small.mcfunction
│   │   │   │   ├─bomber_track.mcfunction
│   │   │   │   ├─burger_beast.mcfunction
│   │   │   │   ├─earth_ascend.mcfunction
│   │   │   │   ├─earth_ascend2.mcfunction
│   │   │   │   ├─earth_ascend_pick.mcfunction
│   │   │   │   ├─earth_astronaut.mcfunction
│   │   │   │   ├─earth_atrain.mcfunction
│   │   │   │   ├─earth_axe.mcfunction
│   │   │   │   ├─earth_babywhelp.mcfunction
│   │   │   │   ├─earth_big_bomb.mcfunction
│   │   │   │   ├─earth_boatman_wet.mcfunction
│   │   │   │   ├─earth_brewer.mcfunction
│   │   │   │   ├─earth_brick_fire.mcfunction
│   │   │   │   ├─earth_brick_knockback.mcfunction
│   │   │   │   ├─earth_campfire.mcfunction
│   │   │   │   ├─earth_capitalist.mcfunction
│   │   │   │   ├─earth_captain.mcfunction
│   │   │   │   ├─earth_carto.mcfunction
│   │   │   │   ├─earth_colorchanger.mcfunction
│   │   │   │   ├─earth_cop.mcfunction
│   │   │   │   ├─earth_cop_blink.mcfunction
│   │   │   │   ├─earth_cop_cleaner.mcfunction
│   │   │   │   ├─earth_cop_pick.mcfunction
│   │   │   │   ├─earth_cop_pick_b.mcfunction
│   │   │   │   ├─earth_coser.mcfunction
│   │   │   │   ├─earth_cyclic.mcfunction
│   │   │   │   ├─earth_dispenser.mcfunction
│   │   │   │   ├─earth_disruptor.mcfunction
│   │   │   │   ├─earth_dominion.mcfunction
│   │   │   │   ├─earth_dublinn.mcfunction
│   │   │   │   ├─earth_explainer.mcfunction
│   │   │   │   ├─earth_farmer.mcfunction
│   │   │   │   ├─earth_fisher1.mcfunction
│   │   │   │   ├─earth_fisher2.mcfunction
│   │   │   │   ├─earth_forester.mcfunction
│   │   │   │   ├─earth_gatherer.mcfunction
│   │   │   │   ├─earth_gearbox.mcfunction
│   │   │   │   ├─earth_gentleman.mcfunction
│   │   │   │   ├─earth_gentleman_rain_end.mcfunction
│   │   │   │   ├─earth_ghost_minion.mcfunction
│   │   │   │   ├─earth_grass.mcfunction
│   │   │   │   ├─earth_grass_pop.mcfunction
│   │   │   │   ├─earth_hacker.mcfunction
│   │   │   │   ├─earth_hacker_death.mcfunction
│   │   │   │   ├─earth_hive.mcfunction
│   │   │   │   ├─earth_hydrator.mcfunction
│   │   │   │   ├─earth_ilsacul.mcfunction
│   │   │   │   ├─earth_janitor.mcfunction
│   │   │   │   ├─earth_jar.mcfunction
│   │   │   │   ├─earth_jar_small.mcfunction
│   │   │   │   ├─earth_jupiter.mcfunction
│   │   │   │   ├─earth_leaker.mcfunction
│   │   │   │   ├─earth_lowflyer.mcfunction
│   │   │   │   ├─earth_lowflyer_a.mcfunction
│   │   │   │   ├─earth_lowflyer_b.mcfunction
│   │   │   │   ├─earth_manhole.mcfunction
│   │   │   │   ├─earth_medium.mcfunction
│   │   │   │   ├─earth_mercury.mcfunction
│   │   │   │   ├─earth_minecart.mcfunction
│   │   │   │   ├─earth_minecart_pick.mcfunction
│   │   │   │   ├─earth_minecart_plain.mcfunction
│   │   │   │   ├─earth_mobilizer.mcfunction
│   │   │   │   ├─earth_mortar.mcfunction
│   │   │   │   ├─earth_noteblock.mcfunction
│   │   │   │   ├─earth_ollama.mcfunction
│   │   │   │   ├─earth_peptide_chain.mcfunction
│   │   │   │   ├─earth_phoenix.mcfunction
│   │   │   │   ├─earth_phoenix_pair.mcfunction
│   │   │   │   ├─earth_pluto.mcfunction
│   │   │   │   ├─earth_polypeptide.mcfunction
│   │   │   │   ├─earth_polypeptide_betaturn.mcfunction
│   │   │   │   ├─earth_qin.mcfunction
│   │   │   │   ├─earth_retainer.mcfunction
│   │   │   │   ├─earth_saturn.mcfunction
│   │   │   │   ├─earth_sheep.mcfunction
│   │   │   │   ├─earth_skater.mcfunction
│   │   │   │   ├─earth_sparky.mcfunction
│   │   │   │   ├─earth_spellblade.mcfunction
│   │   │   │   ├─earth_spoon.mcfunction
│   │   │   │   ├─earth_stone.mcfunction
│   │   │   │   ├─earth_supporter_fast.mcfunction
│   │   │   │   ├─earth_supporter_slow.mcfunction
│   │   │   │   ├─earth_tandem.mcfunction
│   │   │   │   ├─earth_target.mcfunction
│   │   │   │   ├─earth_threshold.mcfunction
│   │   │   │   ├─earth_tracker_bomb.mcfunction
│   │   │   │   ├─earth_turret.mcfunction
│   │   │   │   ├─earth_twinstar.mcfunction
│   │   │   │   ├─earth_twinstar_a.mcfunction
│   │   │   │   ├─earth_twinstar_b.mcfunction
│   │   │   │   ├─earth_vagrant.mcfunction
│   │   │   │   ├─earth_venus.mcfunction
│   │   │   │   ├─earth_winner.mcfunction
│   │   │   │   ├─ghost_minion.mcfunction
│   │   │   │   ├─ghost_minion_pair.mcfunction
│   │   │   │   ├─li_pig_copy.mcfunction
│   │   │   │   ├─pluto_parrot.mcfunction
│   │   │   │   ├─soul_farm_leader.mcfunction
│   │   │   │   ├─tainted_farmer_leader.mcfunction
│   │   │   │   ├─tainted_farmer_stone.mcfunction
│   │   │   │   ├─tainted_farmer_wood.mcfunction
│   │   │   │   ├─tainted_tamer_blaze.mcfunction
│   │   │   │   ├─tainted_tamer_creeper.mcfunction
│   │   │   │   ├─tainted_tamer_skeleton.mcfunction
│   │   │   │   ├─tainted_tamer_vex.mcfunction
│   │   │   │   ├─tainted_tamer_vindicator.mcfunction
│   │   │   │   ├─tainted_tamer_witch.mcfunction
│   │   │   │   ├─tainted_tamer_zombie.mcfunction
│   │   │   │   ├─trap_worm.mcfunction
│   │   │   │   ├─turret.mcfunction
│   │   │   │   ├─venus_bomb.mcfunction
│   │   │   │   ├─venus_dog.mcfunction
│   │   │   │   ├─zombie_iron_armor.mcfunction
│   │   │   │   └─zombie_iron_helmet.mcfunction
│   │   │   ├─tick
│   │   │   │   ├─burger.mcfunction
│   │   │   │   ├─earth.mcfunction
│   │   │   │   ├─kits_a.mcfunction
│   │   │   │   ├─kits_b.mcfunction
│   │   │   │   ├─kits_c.mcfunction
│   │   │   │   ├─kits_d.mcfunction
│   │   │   │   ├─kits_e.mcfunction
│   │   │   │   ├─kits_f.mcfunction
│   │   │   │   ├─life.mcfunction
│   │   │   │   ├─lobby.mcfunction
│   │   │   │   ├─player.mcfunction
│   │   │   │   ├─slow2.mcfunction
│   │   │   │   ├─slow4.mcfunction
│   │   │   │   └─world.mcfunction
│   │   │   ├─util
│   │   │   │   ├─clear_item.mcfunction
│   │   │   │   ├─clear_player.mcfunction
│   │   │   │   ├─give_kit.mcfunction
│   │   │   │   ├─team_index.mcfunction
│   │   │   │   └─team_join.mcfunction
│   │   │   ├─load.mcfunction
│   │   │   └─tick.mcfunction
│   │   ├─predicates
│   │   │   ├─random
│   │   │   │   ├─1in2.json
│   │   │   │   ├─1in3.json
│   │   │   │   ├─1in4.json
│   │   │   │   ├─1in5.json
│   │   │   │   ├─1in6.json
│   │   │   │   ├─1in7.json
│   │   │   │   ├─1in8.json
│   │   │   │   └─1in9.json
│   │   │   ├─chaos_xbow_charged.json
│   │   │   ├─has_jump_boost.json
│   │   │   └─sneaking.json
│   │   └─structures
│   │       ├─arena1.nbt
│   │       ├─arena2.nbt
│   │       ├─arena3.nbt
│   │       ├─arena4.nbt
│   │       ├─arena5.nbt
│   │       ├─arena6.nbt
│   │       ├─arena7.nbt
│   │       ├─arena8.nbt
│   │       ├─arena9.nbt
│   │       ├─cobblestone1.nbt
│   │       ├─cobblestone2.nbt
│   │       ├─cobblestone3.nbt
│   │       ├─cobblestone4.nbt
│   │       ├─cobblestone5.nbt
│   │       ├─cobblestone6.nbt
│   │       ├─cobblestone7.nbt
│   │       ├─cobblestone8.nbt
│   │       ├─cobblestone9.nbt
│   │       ├─desert1.nbt
│   │       ├─desert2.nbt
│   │       ├─desert3.nbt
│   │       ├─desert4.nbt
│   │       ├─earth1.nbt
│   │       ├─earth2.nbt
│   │       ├─earth3.nbt
│   │       ├─earth4.nbt
│   │       ├─mansion1.nbt
│   │       ├─mansion2.nbt
│   │       ├─mansion3.nbt
│   │       ├─ocean1.nbt
│   │       ├─ocean2.nbt
│   │       ├─ocean3.nbt
│   │       ├─ocean4.nbt
│   │       ├─ocean5.nbt
│   │       ├─ocean6.nbt
│   │       ├─snow1.nbt
│   │       ├─snow2.nbt
│   │       ├─snow3.nbt
│   │       ├─snow4.nbt
│   │       ├─toronto1.nbt
│   │       ├─toronto2.nbt
│   │       ├─toronto3.nbt
│   │       ├─toronto4.nbt
│   │       ├─toronto5.nbt
│   │       ├─toronto6.nbt
│   │       ├─toronto7.nbt
│   │       ├─toronto8.nbt
│   │       ├─toronto9.nbt
│   │       ├─xian1.nbt
│   │       └─xian2.nbt
│   └─minecraft
│       └─tags
│           └─functions
│               ├─load.json
│               └─tick.json
└─pack.mcmeta
```
