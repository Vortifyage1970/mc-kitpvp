# 数据包目录结构（1.20.1）

> 本文件由每次改动后重新扫描 `src/` 生成，是**唯一的函数/文件清单权威**。
> 任何新增、改名的函数或数据文件，都必须重新扫描后更新本文件。
> 只写目录树，不写解释。找不到的文件 = 不存在，不要假设。

## 目录树

```
D:\MC-KITPVP\SRC
│  pack.mcmeta
│
└─data
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
    │  │  │  │  check_winner.mcfunction
    │  │  │  │  end.mcfunction
    │  │  │  │  reset.mcfunction
    │  │  │  │  start.mcfunction
    │  │  │  │  start_impl.mcfunction
    │  │  │  │  sudden_death_start.mcfunction
    │  │  │  │  sudden_drop.mcfunction
    │  │  │  │  timer_tick.mcfunction
    │  │  │  │
    │  │  │  └─music
    │  │  │      └─kitpvp
    │  │  │          └─functions
    │  │  │              └─music
    │  │  │                  └─yu_ai
    │  │  │                          start.mcfunction
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
    │  │  ├─music
    │  │  │  └─yu_ai
    │  │  │          ev_0000.mcfunction
    │  │  │          ev_0001.mcfunction
    │  │  │          ev_0002.mcfunction
    │  │  │          ev_0003.mcfunction
    │  │  │          ev_0004.mcfunction
    │  │  │          ev_0005.mcfunction
    │  │  │          ev_0006.mcfunction
    │  │  │          ev_0007.mcfunction
    │  │  │          ev_0008.mcfunction
    │  │  │          ev_0009.mcfunction
    │  │  │          ev_0010.mcfunction
    │  │  │          ev_0011.mcfunction
    │  │  │          ev_0012.mcfunction
    │  │  │          ev_0013.mcfunction
    │  │  │          ev_0014.mcfunction
    │  │  │          ev_0015.mcfunction
    │  │  │          ev_0016.mcfunction
    │  │  │          ev_0017.mcfunction
    │  │  │          ev_0018.mcfunction
    │  │  │          ev_0019.mcfunction
    │  │  │          ev_0020.mcfunction
    │  │  │          ev_0021.mcfunction
    │  │  │          ev_0022.mcfunction
    │  │  │          ev_0023.mcfunction
    │  │  │          ev_0024.mcfunction
    │  │  │          ev_0025.mcfunction
    │  │  │          ev_0026.mcfunction
    │  │  │          ev_0027.mcfunction
    │  │  │          ev_0028.mcfunction
    │  │  │          ev_0029.mcfunction
    │  │  │          ev_0030.mcfunction
    │  │  │          ev_0031.mcfunction
    │  │  │          ev_0032.mcfunction
    │  │  │          ev_0033.mcfunction
    │  │  │          ev_0034.mcfunction
    │  │  │          ev_0035.mcfunction
    │  │  │          ev_0036.mcfunction
    │  │  │          ev_0037.mcfunction
    │  │  │          ev_0038.mcfunction
    │  │  │          ev_0039.mcfunction
    │  │  │          ev_0040.mcfunction
    │  │  │          ev_0041.mcfunction
    │  │  │          ev_0042.mcfunction
    │  │  │          ev_0043.mcfunction
    │  │  │          ev_0044.mcfunction
    │  │  │          ev_0045.mcfunction
    │  │  │          ev_0046.mcfunction
    │  │  │          ev_0047.mcfunction
    │  │  │          ev_0048.mcfunction
    │  │  │          ev_0049.mcfunction
    │  │  │          ev_0050.mcfunction
    │  │  │          ev_0051.mcfunction
    │  │  │          ev_0052.mcfunction
    │  │  │          ev_0053.mcfunction
    │  │  │          ev_0054.mcfunction
    │  │  │          ev_0055.mcfunction
    │  │  │          ev_0056.mcfunction
    │  │  │          ev_0057.mcfunction
    │  │  │          ev_0058.mcfunction
    │  │  │          ev_0059.mcfunction
    │  │  │          ev_0060.mcfunction
    │  │  │          ev_0061.mcfunction
    │  │  │          ev_0062.mcfunction
    │  │  │          ev_0063.mcfunction
    │  │  │          ev_0064.mcfunction
    │  │  │          ev_0065.mcfunction
    │  │  │          ev_0066.mcfunction
    │  │  │          ev_0067.mcfunction
    │  │  │          ev_0068.mcfunction
    │  │  │          ev_0069.mcfunction
    │  │  │          ev_0070.mcfunction
    │  │  │          ev_0071.mcfunction
    │  │  │          ev_0072.mcfunction
    │  │  │          ev_0073.mcfunction
    │  │  │          ev_0074.mcfunction
    │  │  │          ev_0075.mcfunction
    │  │  │          ev_0076.mcfunction
    │  │  │          ev_0077.mcfunction
    │  │  │          ev_0078.mcfunction
    │  │  │          ev_0079.mcfunction
    │  │  │          ev_0080.mcfunction
    │  │  │          ev_0081.mcfunction
    │  │  │          ev_0082.mcfunction
    │  │  │          ev_0083.mcfunction
    │  │  │          ev_0084.mcfunction
    │  │  │          ev_0085.mcfunction
    │  │  │          ev_0086.mcfunction
    │  │  │          ev_0087.mcfunction
    │  │  │          ev_0088.mcfunction
    │  │  │          ev_0089.mcfunction
    │  │  │          ev_0090.mcfunction
    │  │  │          ev_0091.mcfunction
    │  │  │          ev_0092.mcfunction
    │  │  │          ev_0093.mcfunction
    │  │  │          ev_0094.mcfunction
    │  │  │          ev_0095.mcfunction
    │  │  │          ev_0096.mcfunction
    │  │  │          ev_0097.mcfunction
    │  │  │          ev_0098.mcfunction
    │  │  │          ev_0099.mcfunction
    │  │  │          ev_0100.mcfunction
    │  │  │          ev_0101.mcfunction
    │  │  │          ev_0102.mcfunction
    │  │  │          ev_0103.mcfunction
    │  │  │          ev_0104.mcfunction
    │  │  │          ev_0105.mcfunction
    │  │  │          ev_0106.mcfunction
    │  │  │          ev_0107.mcfunction
    │  │  │          ev_0108.mcfunction
    │  │  │          ev_0109.mcfunction
    │  │  │          ev_0110.mcfunction
    │  │  │          ev_0111.mcfunction
    │  │  │          ev_0112.mcfunction
    │  │  │          ev_0113.mcfunction
    │  │  │          start.mcfunction
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
```