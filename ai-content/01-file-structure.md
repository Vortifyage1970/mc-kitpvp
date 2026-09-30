\# 数据包目录结构（1.20.1）

# 该文档为每次更改后通过cmd读取文件目录得到的所有文件，如要参考目前有哪些函数可放心严格参考

\## 目录树

D:\MC-KITPVP\SRC
│  pack.mcmeta
│
└─data
    ├─kitpvp
    │  ├─advancements
    │  │  └─player
    │  │          archer_pickup.json
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
    │  │  │  │  list.mcfunction
    │  │  │  │  warrior.mcfunction
    │  │  │  │
    │  │  │  ├─info
    │  │  │  │      archer.mcfunction
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
    │  │  │      enter.mcfunction
    │  │  │      exit.mcfunction
    │  │  │      menu.mcfunction
    │  │  │      reset_self.mcfunction
    │  │  │      spawn.mcfunction
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
    │  │  │      archer_give_bow.mcfunction
    │  │  │      archer_pickup.mcfunction
    │  │  │      archer_refill.mcfunction
    │  │  │      archer_return.mcfunction
    │  │  │      archer_steal.mcfunction
    │  │  │      dispatch.mcfunction
    │  │  │      warrior.mcfunction
    │  │  │      warrior_consume.mcfunction
    │  │  │      warrior_ready.mcfunction
    │  │  │
    │  │  └─util
    │  │          clear_player.mcfunction
    │  │          give_kit.mcfunction
    │  │          say.mcfunction
    │  │          title.mcfunction
    │  │
    │  ├─item_modifiers
    │  ├─loot_tables
    │  ├─predicates
    │  └─tags
    │      └─functions
    └─minecraft
        └─tags
            └─functions
                    load.json
                    tick.json