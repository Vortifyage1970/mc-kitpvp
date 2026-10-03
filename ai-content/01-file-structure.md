# 数据包目录结构（1.20.1）

> 本文件由每次改动后重新扫描 `src/` 生成，是**唯一的函数/文件清单权威**。
> 任何新增、改名的函数或数据文件，都必须重新扫描后更新本文件。
> 只写目录树，不写解释。找不到的文件 = 不存在，不要假设。

## 目录树

```
D:\MC-KITPVP\SRC\DATA
├─kitpvp
│  ├─advancements
│  │  └─player
│  │          archer_pickup.json
│  │          lectern_teleport_1.json
│  │
│  ├─functions
│  │  │  load.mcfunction
│  │  │  tick.mcfunction
│  │  │
│  │  ├─debug
│  │  │  │  add_lives.mcfunction
│  │  │  │  check_winner.mcfunction
│  │  │  │  death_check.mcfunction
│  │  │  │  god_off.mcfunction
│  │  │  │  god_on.mcfunction
│  │  │  │  god_toggle.mcfunction
│  │  │  │  heal.mcfunction
│  │  │  │  kill_mobs.mcfunction
│  │  │  │  kill_self.mcfunction
│  │  │  │  menu.mcfunction
│  │  │  │  remove_lives.mcfunction
│  │  │  │  reset_cd.mcfunction
│  │  │  │  reset_cd_all.mcfunction
│  │  │  │  spawn.mcfunction
│  │  │  │  spawn_creeper.mcfunction
│  │  │  │  spawn_dummy.mcfunction
│  │  │  │  spawn_skeleton.mcfunction
│  │  │  │  spawn_zombie.mcfunction
│  │  │  │  status.mcfunction
│  │  │  │  tp_lobby.mcfunction
│  │  │  │
│  │  │  └─test
│  │  │          build.mcfunction
│  │  │          force_end.mcfunction
│  │  │          force_reset.mcfunction
│  │  │          force_select_list.mcfunction
│  │  │          off.mcfunction
│  │  │          on.mcfunction
│  │  │          play.mcfunction
│  │  │          solo_start.mcfunction
│  │  │          status.mcfunction
│  │  │
│  │  ├─game
│  │  │      check_winner.mcfunction
│  │  │      end.mcfunction
│  │  │      reset.mcfunction
│  │  │      start.mcfunction
│  │  │      start_impl.mcfunction
│  │  │      sudden_death_start.mcfunction
│  │  │      sudden_drop.mcfunction
│  │  │      timer_tick.mcfunction
│  │  │
│  │  ├─kit
│  │  │  │  archer.mcfunction
│  │  │  │  assassin.mcfunction
│  │  │  │  assassin_passive.mcfunction
│  │  │  │  list.mcfunction
│  │  │  │  tank.mcfunction
│  │  │  │  tank_passive.mcfunction
│  │  │  │  warrior.mcfunction
│  │  │  │
│  │  │  ├─info
│  │  │  │      archer.mcfunction
│  │  │  │      assassin.mcfunction
│  │  │  │      tank.mcfunction
│  │  │  │      warrior.mcfunction
│  │  │  │
│  │  │  └─list
│  │  │          astral.mcfunction
│  │  │          classic.mcfunction
│  │  │          classic_chaos.mcfunction
│  │  │          classic_tainted.mcfunction
│  │  │          history.mcfunction
│  │  │          meme.mcfunction
│  │  │          operator.mcfunction
│  │  │
│  │  ├─lobby
│  │  │      build.mcfunction
│  │  │      destroy.mcfunction
│  │  │      display_lock.mcfunction
│  │  │      enter.mcfunction
│  │  │      exit.mcfunction
│  │  │      give_items.mcfunction
│  │  │      lectern_teleport_1.mcfunction
│  │  │      menu.mcfunction
│  │  │      pad.mcfunction
│  │  │      pad_enter.mcfunction
│  │  │      ready_check.mcfunction
│  │  │      ready_off.mcfunction
│  │  │      ready_on.mcfunction
│  │  │      ready_toggle.mcfunction
│  │  │      reset_self.mcfunction
│  │  │      spawn.mcfunction
│  │  │      teleport.mcfunction
│  │  │      tp_to_kit.mcfunction
│  │  │      tp_to_main.mcfunction
│  │  │
│  │  ├─map
│  │  │  │  distribute.mcfunction
│  │  │  │  random.mcfunction
│  │  │  │  restore.mcfunction
│  │  │  │  select_desert.mcfunction
│  │  │  │  select_menu.mcfunction
│  │  │  │
│  │  │  └─desert
│  │  │          distribute.mcfunction
│  │  │          pass.mcfunction
│  │  │          spawn_1.mcfunction
│  │  │          spawn_2.mcfunction
│  │  │          spawn_3.mcfunction
│  │  │          spawn_4.mcfunction
│  │  │          spawn_5.mcfunction
│  │  │          spawn_6.mcfunction
│  │  │          spawn_7.mcfunction
│  │  │          spawn_8.mcfunction
│  │  │          spawn_9.mcfunction
│  │  │
│  │  ├─player
│  │  │      after_death.mcfunction
│  │  │      death_dispatch.mcfunction
│  │  │      eliminate.mcfunction
│  │  │      end_invincible.mcfunction
│  │  │      invincible.mcfunction
│  │  │      join.mcfunction
│  │  │      on_death.mcfunction
│  │  │
│  │  ├─skill
│  │  │  │  archer_give_bow.mcfunction
│  │  │  │  archer_pickup.mcfunction
│  │  │  │  archer_refill.mcfunction
│  │  │  │  archer_return.mcfunction
│  │  │  │  archer_steal.mcfunction
│  │  │  │  assassin_cast.mcfunction
│  │  │  │  assassin_dispatch.mcfunction
│  │  │  │  assassin_fire.mcfunction
│  │  │  │  assassin_give_item.mcfunction
│  │  │  │  assassin_unhide.mcfunction
│  │  │  │  dispatch.mcfunction
│  │  │  │  tank_cast.mcfunction
│  │  │  │  tank_dispatch.mcfunction
│  │  │  │  tank_expire.mcfunction
│  │  │  │  tank_fire.mcfunction
│  │  │  │  tank_give_egg.mcfunction
│  │  │  │  warrior.mcfunction
│  │  │  │  warrior_consume.mcfunction
│  │  │  │  warrior_ready.mcfunction
│  │  │  │
│  │  │  └─soul
│  │  │          bow_expire.mcfunction
│  │  │          give.mcfunction
│  │  │          on_drop.mcfunction
│  │  │          use_archer.mcfunction
│  │  │          use_assassin.mcfunction
│  │  │          use_tank.mcfunction
│  │  │          use_warrior.mcfunction
│  │  │
│  │  └─util
│  │          clear_player.mcfunction
│  │          give_kit.mcfunction
│  │          say.mcfunction
│  │          title.mcfunction
│  │
│  ├─item_modifiers
│  ├─predicates
│  │  └─random
│  │          1in2.json
│  │          1in3.json
│  │          1in4.json
│  │          1in5.json
│  │          1in6.json
│  │          1in7.json
│  │          1in8.json
│  │          1in9.json
│  │
│  └─tags
└─minecraft
    └─tags
        └─functions
                load.json
                tick.json