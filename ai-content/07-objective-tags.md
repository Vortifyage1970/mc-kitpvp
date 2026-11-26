# Objective / Tag / 物品标记 索引

> **定位**：本文件是**派生账本**——记录代码里实际用了哪些名字，用于查重与速查。
>
> **权威顺序**：**代码优先**。真身在 `load.mcfunction` / `player/join.mcfunction` / `util/clear_player.mcfunction` / `tick.mcfunction` / `skill/*`。
> 账本与代码冲突时，改账本；账本允许暂时滞后，但**不允许写与代码相反的内容**。
>
> 变更频率：每次新增 objective / tag / 物品标记时补一行。
> 这条"允许滞后"的约定是刻意的——它免除"每次改代码必须同步文档"的负担。

---

## 一、命名规则

| 类别 | 格式 | 例 |
|---|---|---|
| objective | `kitpvp.<小写字母数字下划线>` | `kitpvp.cd` |
| 假玩家 | `#<用途> kitpvp.<命名空间>` | `#state kitpvp.game` |
| tag | `kitpvp.<小写字母数字下划线>` | `kitpvp.selected` |
| 物品 NBT 标记 | `Kit<驼峰名>`，值统一 `1b` | `KitTankEgg:1b` |

> objective 名只允许小写字母、数字、点、下划线，不能有大写。

---

## 二、Objective

### 2.1 dummy 类型

全部在 `load.mcfunction` 里统一创建。

| 名称 | 用途 | 初始化于 | 消费者 |
|---|---|---|---|
| `kitpvp.kit` | 职业 ID（0=未选） | load / join / clear_player | give_kit、dispatch、tick 各检测行 |
| `kitpvp.cd` | 主技能冷却 / 补货节流（刻） | load / join / clear_player | tick 递减、dispatch 闸门；补货型**两侧都写**——使用侧 `*_fire` 带 `cd<=0` 守卫（arsonist / enderman / werewolf / tamer / tainted_archer/turret_fire），补货侧无条件（`arsonist/give`、`enderman/give`、`werewolf/auto`、`tamer/auto`、tick 的里·弓箭手补货段）；真冷却型由 `*_fire` 写（tank / assassin / fisher/refill / pirate/fire / sun/flare_fire） |
| `kitpvp.cd2` | 第二技能冷却（刻）——里·弓箭手的熔火核心（120 秒）+ 其令牌补货节流；太阳黑子（40 秒） | load / join / clear_player | tick 递减、skill/tainted_archer/core_fire、skill/sun/spot_fire |
| `kitpvp.alive` | 存活（1=活 0=旁观） | load / join / clear_player | tick 各检测行 |
| `kitpvp.spawn_slot` | 出生点编号（1..9，重生兜底用） | load / clear_player | map/*/spawn_N、player/spawn_anchor（见 04 §十一） |
| `kitpvp.lives` | 剩余命数 | load / join / clear_player | 死亡结算 |
| `kitpvp.kills` | 击杀数 | load / join / clear_player | 结算 |
| `kitpvp.deaths` | 死亡数 | load / join / clear_player | 结算 |
| `kitpvp.map` | 当前地图 ID（全局，挂 `#global`）：1 沙漠 / 2 竞技场 / 3 雪原 / 7 地球 / 8 西安 / 9 豪宅 / 10 君士坦丁堡 / 11 多伦多 / 0 = 随机 | load | 地图选择、game/reset |
| `kitpvp.timer` | 全局倒计时（秒，挂 `#global`） | load | timer_tick |
| `kitpvp.inv` | 无敌剩余刻数 | load / join / clear_player | end_invincible 判定 |
| `kitpvp.death_seen` | 死亡快照 | load / join / clear_player | death_dispatch |
| `kitpvp.game` | 游戏状态 + 全局假玩家宿主 | load | check_winner / start / end |
| `kitpvp.item` | 物品计数——**预留**：给"按物品数量判定"的技能用，现无消费者 | load / join / clear_player | — |
| `kitpvp.tmp` | 通用临时（地图出生点随机用 `#cur`；玩家侧：海盗换弹/装填检测、里·弓箭手令牌补货计数、狼人令牌补货计数、驯兽师狼蛋补货计数） | load | map/*/distribute、skill/pirate/reload、tick（海盗段 / 里·弓箭手段）、skill/werewolf/auto、skill/tamer/auto |
| `kitpvp.tid` | 幽灵队槽编号（1..6） | load / clear_player（刻意不清） | summon/ghost_minion* |
| `kitpvp.rng` | 随机数（玩家分数） | load | kit/random、kit/random_classic、kit/random_tainted |
| `kitpvp.tank_last` | 坦克令牌快照 | join / clear_player | tick |
| `kitpvp.assassin_last` | 刺客令牌快照 | join / clear_player | tick |
| `kitpvp.arsonist_last` | 燃烧瓶投掷快照 | join / clear_player | tick |
| `kitpvp.arsonist_ammo` | 燃烧瓶剩余数（上限 2）——**每次补货判定前用 `clear ... 0` 按背包真实数量刷新**，不再由 fire/give 增减 | join（0）/ clear_player（0） | skill/arsonist/auto |
| `kitpvp.fire_timer` | 火焰守护剩余刻数（挂在 marker 上） | arsonist_place（新 marker 设 100） | arsonist_flame_tick |
| `kitpvp.fisher_last` | 渔夫令牌快照 | join / clear_player | tick |
| `kitpvp.fisher_no_tri` | 无戟计时器（160 刻阈值） | load / kit/fisher / clear_player | fisher_fire、tick |
| `kitpvp.ready_last` | 大厅准备快照 | join / lobby/enter / clear_player | tick |
| `kitpvp.soul_rand` | 魂石随机数 | clear_player | soul/give |
| `kitpvp.soul_next` | 下次魂石倒计时（刻；≤0 即发一颗并按命数重装，见 game/soul_tick） | load / join / clear_player | game/sudden_drop → game/soul_tick |
| `kitpvp.soul_bow_timer` | 魂石弓倒计时 | clear_player | skill/soul/use_archer、skill/soul/bow_expire |
| `kitpvp.soul_warrior_last` | 战士魂石快照 | join / clear_player | tick |
| `kitpvp.soul_archer_last` | 弓箭手魂石快照 | join / clear_player | tick |
| `kitpvp.soul_ghost_last` | 幽灵魂石快照 | clear_player | tick |
| `kitpvp.soul_ghost_timer` | 幽灵魂石激活倒计时 | clear_player | tick、ghost_expire |
| `kitpvp.soul_pirate_last` | 海盗魂石快照 | join / clear_player | tick |
| `kitpvp.soul_pirate_timer` | 魂石手炮倒计时 | clear_player | tick、pirate_expire |
| `kitpvp.soul_fisher_last` | 渔夫魂石快照 | join / clear_player | tick |
| `kitpvp.soul_fisher_timer` | 渔夫魂石倒计时（400 起手 → 380 落「无量空渔」→ 0 收束） | load（0）/ clear_player（0）/ skill/soul/use_fisher（400） | tick → skill/soul/fisher_tick |
| `kitpvp.soul_zombie_last` | 僵尸魂石快照 | load / clear_player | tick |
| `kitpvp.soul_zombie_timer` | 僵尸魂石倒计时（400 = 20 秒，到点摘掉 +20 上限） | load（0）/ clear_player（0）/ skill/soul/zombie_apply（400） | tick → skill/soul/zombie_expire |
| `kitpvp.soul_earth_last` | 地球魂石快照 | load / clear_player | tick |
| `kitpvp.soul_earth_team` | 地球魂石认出的"使用者当时所在队"编号（挂 marker：1..6 幽灵 / 7..12 炮台 / 13..18 里·驯兽师 / 19..24 地球） | skill/soul/earth_apply（写 marker） | skill/soul/earth_step（按编号 team join）、game/reset |
| `kitpvp.soul_li_last` | 李朱俊泽魂石快照 | load / clear_player | tick |
| `kitpvp.soul_tamer_last` | 驯兽师魂石快照 | load / clear_player | tick |
| `kitpvp.soul_sun_last` | 太阳魂石快照 | load / clear_player | tick |
| `kitpvp.soul_mercury_used` | `minecraft.used:minecraft.tropical_fish_spawn_egg`（河豚蛋；没有任何职业发这种蛋） | load | tick → `skill/soul/use_mercury` |
| `kitpvp.soul_mercury_last` | 水星魂石快照 | load / clear_player / join | tick |
| `kitpvp.halley_used` | `minecraft.used:minecraft.magma_cube_spawn_egg`（哈雷彗星「天堂制造」令牌） | load | tick → `skill/halley/cast` |
| `kitpvp.halley_last` | 哈雷彗星技能快照 | load / clear_player / join | tick |
| `kitpvp.halley_cd` | 哈雷彗星补货冷却（1200 = 60 秒） | kit/halley | tick → `skill/halley/auto` |
| `kitpvp.halley_heat` | 哈雷彗星升温计时（2700 = 45 秒） | kit/halley | tick → `skill/halley/heat` |
| `kitpvp.halley_pending` | 哈雷彗星灼烧倒计时（300 = 15 秒；-1 空闲） | kit/halley | tick → `skill/halley/burn` |
| `kitpvp.soul_venus_last` | 金星魂石快照 | load / clear_player | tick |
| `kitpvp.soul_slime_last` | 史莱姆魂石快照 | load / join / clear_player | tick |
| `kitpvp.bomb_last` | 炸弹兵令牌快照（五种令牌共用同一个 used 计数，按载体 tag 分流） | load / join / clear_player | tick → skill/bomber/dispatch、skill/tainted_bomber/dispatch |
| `kitpvp.soul_slime_timer` | 史莱姆魂石倒计时（400 = 20 秒） | load（0）/ clear_player（0）/ skill/soul/slime_apply（400） | tick → skill/soul/slime_expire |
| `kitpvp.rocket_charge` | 蓄力火箭跳的蓄力刻数（0..60；每 4 刻一档） | load（0）/ join（0）/ clear_player（0）/ skill/tainted_slime/passive（0） | tick → skill/tainted_slime/charge；kit/tainted_slime、skill/soul/slime_apply 也置 0 |
| `kitpvp.bomb_small_cd` | 小炸弹补货计时（表 200 = 10 秒；里不再发小炸弹） | load（0）/ join（0）/ clear_player（0） | tick 递减；small_cast 置 200、refill_small 补货后重置 |
| `kitpvp.bomb_big_cd` | 大炸弹补货计时（表 400 = 20 秒、上限 2；里 400 = 20 秒、上限 4） | load（0）/ join（0）/ clear_player（0） | tick 递减；big_cast 置 400、refill_big 补货后重置 |
| `kitpvp.bomb_fake_cd` | 假核弹补货计时（表 500 = 25 秒；只有表有，上限 1） | load（0）/ join（0）/ clear_player（0） | tick 递减；fake_cast 置 500、refill_fake 补货后重置 |
| `kitpvp.bomb_track_cd` | 跟踪炸弹补货计时（表 800 = 40 秒、上限 1；里 400 = 20 秒、上限 2） | load（0）/ join（0）/ clear_player（0） | tick 递减；track_cast 置表 800 / 里 400、refill_track 补货后重置 |
| `kitpvp.bomb_nuke_cd` | 核弹补货计时（只给里用：300 = 15 秒；表的核弹一次性，不碰它） | load（0）/ join（0）/ clear_player（0） | tick 递减；tainted_bomber/nuke_cast 置 300、refill_nuke 补货后重置 |
| `kitpvp.bomb_life` | 跟踪炸弹的隐形小僵尸骑手寿命（120 刻） | summon/bomber_track（120） | tick 递减、归零即 kill |
| `kitpvp.btid` | 炸弹兵跟踪炸弹的队槽编号（1..6） | load（补零不置零）/ start_impl（0）/ clear_player（补零） | summon/bomber_track（选槽并 join 玩家与召唤物） |
| `kitpvp.soul_timer` | 魂石倒计时（挂 marker / 舔狗：400 = 20 秒） | skill/soul/{tamer,sun,venus}_apply（400） | skill/soul/*_tick（每刻 -1，到 0 收尾） |
| `kitpvp.trap_id` | 陷阱师槽位 1..6（同时是陷阱虫的队槽 trap_<id>） | skill/zhanshishi/assign_slot | clear_player / join / reset(0) |
| `kitpvp.trap_team` | 陷阱师当前所在的队槽（37..42 = trap_1..6；陷阱虫靠它归队） | skill/zhanshishi/team_maintain | trigger_worm、clear_player |
| `kitpvp.trap_hook_cd` | 绊索陷阱补货倒计时（500 刻；**丢出时就起计**，见 drop_hook） | drop_hook / refill_hook / clear_player | tick/kits_d 递减 |
| `kitpvp.trap_worm_cd` | 蠹虫陷阱补货倒计时（1800 刻 = 90 秒；**丢出时就起计**） | drop_worm / refill_worm / clear_player | tick/kits_d 递减 |
| `kitpvp.trap_jump_used` | `minecraft.custom:minecraft.jump`（跳跃累计） | load | refill_float |
| `kitpvp.trap_<类型>_pick_used` | `minecraft.picked_up:<物品>`（绊索 tripwire_hook / 漂浮 quartz / 蠹虫 firework_star / 猛毒 spider_eye / 爆炸 poppy，共 5 条） | load | 每 2 刻与 `_pick_last` 比对 → `skill/zhanshishi/pick_<类型>` |
| `kitpvp.trap_<类型>_pick_last` | 捡起快照（判定"捡到的是不是别人的"前先推平它） | load / join / clear_player / kit | skill/zhanshishi/pick_<类型> |
| `kitpvp.trap_hook_drop_used` / `kitpvp.trap_worm_drop_used` | `minecraft.dropped:<物品>`（**丢出即进冷却**的判据：tripwire_hook / firework_star） | load | tick/slow2 → `drop_hook` / `drop_worm` |
| `kitpvp.trap_hook_drop_last` / `kitpvp.trap_worm_drop_last` | 丢出快照 | load / join / clear_player / kit | `drop_hook` / `drop_worm` |
| `kitpvp.trap_float_last` | 漂浮陷阱的跳跃快照 | load / join / clear_player / kit | refill_float |
| `kitpvp.cizhi_used` | `minecraft.used:minecraft.sniffer_spawn_egg`（本服只有烛之武的辞令令牌用它） | load | tick/slow2 → skill/zhuzhiwu/dispatch |
| `kitpvp.cizhi_last` | 辞令令牌快照 | load / join / clear_player / kit | skill/zhuzhiwu/dispatch |
| `kitpvp.cizhi_timer` | 辞令剩余刻数（200 = 10 秒） | kit(0) / join(0) / clear_player(0) | skill/zhuzhiwu/buff_tick |
| `kitpvp.cz_rng` | 烛之武被动掷数（0..255；平时 %20 ≈ 5%，辞令状态 %10 ≈ 10%） | skill/zhuzhiwu/hit_roll | skill/zhuzhiwu/hit_roll |
| `#cz20` / `#cz10` | 烛之武被动取模常量：平时 20（≈5%）、辞令状态 10（≈10%） | load | skill/zhuzhiwu/hit_roll |
| `kitpvp.soul_next` | 魂石间隔（到 0 触发下一波 / 下一条噪音 / 下一次增益） |
| `kitpvp.soul_sun_owner` | 太阳魂石的使用者（落点写给最近的玩家；只在这一刻用来排除他，标完立刻摘掉） | skill/soul/sun_apply | skill/soul/sun_apply（同刻摘掉） |
| `kitpvp.sun_hit_timer` | 太阳魂石：被日蚀锁定的剩余刻数（400；标记在人身上，走出范围也照走） | skill/soul/sun_mark（400）/ clear_player（0） | skill/soul/sun_hit |
| `kitpvp.sun_hit_next` | 太阳魂石：下一条噪音倒计时（40 刻一条） | skill/soul/sun_mark（20）/ clear_player（0） | skill/soul/sun_hit |
| `kitpvp.burger_charge` | 汉堡小子蓄力进度（0..1000；1000 = 50 秒；松手暂停保留） | kit/burger(0) / join(0) / clear_player(0) / reset(0) | tick/burger → skill/burger/charge |
| `kitpvp.burger_snd` | 汉堡小子每秒提示音计时（20 = 1 秒，只在蓄力中递减） | kit/burger(20) / join(20) / clear_player(20) / reset(20) | skill/burger/charge |
| `kitpvp.burger_slot` | 汉堡小子专属 bossbar 槽（1..8，取第一个空槽） | skill/burger/assign_slot | clear_player(0) / reset(0) |
| `kitpvp.burger_announced` | 汉堡小子 25 秒全场提示是否已发（0/1） | kit/burger(0) / charge / summon | skill/burger/charge |
| `kitpvp.soul_venus_owner` | 金星魂石的使用者（舔狗的减速光环排除他） | skill/soul/venus_apply | skill/soul/venus_end、game/reset、clear_player | skill/soul/{tamer,sun,venus}_apply | skill/soul/{tamer,sun,venus}_tick |
| `kitpvp.ghost_minion_cd` | 阴兵召唤冷却（100 刻） | clear_player | soul/ghost_hurt 闸门、ghost_expire |
| `kitpvp.ender_last` | 末影珍珠投掷快照 | join / clear_player | tick |
| `kitpvp.ender_ammo` | 末影之珠剩余数（上限 3）——**每次补货判定前用 `clear ... 0` 按背包真实数量刷新**，不再由 fire/give 增减 | kit/enderman（3）/ join（0）/ clear_player（0） | skill/enderman/auto |
| `kitpvp.tainted_turret_last` | 炮台令牌快照 | join / clear_player | tick |
| `kitpvp.werewolf_last` | 狼人嗅闻令牌快照 | join / clear_player | tick |
| `kitpvp.werewolf_hit_cd` | 狼人命中被动的 18 刻内置冷却 | load（0）/ kit/werewolf / clear_player | tick 递减、skill/werewolf/bite（置 18） |
| `kitpvp.tamer_last` | 驯兽师狼蛋快照 | join / clear_player | tick |
| `kitpvp.tainted_core_last` | 熔火核心快照 | join / clear_player | skill/tainted_archer/dispatch |
| `kitpvp.ttid` | 炮台队槽编号（1..6） | load / clear_player（**刻意不清**，同 tid） | kit/tainted_archer、skill/tainted_archer/* |
| `kitpvp.turret_owner` | 炮台归属（主人的 ttid；挂炮台） | skill/tainted_archer/turret_fire | skill/tainted_archer/* |
| `kitpvp.turret_seq` | 炮台召唤序号（用来挑"最早的那个"；挂炮台） | skill/tainted_archer/turret_fire | skill/tainted_archer/turret_fire |
| `kitpvp.turret_heal_cd` | 炮台回血（被动）冷却，1 秒 | load（0）/ clear_player（0） | tick（每刻 -1）、skill/tainted_archer/turret_heal（置 20） |
| `kitpvp.turret_molten_timer` | 炮台熔火形态剩余刻数（挂炮台；施放瞬间设 600，tick 归零复原） | skill/tainted_archer/turret_to_molten | tick、skill/tainted_archer/turret_from_molten |
| `kitpvp.tainted_fisher_blue_last` | 「苍」令牌快照 | join / clear_player | tick |
| `kitpvp.tainted_fisher_cang_timer` | 「苍」前摇计时（30 → 0 刻；20 / 10 刻各报一句，0 刻释放水球） | load（0）/ blue_start（30）/ clear_player（0） | tick → skill/tainted_fisher/cang_tick |
| `kitpvp.tainted_fisher_domain_last` | 「领域展开」令牌快照 | join / clear_player | tick |
| `kitpvp.tainted_fisher_domain_timer` | 领域展开计时（1220 起手 → 1200 开领域 → 0 收束，一个变量表达三段） | load（0）/ domain_start（1220）/ clear_player（0） | tick → skill/tainted_fisher/domain_tick |
| `kitpvp.sun_flare_last` | 太阳耀斑令牌快照 | join / clear_player | tick |
| `kitpvp.sun_spot_last` | 太阳黑子令牌快照 | join / clear_player | tick |
| `kitpvp.sun_flare_timer` | 短波通信干扰剩余刻数（100 = 5 秒；挂中招者，归零由 `flare_end` 收束） | flare_hit（100）/ clear_player（0） | tick → skill/sun/flare_tick |
| `kitpvp.sun_reload` | 太阳「日冕物质抛射」的换弹冷却剩余刻（200 = 10 秒） | load / join / clear_player（0） | tick 读秒；skill/sun/pickup 当闸门、skill/sun/refill 写回 200 |
| `kitpvp.alchemist_last` | 药剂师喷溅药剂投掷快照 | join / clear_player | tick → skill/alchemist/cast |
| `kitpvp.alchemist_drink_last` | 药剂师秘药饮用快照 | join / clear_player | tick → skill/alchemist/elixir_cast |
| `kitpvp.pa_type` | 药剂师当前主手药剂类型（0 无 / 1 迅捷 / 2 再生 / 3 跳跃 / 4 隐匿；tick 每刻重建） | join / clear_player / load（0） | tick 写入，skill/alchemist/fire 读上一刻值 |
| `kitpvp.pa_type_prev` | 上一刻的 `pa_type`——投出后物品已离手，只能看这个 | join / clear_player / load（0） | tick 每刻推进，skill/alchemist/fire |
| `kitpvp.pa_drink_type` | 药剂师当前主手秘药类型（0 无 / 1 抗火 / 2 力量 / 3 缓降 / 4 神龟；tick 每刻重建） | join / clear_player / load（0） | tick 写入，skill/alchemist/elixir_fire 读上一刻值 |
| `kitpvp.pa_drink_type_prev` | 上一刻的 `pa_drink_type` | join / clear_player / load（0） | tick 每刻推进，skill/alchemist/elixir_fire |
| `kitpvp.ttamer_zombie_last` | 里·驯兽师僵尸蛋快照 | join / clear_player | tick → skill/tainted_tamer/cast1 |
| `kitpvp.ttamer_skeleton_last` | 骷髅蛋快照 | join / clear_player | tick → cast1 |
| `kitpvp.ttamer_creeper_last` | 苦力怕蛋快照 | join / clear_player | tick → cast1 |
| `kitpvp.ttamer_vindicator_last` | 卫道士蛋快照 | join / clear_player | tick → cast2 |
| `kitpvp.ttamer_witch_last` | 女巫蛋快照 | join / clear_player | tick → cast2 |
| `kitpvp.ttamer_vex_last` | 恼鬼蛋快照 | join / clear_player | tick → cast2 |
| `kitpvp.ttamer_blaze_last` | 烈焰人蛋快照 | join / clear_player | tick → cast2 |
| `kitpvp.ttamer_tid` | 里·驯兽师召唤物的队槽编号（1..6） | load（0）；clear_player **刻意不清**（同 tid） | skill/tainted_tamer/link |
| `kitpvp.venus_chill_last` | 金星制冷模块快照 | join / clear_player | tick → skill/venus/chill_cast |
| `kitpvp.venus_arm_last` | 金星武装模块快照 | join / clear_player | tick → skill/venus/arm_cast |
| `kitpvp.venus_bomb_last` | 金星自爆模块快照 | join / clear_player | tick → skill/venus/bomb_cast |
| `kitpvp.venus_cd3` | 金星第三技能冷却（600 刻；同时充当舔狗复活倒计时） | load / join / clear_player（0） | tick 递减；bomb_fire 置 600、tick 的 refill/复活链读它 |
| `kitpvp.venus_dog_timer` | 舔狗复活倒计时（600 → 0） | load / join / clear_player（0） | bomb_fire 与 dog_alive_check 置 600、tick 递减、dog_respawn |
| `kitpvp.venus_chill_timer` | 制冷模块剩余刻数（200；挂舔狗） | chill_fire（200） | tick 递减、chill_expire（0） |
| `kitpvp.venus_arm_timer` | 武装模块剩余刻数（400；挂舔狗） | arm_fire（400） | tick 递减、arm_expire（0） |
| `kitpvp.dog_owner` | 舔狗归属的 vtid（挂舔狗） | venus/summon_dog | skill/venus/*（找自己的狗、冷气排除主人） |
| `kitpvp.ptid` | 冥王星鹦鹉的归属编号（玩家，每选一次领一个新号） | kit/pluto（领取）/ clear_player | skill/pluto/follow、check、respawn、despawn |
| `kitpvp.parrot_owner` | 冥王星鹦鹉的归属编号（挂鹦鹉身上） | skill/pluto/spawn | skill/pluto/follow、check、respawn、despawn |
| `kitpvp.parrot_miss` | 冥王星鹦鹉缺失的持续刻数（0 起；找到就清零，缺 6 刻才判「鹦鹉已死」） | kit/pluto（0）/ clear_player（0）/ skill/pluto/*（0） | skill/pluto/check（每刻加减）、die |
| `kitpvp.vtid` | 金星的舔狗队槽编号（1..6） | load / join（**补零不置零**，重载后保留） | kit/venus、skill/venus/* |
| `kitpvp.coldness` | 冷度（0..100 = 0..5 秒；全局，其它职业 / 地图可复用） | load / join / clear_player（0） | tick（每刻衰减 + 冷却模块加热）、skill/venus/chill_apply |
| `kitpvp.civil_last` | 文明小子口水投掷快照 | join / clear_player | tick → skill/civil/cast |
| `kitpvp.civil_demon_last` | 恶魔形态令牌快照 | join / clear_player | tick → skill/civil/demon_cast |
| `kitpvp.civil_demon_timer` | 恶魔形态剩余刻数（1200 → 0） | load / join / clear_player（0） | demon_start（1200）、tick 递减、demon_end |
| `kitpvp.li_pig_last` | 李朱俊泽召唤蛋快照 | join / clear_player | tick → skill/li_zhujunze/cast |
| `kitpvp.earth_last` | 地球召唤生灵快照 | join / clear_player | tick → skill/earth/cast |
| `kitpvp.earth_cd_a` | 地球召唤物的技能计时（挂实体：Sheepass 200 刻 / 扰动者 60 刻） | summon/earth_sheep、earth_disruptor | tick 递减、skill/earth/sheep_aura 与 disrupt（重置） |
| `kitpvp.earth_lev` | 超凡升天计时（挂实体：60 → 开始漂浮并置 300 → 0 离场） | summon/earth_ascend、earth_ascend2（60） | tick 递减、skill/earth/levitate_start / levitate_end |
| `kitpvp.earth_life` | 地球召唤物寿命（挂实体：跟踪炸弹的小僵尸 120 刻） | summon/earth_tracker_bomb（120） | tick 递减、归零即 kill |
| `kitpvp.dominion_age` | Dominion 出场后活了多久（挂实体；256 之后不再补烟，烟花本身只放一次） | summon/earth_dominion（0） | tick 每刻 +1 |
| `kitpvp.earth_fw_life` | 烟花烟痕标记的寿命（挂 marker：每 2 刻减 1，到 0 自毁） | skill/earth/dominion_firework（40） | skill/earth/dominion_smoke |
| `kitpvp.minecart_life` | 矿车寿命（挂实体：800 = 40 秒，到 0 连船自毁） | summon/earth_minecart（800） | tick 递减、skill/earth/minecart_stop |
| `kitpvp.leaker_cd` | 泄密者的播报计时（挂时钟 marker：300 = 15 秒） | summon/earth_leaker | tick 递减、skill/earth/leaker_tick（重置） |
| `kitpvp.skater_snd` | 滑冰者滑行音效冷却（40 = 2 秒） | summon/earth_skater | skill/earth/skater_tick / skater_skate |
| `kitpvp.tep_used` | `minecraft.used:minecraft.spyglass`（传送枪右键） | load | tick → skill/enderman/portal_use |
| `kitpvp.tep_last` | 传送枪使用快照 | load / join / clear_player | skill/enderman/portal_use |
| `kitpvp.tep_cd` | 传送枪装填（30 = 1.5 秒） | kit/tainted_enderman、portal_place（30） | tick 递减、portal_use |
| `kitpvp.tep_life` | 传送门寿命（挂 marker：400 = 20 秒） | skill/enderman/portal_place | skill/enderman/portal_tick |
| `kitpvp.soul_ep_used` | `minecraft.used:minecraft.endermite_spawn_egg`（末影人魂石） | load | tick → skill/soul/use_ep |
| `kitpvp.soul_mars_used` | `minecraft.used:minecraft.ravager_spawn_egg`（劫掠兽蛋；本服只有火星魂石发它） | load | tick → skill/soul/use_mars |
| `kitpvp.mars_domain_used` | `minecraft.used:minecraft.vex_spawn_egg`（与幽灵魂石 / 里·驯兽师怨灵共用，靠载体 tag `kitpvp.mars_token` 分流） | load | tick/slow2 → skill/mars/dispatch（→ domain_cast） |
| `kitpvp.mars_domain_last` | 地鸣快照 | load / join / clear_player | skill/mars/dispatch |
| `kitpvp.mars_curse` | 火星诅咒剑在目标身上累积的层数（5 层触发整套诅咒） | join / clear_player / skill/curse | skill/mars/curse_hit |
| `kitpvp.tf_rise_used` | `minecraft.used:minecraft.mooshroom_spawn_egg`（与炸弹兵 5 种令牌共用，靠生成生物名字分流） | load | tick → skill/tainted_farmer/rise_dispatch |
| `kitpvp.tf_rally_used` | `minecraft.used:minecraft.husk_spawn_egg`（与僵尸魂石共用，靠生成生物名字分流） | load | tick → skill/tainted_farmer/rally_dispatch |
| `kitpvp.soul_farm_used` | `minecraft.used:minecraft.zombie_villager_spawn_egg`（僵尸村民蛋；本服只有农夫魂石发它） | load | tick → skill/soul/use_farm |
| `kitpvp.soul_ep_last` | 末影人魂石快照 | load / join / clear_player | skill/soul/use_ep |
| `kitpvp.soul_ep_timer` | 魂石传送枪剩余刻数（400 = 20 秒） | skill/soul/use_ep | tick 递减、归零走 soul_ep_expire |
| `kitpvp.soul_mars_last` | 火星魂石快照 | load / join / clear_player | skill/soul/use_mars |
| `kitpvp.soul_mars_timer` | 火星魂石倒计时（400 = 20 秒） | load（0）/ join（0）/ clear_player（0）/ use_mars（400） | tick → skill/soul/mars_tick（巨人死了也提前收场） |
| `kitpvp.soul_farm_last` | 农夫魂石快照 | load / join / clear_player | skill/soul/use_farm |
| `kitpvp.tf_rise_last` | 里·农夫起义快照 | load / join / clear_player | skill/tainted_farmer/rise_dispatch |
| `kitpvp.tf_rally_last` | 里·农夫召集快照 | load / join / clear_player | skill/tainted_farmer/rally_dispatch |
| `kitpvp.tfid` | 里·农夫的农民队槽编号（1..6） | load / join / clear_player；game/start_impl（0） | skill/tainted_farmer/team_slot |
| `kitpvp.trap_worm` | 蠹虫陷阱召唤的「陷阱虫」（25 血银鱼，常驻力量 I / 速度 I） | skill/zhanshishi/trigger_worm、summon/trap_worm | game/reset（reset_entities 兜底） | ❌ 挂实体上 |
| `kitpvp.trap_boom_mob` | 爆炸陷阱召唤的引燃苦力怕 | skill/zhanshishi/trigger_boom | game/reset | ❌ 挂实体上 |
| `kitpvp.cizhi_token` | 辞令令牌载体（sniffer，NoAI/隐形，用完即清） | skill/zhuzhiwu/give_token | skill/zhuzhiwu/cizhi_cast、game/reset | ❌ 挂实体上 |
| `kitpvp.cz_buff` | 玩家处于辞令状态（每刻重挂修饰符） | skill/zhuzhiwu/cizhi_cast | skill/zhuzhiwu/buff_tick、clear_player | ✅ |
| `kitpvp.cz_self` | 烛之武被动结算期间的临时「自己」标记 | skill/zhuzhiwu/pull | skill/zhuzhiwu/pull（同刻摘掉） | ❌ 同刻自清 |
| `kitpvp.cz_target` | 烛之武被动选中的被传送实体 | skill/zhuzhiwu/pull | skill/zhuzhiwu/pull（同刻摘掉） | ❌ 同刻自清 |
| `kitpvp.tf_owner` | 起义军（领袖 / 石锄 / 木锄农民）归属的队槽编号（挂实体） | skill/tainted_farmer/rise_summon、wave_stone、wave_wood | util/team_join |
| `kitpvp.tep_cd_s` | 魂石传送枪装填（4 = 0.2 秒） | skill/soul/use_ep、portal_place | tick 递减、soul_use |
| `kitpvp.tep_ready` | 穿门后的免疫刻数（玩家 10 = 0.5 秒；实体 20 = 1 秒） | skill/enderman/arrive、ent_through_a/b | tick 递减 |
| `kitpvp.tep_pid` | 玩家的传送门配对号（1..64） | player/join（首次登录分配） | skill/enderman/enter_a/b 比对 |
| `kitpvp.tep_owner` | 门的配对号（挂 marker） | skill/enderman/portal_place | skill/enderman/enter_a/b |
| `kitpvp.skater_call` | 滑冰者唤起野味的剩余次数（2 次滑行一次） | summon/earth_skater（2） | skill/earth/skater_skate / skater_call |
| `kitpvp.etid` | 地球召唤物的队槽编号（1..6） | game/start_impl（置 0）；skill/earth/link（按当前占用选槽，重载后保留） | skill/earth/link、game/start_impl |
| `kitpvp.pluto_parrot` | 冥王星的鹦鹉分身（无 AI、30 血、每刻 tp 到本体头顶 ~ ~1.85 ~；死了本体跟着死） | summon/pluto_parrot | skill/pluto/*、game/reset | ❌ 挂实体上 |
| `kitpvp.pluto_parrot_new` | 刚召唤、还没写归属号的鹦鹉 | summon/pluto_parrot | skill/pluto/spawn（同刻移除） | ❌ 同刻自清 |
| `kitpvp.earth_owner` | 地球召唤物的归属编号（= 主人的 `etid`；草丛靠它区分主人与敌人） | skill/earth/link（认领时写入） | skill/earth/grass_probe、game/reset（随实体消失） |
| `kitpvp.earth_grass_arm` | 可疑草丛落地后的迟钝计时（挂实体：40 → 0 才允许被踩爆） | summon/earth_grass（40） | tick 递减、`@e[tag=kitpvp.earth_grass]` |
| `kitpvp.farm_last` | 农夫耕地快照 | load / join / clear_player | tick → skill/farmer/cultivate |
| `kitpvp.plant_last` | 农夫播种快照 | load / join / clear_player | tick → skill/farmer/harvest |
| `kitpvp.bread_last` | 农夫吃面包快照 | load / join / clear_player | tick → skill/farmer/eat_bread |

> `kitpvp.molten_core` 标签与 `kitpvp.molten_core_timer` 已删除：熔火核心从"30 秒内持续刷新附近炮台"
> 改成"**施放瞬间变一次**"，形态时长由每只炮台自己的 `kitpvp.turret_molten_timer` 管，
> `core_expire` / `core_refresh` 也随之删除（后者改名 `core_apply`，只在施放瞬间调用一次）。

### 2.2 统计类型

一律在 `load.mcfunction` 里统一创建。触发物是原版物品，靠 `used > last` 检测"真正使用过一次"。

| 名称 | 类型 | 用途 | 初始化于 | 消费者 |
|---|---|---|---|---|
| `kitpvp.tank_used` | `minecraft.used:minecraft.iron_golem_spawn_egg` | 坦克令牌 / 坦克魂石共用 | load | tick → skill/tank/dispatch |
| `kitpvp.assassin_used` | `minecraft.used:minecraft.enderman_spawn_egg` | 刺客令牌 / 刺客魂石共用 | load | tick → skill/assassin/dispatch |
| `kitpvp.fisher_used` | `minecraft.used:minecraft.drowned_spawn_egg` | 渔夫寻戟令牌 | load | tick → fisher_cast |
| `kitpvp.ready_used` | `minecraft.used:minecraft.carrot_on_a_stick` | 大厅准备钓竿 | load | tick → lobby/ready_toggle |
| `kitpvp.arsonist_used` | `minecraft.used:minecraft.splash_potion` | 燃烧瓶投掷（粗筛） | load | tick → arsonist_cast |
| `kitpvp.ender_used` | `minecraft.used:minecraft.ender_pearl` | 末影珍珠投掷（粗筛） | load | tick → enderman_cast |
| `kitpvp.soul_warrior_used` | `minecraft.used:minecraft.blaze_spawn_egg` | 战士魂石（与里·弓箭手熔火核心令牌共用同种蛋，靠 `dispatch_warrior` 按生成生物名字分流） | load | tick → skill/soul/dispatch_warrior |
| `kitpvp.soul_archer_used` | `minecraft.used:minecraft.skeleton_spawn_egg` | 弓箭手魂石 | load | tick → skill/soul/use_archer |
| `kitpvp.soul_ghost_used` | `minecraft.used:minecraft.vex_spawn_egg` | 幽灵魂石 | load | tick → skill/soul/use_ghost |
| `kitpvp.soul_pirate_used` | `minecraft.used:minecraft.pillager_spawn_egg` | 海盗魂石 | load | tick → skill/soul/use_pirate |
| `kitpvp.soul_fisher_used` | `minecraft.used:minecraft.cod_spawn_egg` | 渔夫魂石（鳕鱼蛋在本服只有这一处发，是唯一来源） | load | tick → skill/soul/use_fisher |
| `kitpvp.soul_zombie_used` | `minecraft.used:minecraft.husk_spawn_egg` | 僵尸魂石（尸壳蛋唯一来源） | load | tick → skill/soul/use_zombie |
| `kitpvp.soul_slime_used` | `minecraft.used:minecraft.slime_spawn_egg` | 史莱姆魂石（史莱姆蛋在本服只有这一处发，是唯一来源） | load | tick → skill/soul/use_slime |
| `kitpvp.bomb_used` | `minecraft.used:minecraft.mooshroom_spawn_egg` | 炸弹兵 / 里·炸弹兵的五种令牌共用（蘑菇牛蛋本服唯一来源；按载体 tag 分流） | load | tick → skill/bomber/dispatch、skill/tainted_bomber/dispatch |
| `kitpvp.soul_earth_used` | `minecraft.used:minecraft.villager_spawn_egg` | 地球魂石（村民蛋唯一来源） | load | tick → skill/soul/use_earth |
| `kitpvp.soul_li_used` | `minecraft.used:minecraft.pig_spawn_egg` | 李朱俊泽魂石（与李朱俊泽自己的蛋共用，靠名字分流） | load | tick → skill/soul/use_li |
| `kitpvp.tainted_turret_used` | `minecraft.used:minecraft.stray_spawn_egg` | 里·弓箭手炮台令牌 | load | tick → skill/tainted_archer/turret_cast（补货在 tick，上限 3） |
| `kitpvp.tainted_core_used` | `minecraft.used:minecraft.blaze_spawn_egg` | 里·弓箭手熔火核心（与战士魂石共用同种蛋，靠 `dispatch` 按生成生物名字分流） | load | tick → skill/tainted_archer/dispatch（补货在 tick，上限 1） |
| `kitpvp.werewolf_used` | `minecraft.used:minecraft.wolf_spawn_egg` | 狼人嗅闻令牌（狼刷怪蛋本服唯一来源） | load | tick → skill/werewolf/cast |
| `kitpvp.tamer_used` | `minecraft.used:minecraft.wolf_spawn_egg` | 驯兽师狼蛋（与狼人共用同种蛋，靠 `kit` 分闸门 + 生成生物的 `EntityTag` 分流） | load | tick → skill/tamer/cast |
| `kitpvp.tainted_fisher_blue_used` | `minecraft.used:minecraft.glow_squid_spawn_egg` | 里·渔夫「苍」令牌 | load | tick → skill/tainted_fisher/blue_cast；发回见 `kitpvp.tainted_fisher_handout` |
| `kitpvp.tainted_fisher_domain_used` | `minecraft.used:minecraft.squid_spawn_egg` | 里·渔夫「领域展开」令牌 | load | tick → skill/tainted_fisher/domain_cast；发回同上 |
| `kitpvp.sun_flare_used` | `minecraft.used:minecraft.bee_spawn_egg` | 太阳「太阳耀斑」令牌（蜜蜂蛋本服唯一来源） | load | tick → skill/sun/flare_cast；补货见 skill/sun/refill_flare |
| `kitpvp.sun_spot_used` | `minecraft.used:minecraft.bat_spawn_egg` | 太阳「太阳黑子」令牌（蝙蝠蛋本服唯一来源） | load | tick → skill/sun/spot_cast；补货见 skill/sun/refill_spot |
| `kitpvp.alchemist_used` | `minecraft.used:minecraft.splash_potion` | 药剂师喷溅药剂投掷（与纵火狂共用同种物品，纯粹粗筛） | load | tick → skill/alchemist/cast（用 `hold_pa_prev` + `pa_type_prev` 分流） |
| `kitpvp.alchemist_drink_used` | `minecraft.used:minecraft.potion` | 药剂师秘药饮用（全服所有饮用型药水共用，粗筛） | load | tick → skill/alchemist/elixir_cast（用 `hold_pa_drink_prev` + `pa_drink_type_prev` 分流） |
| `kitpvp.ttamer_zombie_used` | `minecraft.used:minecraft.zombie_spawn_egg` | 里·驯兽师僵尸蛋 | load | tick → cast1 → spawn_zombie（用蛋的 `EntityTag` 分流） |
| `kitpvp.ttamer_skeleton_used` | `minecraft.used:minecraft.skeleton_spawn_egg` | 骷髅蛋（与弓箭手魂石共用统计） | load | tick → cast1 → spawn_skeleton |
| `kitpvp.ttamer_creeper_used` | `minecraft.used:minecraft.creeper_spawn_egg` | 苦力怕蛋 | load | tick → cast1 → spawn_creeper |
| `kitpvp.ttamer_vindicator_used` | `minecraft.used:minecraft.vindicator_spawn_egg` | 卫道士蛋 | load | tick → cast2 → spawn_vindicator |
| `kitpvp.ttamer_witch_used` | `minecraft.used:minecraft.witch_spawn_egg` | 女巫蛋 | load | tick → cast2 → spawn_witch |
| `kitpvp.ttamer_vex_used` | `minecraft.used:minecraft.vex_spawn_egg` | 恼鬼蛋（与幽灵魂石共用统计） | load | tick → cast2 → spawn_vex |
| `kitpvp.ttamer_blaze_used` | `minecraft.used:minecraft.blaze_spawn_egg` | 烈焰人蛋（与战士魂石 / 熔火核心共用统计） | load | tick → cast2 → spawn_blaze |
| `kitpvp.venus_chill_used` | `minecraft.used:minecraft.polar_bear_spawn_egg` | 金星制冷模块令牌（北极熊蛋本服唯一来源） | load | tick → skill/venus/chill_cast |
| `kitpvp.venus_arm_used` | `minecraft.used:minecraft.evoker_spawn_egg` | 金星武装模块令牌（唤魔者蛋本服唯一来源） | load | tick → skill/venus/arm_cast |
| `kitpvp.venus_bomb_used` | `minecraft.used:minecraft.silverfish_spawn_egg` | 金星自爆模块令牌（蠹虫蛋本服唯一来源） | load | tick → skill/venus/bomb_cast |
| `kitpvp.civil_used` | `minecraft.used:minecraft.splash_potion` | 文明小子口水（与纵火狂 / 药剂师共用统计，粗筛） | load | tick → skill/civil/cast（用 `hold_cb_prev` 分流） |
| `kitpvp.civil_demon_used` | `minecraft.used:minecraft.strider_spawn_egg` | 文明小子恶魔形态令牌（炽足兽蛋本服唯一来源） | load | tick → skill/civil/demon_cast |
| `kitpvp.li_pig_used` | `minecraft.used:minecraft.pig_spawn_egg` | 李朱俊泽 iLsacuL 召唤蛋（猪蛋本服唯一来源） | load | tick → skill/li_zhujunze/cast |
| `kitpvp.earth_used` | `minecraft.used:minecraft.goat_spawn_egg` | 地球召唤生灵（山羊蛋本服唯一来源） | load | tick → skill/earth/cast |
| `kitpvp.farm_used` | `minecraft.used:minecraft.iron_hoe` | 农夫耕地 / 平A 命中（两种用法都计入，空挥不计） | load | tick → skill/farmer/cultivate |
| `kitpvp.plant_used` | `minecraft.used:minecraft.wheat_seeds` | 农夫播种（麦种唯一来源是农夫的被动） | load | tick → skill/farmer/harvest |
| `kitpvp.bread_used` | `minecraft.used:minecraft.bread` | 农夫吃面包（面包靠工作台自己合） | load | tick → skill/farmer/eat_bread |

> 曾经的 `kitpvp.gapple_used`（战士补给）已随该技能一并删除，`load` 不再创建。
> 里职业统一改名（`taint_*` → `tainted_*`）后，旧名 `kitpvp.taint_turret_used` / `taint_turret_last` /
> `taint_core_used` / `taint_core_last` 作废；`load` 里保留四行 `remove` 清掉老世界里的残留空目标。

### 2.3 deathCount 类型

| 名称 | 用途 | 初始化于 | 消费者 |
|---|---|---|---|
| `kitpvp.death_detect` | 原版死亡计数器（deathCount） | load、clear_player | tick：`death_detect > death_seen` 时转 death_dispatch |

### 2.4 假玩家

| 名称 | 用途 |
|---|---|
| `#global` | 全局数据（`kitpvp.map` / `kitpvp.timer`） |
| `#state` | 游戏状态机（0=待机 1=进行中 2=结算中） |
| `#survivors` | 幸存者计数（check_winner） |
| `#debug` | debug 模式开关（1=自动判定胜利关闭；菜单入口 `debug/on`） |
| `#notch` | debug 的 Notch 模式开关（0/1 交替，`%2` 翻转） |
| `#soul_count` | 魂石种类数（当前 18） |
| `#steam` | 玩家当前所在的队槽编号（1..6 幽灵 / 7..12 炮台 / 13..18 里·驯兽师 / 19..24 地球 / 25..30 炸弹兵 / 31..36 里·农夫 / 0 = 不在任何队；`util/team_index` 写入，`util/team_join` 消费） |
| `#li_soul` | **已停用**（2026-11-10 魂石改成常驻种子、没有时限；load 仍置 -1 只为清残留） |
| `#steam` | 地球魂石识别队伍用的临时编号（skill/soul/earth_team_id：0=不在任何队，写完立刻落在 1..24） |
| `#ghost_tid` | 幽灵队槽分配游标 |
| `#ghost_need_new` | 本次是否需要新队槽 |
| `#lobby` | 大厅物品兜底补发的 60 刻节流计数器（tick） |
| `#unready` | 大厅"未准备人数"计数（lobby/ready_check，用于"只差 1 人"提醒） |
| `#cur` | 地图出生点随机游标（map/*/distribute） |
| `#join_count` | 开局人数校验计数（game/start） |
| `#pool_size` | 随机池大小（kit/random 全职业 39 / kit/random_classic 表池 16 / kit/random_tainted 里池 11 / kit/random_astral 星象池 7、map/random） |
| `#noise_count` | 太阳干扰文案池条数（skill/sun/noise_pick，当前 128 = 上限；末尾 128 行分派与它一一对应） |
| `#noise_step` | 太阳干扰的刷新间隔（刻；skill/sun/flare_tick，当前 10 = 每 0.5 秒一帧） |
| `#ttid` | 炮台队槽分配游标（kit/tainted_archer） |
| `#turret_seq` | 炮台召唤序号计数器（skill/tainted_archer/turret_fire） |
| `#tcnt` / `#tmin` | 炮台数量 / 最早序号（turret_fire 判定存在上限时用） |
| `#ttamer` | 里·驯兽师召唤物的队槽分配游标（skill/tainted_tamer/link） |
| `#vtid` | 金星舔狗队槽分配游标（kit/venus） |
| `#vdog` | 本次是否找到了自己的舔狗（skill/venus/*，1=有） |
| `#litimer` | 李朱俊泽 / 地球 iLsacuL 的循环计时（0..239，12 秒一圈；两者都不存在时归零） |
| `#li_active` | 本刻是否运行 iLsacuL 循环（局内存在李朱俊泽或地球 iLsacuL 时为 1） |
| `#licount` | 李朱俊泽数 iLsacuL 用的临时计数（cycle_end / apocalypse） |
| `#liapoc` | iLsacuL 的"每刻半径 8 自爆"开关（1=进行中） |
| `#eslot` | 地球召唤物选槽临时值（skill/earth/link：1..6 里第一个空槽） |
| `#pl` / `#same` | 挑槽前查重：`#pl` = 自己的槽位号，`#same` = 持有该槽位的玩家数（≥2 就重选） |
| `#buffcnt` | 熔火核心本次强化的炮台数（core_apply 计数、core_fire 播报） |
| `#tfound` | 炮台令牌的流浪者是否找到（turret_fire 决定落点） |
| `#rng` | 地图随机数（map/random） |
| `#lipurge` | iLsacuL 复核轮次（game/li_purge_verify：0 起，6 轮放弃并告警；清干净即归零） |
| `#wolfsweep` | 结算后补扫驯兽师狼的轮次（game/wolf_sweep：0 起，扫 4 轮后归零） |
| `#ptid` | 冥王星鹦鹉编号的分配游标（只增不复用；kit/pluto） |
| `#pparrot` | 本刻是否找到了自己的鹦鹉（0/1；skill/pluto/check 与 respawn） |
| `#hacker_count` / `#hacker_prev` | 本刻 / 上一刻场上还剩几只地球黑客（tick 每刻重算；`count < prev` 即视为刚死了一只并播报） |
| `#gowner` | 草丛贴身判定时的临时值：当前玩家（`@a` 循环里的那一位）的 `etid`（skill/earth/grass_probe） |
| `#soul_mars_wild_timer` | 火星魂石巨人的生灵刷新计时（24；skill/soul/mars_wild_tick，game/reset 归零） |
| `#soul_mars_wild` | 火星魂石刷出的生灵数量（计数用，skill/soul/mars_wild_spawn） |
| `#tfid` | 里·农夫农民队槽的分配游标（game/start_impl 归零，skill/tainted_farmer/team_slot） |
| `#tf_wave` | 里·农夫：领袖召石锄农民的 12 秒计时（240；rise_summon 起、wave_stone 重置） |
| `#tf_wave2` | 里·农夫：石锄农民召木锄农民的 12 秒计时（240，与 #tf_wave 错开 120 刻） |
| `#tf_stone` / `#tf_wood` | 当前石锄 / 木锄农民数量（wave_stone / wave_wood 数上限用） |
| `#tf_own` | 本次召唤要写的归属槽位（从领袖 / 石锄农民身上读出来，再写到新召唤物） |

---

## 三、Tag

| tag | 用途 | add 于 | remove 于 | clear_player 清 |
|---|---|---|---|---|
| `kitpvp.joined` | 已登记接入 | player/join | — | ❌ 刻意不清 |
| `kitpvp.in_lobby` | 在大厅 | lobby/enter | lobby/exit | ❌ 刻意不清 |
| `kitpvp.on_pad` | 站在职业选择压力板上 | lobby/pad_enter | lobby/pad（离开板时） | ❌ 位置状态，刻意不清 |
| `kitpvp.selected` | 已选职业 | kit/*、debug/play（debug 模式） | clear_player、player/eliminate、debug/build | ✅ |
| `kitpvp.invincible` | 无敌中 | player/invincible | player/end_invincible、player/eliminate、clear_player | ✅ |
| `kitpvp.sudden_death` | 突然死亡激活 | game/sudden_death_start | game/start_impl、clear_player | ✅ |
| `kitpvp.spectator` | 旁观者 | player/eliminate | clear_player、game/start_impl、debug/* | ✅ |
| `kitpvp.respawn_pending` | 待重生处理 | player/on_death | player/after_death、player/eliminate、clear_player | ✅ |
| `kitpvp.death_immune` | 死亡不计——**预留**：`player/on_death` 已支持，但**暂无职业 add 它**（机制当前不可用） | 职业专属 | clear_player | ✅ |
| `kitpvp.keep_inventory` | 保留背包——**预留**：`gamerule keepInventory true` 已全局生效，故无代码读它 | 职业专属 | clear_player | ✅ |
| `kitpvp.shield_held` | 坦克持盾中 | skill/tank/fire | skill/tank/expire、player/eliminate、clear_player | ✅ |
| `kitpvp.assassin_hidden` | 刺客隐匿中 | skill/assassin/fire | skill/assassin/unhide、player/after_death、player/eliminate、clear_player | ✅ |
| `kitpvp.pirate_reload_cd` | 海盗换弹冷却待就绪提示 | skill/pirate/reload | tick（冷却归零）、player/eliminate、clear_player、load | ✅ |
| `kitpvp.tank_handout` | 举盾令牌的发回窗口（skill/tank/cast 打开：令牌真的被用掉；skill/tank/handout 发完关窗） | skill/tank/cast | skill/tank/handout、clear_player | ✅ |
| `kitpvp.assassin_handout` | 隐匿令牌的发回窗口（同上） | skill/assassin/cast | skill/assassin/handout、clear_player | ✅ |
| `kitpvp.fisher_handout` | 寻戟令牌的发回窗口（同上；"三叉戟尚未离场"那类白按也靠它把令牌发回） | skill/fisher/cast | skill/fisher/handout、clear_player | ✅ |
| `kitpvp.ready` | 已准备 | lobby/ready_on | lobby/ready_off、lobby/enter、lobby/exit、clear_player | ✅ |
| `kitpvp.ready_pending` | 准备待处理（防同刻双触发） | lobby/ready_toggle | lobby/ready_toggle、lobby/enter、lobby/exit、clear_player | ✅ |
| `kitpvp.spawn_assigned` | 已分配出生点 | map/*/spawn_N | map/distribute、map/*/distribute | ❌ 位置状态，刻意不清 |
| `kitpvp.spawn_anchor` | 出生点锚点（隐形 marker，另有 `.1`..`.9` 按编号分的版本身，重生兜底用） | map/*/spawn_N | map/distribute、game/reset | ❌ 挂实体上 |
| `kitpvp.hold_fb` | 当前手持燃烧瓶 | tick（每刻重建） | tick（每刻重建） | ❌ 每刻重建 |
| `kitpvp.hold_fb_prev` | 上一刻手持燃烧瓶 | tick（每刻重建） | tick（每刻重建） | ❌ 每刻重建 |
| `kitpvp.hold_ep` | 当前手持末影珍珠 | tick（每刻重建） | tick（每刻重建） | ❌ 每刻重建 |
| `kitpvp.hold_ep_prev` | 上一刻手持末影珍珠 | tick（每刻重建） | tick（每刻重建） | ❌ 每刻重建 |
| `kitpvp.hold_pa` | 当前手持药剂师的喷溅药剂（四种共用 `KitAlchemistPotion`） | tick（每刻重建，只对 kit=12） | tick（每刻重建）、clear_player、load | ✅ |
| `kitpvp.hold_pa_prev` | 上一刻手持药剂师的喷溅药剂 | tick（每刻重建） | tick（每刻重建）、clear_player、load | ✅ |
| `kitpvp.hold_pa_drink` | 当前手持药剂师的秘药（四种共用 `KitAlchemistElixir`） | tick（每刻重建，只对 kit=12） | tick（每刻重建）、clear_player、load | ✅ |
| `kitpvp.hold_pa_drink_prev` | 上一刻手持药剂师的秘药 | tick（每刻重建） | tick（每刻重建）、clear_player、load | ✅ |
| `kitpvp.alchemist_elixir_used` | 药剂师本命秘药已用掉（每条命一次；死亡重生由 player/after_death 清） | skill/alchemist/elixir_fire_* | player/after_death、kit/alchemist、clear_player、load | ✅ |
| `kitpvp.tt_minion` | 里·驯兽师的召唤物（玩家不可见，用于 game/reset 清理） | summon/tainted_tamer_*（`Tags`） | —（随实体清场） | ❌ 挂实体上 |
| `kitpvp.tt_minion_new` | 刚召唤出来、还没进队的召唤物 | summon/tainted_tamer_*（`Tags`） | skill/tainted_tamer/link（同刻移除） | ❌ 同刻自清 |
| `kitpvp.tt_spawn` | 召唤蛋刷出的基础生物（用来定位落点，随后立即清掉） | 七枚蛋的 `EntityTag.Tags` | spawn_* 的 kill、game/reset | ❌ 挂实体上 |
| `kitpvp.tt_spawn_zombie` / `_skeleton` / `_creeper` / `_vindicator` / `_witch` / `_vex` / `_blaze` | 按蛋类型分的定位标记（与魂石共用同种蛋时用来分流） | 七枚蛋的 `EntityTag.Tags` | spawn_* 的 kill | ❌ 挂实体上 |
| `kitpvp.venus_dog` | 金星的舔狗（狼；`Owner` 为召唤者，故自动驯服） | summon/venus_dog | game/reset | ❌ 挂实体上 |
| `kitpvp.venus_dog_new` | 刚召唤、还没补 Owner / 归属的舔狗 | summon/venus_dog | skill/venus/summon_dog（同刻移除） | ❌ 同刻自清 |
| `kitpvp.venus_chill` | 制冷模块生效中的舔狗 | skill/venus/chill_fire | skill/venus/chill_expire、game/reset | ❌ 挂实体上 |
| `kitpvp.venus_chilled` | 本刻正处于冷气里的玩家（tick 每刻重建，用来决定冷度 +1 还是 -1） | skill/venus/chill_mark | tick（每刻重建） | ❌ 每刻重建 |
| `kitpvp.venus_armed` | 武装模块生效中的舔狗 | skill/venus/arm_fire | skill/venus/arm_expire、game/reset | ❌ 挂实体上 |
| `kitpvp.venus_dog_dead` | 舔狗已死、正在等复活的金星玩家 | skill/venus/bomb_fire、dog_alive_check | skill/venus/dog_respawn、clear_player | ✅ |
| `kitpvp.venus_token` | 三枚模块蛋刷出来的基础生物（定位用，随后清掉） | 三枚蛋的 `EntityTag.Tags` | cast 的 kill、tick 兜底、game/reset | ❌ 挂实体上 |
| `kitpvp.venus_bomb_creeper` | 自爆模块生成的苦力怕 | summon/venus_bomb | 爆炸自毁、game/reset | ❌ 挂实体上 |
| `kitpvp.hold_cb` | 当前手持文明小子的口水（普通 / 恶魔共用） | tick（每刻重建，只对 kit=87） | tick（每刻重建）、clear_player | ✅ |
| `kitpvp.hold_cb_prev` | 上一刻手持文明小子的口水 | tick（每刻重建） | tick（每刻重建）、clear_player | ✅ |
| `kitpvp.civil_demon` | 恶魔形态进行中 | skill/civil/demon_start | skill/civil/demon_end、clear_player、kit/civil | ✅ |
| `kitpvp.civil_spit_burst` | 这瓶普通口水已经结算过落地效果 | skill/civil/spit_burst | —（口水落地即消失） | ❌ 挂实体上 |
| `kitpvp.civil_demon_burst` | 这瓶恶魔口水已经结算过落地效果 | skill/civil/demon_spit_burst | —（同上） | ❌ 挂实体上 |
| `kitpvp.civil_token` | 恶魔形态令牌刷出来的基础生物（炽足兽） | 令牌的 `EntityTag.Tags` | demon_cast、tick 兜底、game/reset | ❌ 挂实体上 |
| `kitpvp.li_pig` | 李朱俊泽 / 地球的 iLsacuL（普通 20 血 / 复制体 200 血都参与循环） | 召唤蛋 `EntityTag.Tags`、summon/earth_ilsacul、summon/li_pig_copy | game/reset（`kill @e[tag=kitpvp.li_pig]`） | ❌ 挂实体上 |
| `kitpvp.earth_ilsacul` | 地球召唤的 iLsacuL（用于启动共享循环并让复制体保留地球队伍） | summon/earth_ilsacul、summon/li_pig_copy | game/reset（`kill @e[tag=kitpvp.earth_minion]`） | ❌ 挂实体上 |
| `kitpvp.li_bomb` | iLsacuL 自爆用的苦力怕 | boom5 / boom8 | 爆炸自毁、game/reset | ❌ 挂实体上 |
| `kitpvp.earth_minion` | 地球召唤的全部生灵（含坐骑以外的本体） | summon/earth_* | game/reset | ❌ 挂实体上 |
| `kitpvp.earth_minion_new` | 刚召唤、还没进队的生灵 | summon/earth_* | skill/earth/link（同刻移除） | ❌ 同刻自清 |
| `kitpvp.earth_sheep` | Sheepass（每 10 秒反胃） | summon/earth_sheep | game/reset | ❌ 挂实体上 |
| `kitpvp.earth_disruptor` | 扰动者（每 3 秒 flare_hit） | summon/earth_disruptor | game/reset | ❌ 挂实体上 |
| `kitpvp.earth_levitate` | 会漂浮并自动离场的召唤物 | summon/earth_ascend、earth_ascend2 | levitate_end、game/reset | ❌ 挂实体上 |
| `kitpvp.earth_lifted` | 已进入漂浮阶段的召唤物 | skill/earth/levitate_start | levitate_end、game/reset | ❌ 挂实体上 |
| `kitpvp.earth_tracker` | 跟踪炸弹的小僵尸 | summon/earth_tracker_bomb | tick（120 刻后 kill）、game/reset | ❌ 挂实体上 |
| `kitpvp.earth_bomb` | 地球的爆炸苦力怕（大炸弹 / 跟踪炸弹的坐骑） | summon/earth_big_bomb、earth_tracker_bomb | 爆炸自毁、game/reset | ❌ 挂实体上 |
| `kitpvp.earth_mount` | 渔夫的坐骑（海豚 / 海龟） | summon/earth_fisher1、earth_fisher2 | game/reset | ❌ 挂实体上 |
| `kitpvp.earth_farmer` | 农民召唤物（专属标记，供以后扩展） | summon/earth_farmer | game/reset | ❌ 挂实体上 |
| `kitpvp.earth_token` | 召唤蛋刷出的山羊（载体，随后清掉） | 蛋的 `EntityTag.Tags` | skill/earth/cast、tick 兜底、game/reset | ❌ 挂实体上 |
| `kitpvp.earth_boat1` / `kitpvp.earth_boat2` | 两位船夫的船（竹筏 / 樱花木船，`Type` 字段区分；船是坐骑） | summon/earth_boatman_wet、earth_boatman_dry | tick（2 格内找不到就算船没了）、game/reset | ❌ 挂实体上 |
| `kitpvp.earth_boatman1` / `kitpvp.earth_boatman2` | 两位船夫的本体（僵尸，坐在船上） | summon/earth_boatman_wet、earth_boatman_dry | tick（抗性 V 的维持 / 力量 II 的一次性触发） | ❌ 挂实体上 |
| `kitpvp.earth_power_armed` / `kitpvp.earth_powered` | 干海绵船夫的力量 II 一次性触发状态（armed=本刻要发，powered=已发过） | tick | tick（armed 当刻发完即转 powered） | ❌ 同刻自清 |
| `kitpvp.earth_grass` | 可疑草丛（隐身、移速 -30%，被打到或玩家贴近就爆开） | summon/earth_grass | tick（`earth_grass_arm` 递减 + 血量判定）、earth_grass_pop、game/reset | ❌ 挂实体上 |
| `kitpvp.earth_grass_new` | 草丛爆出的两只小僵尸（尚未进队） | summon/earth_grass_pop | earth_grass_pop（同刻移入队伍后清掉） | ❌ 同刻自清 |
| `kitpvp.earth_grass_popped` | 已判定爆开的草丛（防重入：kill 的移除在下一刻） | summon/earth_grass_pop | game/reset（随实体一起消失） | ❌ 挂实体上 |
| `kitpvp.earth_hacker` | 黑客（死掉时全场播报，靠"上一刻还在、这一刻没了"判定） | summon/earth_hacker | tick → summon/earth_hacker_death、game/reset | ❌ 挂实体上 |
| `kitpvp.earth_retainer` / `kitpvp.earth_retainer_mount` | 随从（小僵尸）与它的坐骑（悦灵） | summon/earth_retainer | game/reset | ❌ 挂实体上 |
| `kitpvp.earth_qin` / `kitpvp.earth_qin_bear` | 秦始皇（10 血僵尸，持金剑）与它的坐骑（15 血北极熊） | summon/earth_qin | game/reset | ❌ 挂实体上 |
| `kitpvp.pirate_charged` | 手持的手炮已装填 | tick（每刻重建） | tick（每刻重建） | ❌ 每刻重建 |
| `kitpvp.pirate_charged_prev` | 上一刻手持的手炮已装填 | tick（每刻重建） | tick（每刻重建） | ❌ 每刻重建 |
| `kitpvp.soul_bow_held` | 魂石弓持有中 | skill/soul/use_archer | skill/soul/bow_expire、clear_player | ✅ |
| `kitpvp.soul_transit` | 魂石·刺客传送中转 | skill/soul/use_assassin | skill/soul/use_assassin（同刻自清） | ❌ 同刻自清 |
| `kitpvp.werewolf_sniff_self` | 嗅闻时临时标记自己，用来把自己排除在"其他玩家"之外 | skill/werewolf/fire | skill/werewolf/fire（同刻自清） | ❌ 同刻自清 |
| `kitpvp.tamer_wolf` | 狼蛋放出的那只狼（蛋的 `EntityTag`） | skill/tamer/give_egg | game/end / game/reset / map/restore（按 tag 清本体；按类型清理同时覆盖无 tag 后代） | ❌ 挂实体上 |
| `kitpvp.werewolf_token` | 嗅闻令牌刷出的那只狼（蛋的 `EntityTag`） | skill/werewolf/give_egg | skill/werewolf/cast（当场清）、game/reset | ❌ 挂实体上 |
| `kitpvp.test_dummy` | 测试用僵尸（召唤物，两种铁装） | summon/zombie_iron_helmet、summon/zombie_iron_armor | game/reset | ❌ 挂实体上 |
| `kitpvp.tainted_fisher_blue_token` | 「苍」令牌刷出的发光鱿鱼（蛋的 `EntityTag`） | skill/tainted_fisher/give_blue | skill/tainted_fisher/blue_start（当场清）、game/reset | ❌ 挂实体上 |
| `kitpvp.tainted_fisher_domain_token` | 「领域展开」令牌刷出的鱿鱼（蛋的 `EntityTag`） | skill/tainted_fisher/give_domain | skill/tainted_fisher/domain_start（当场清）、game/reset | ❌ 挂实体上 |
| `kitpvp.tainted_fisher_cang` | 「苍」前摇咏唱中 | skill/tainted_fisher/blue_start | skill/tainted_fisher/cang_release、clear_player | ✅ |
| `kitpvp.tainted_fisher_handout` | 令牌发回窗口（**只有技能真的放出去才会打开**；整把锁走完由 tick 一次性发回两个令牌，然后关窗）—— 换成"背包里没有就补"会让拖动物品 / 丢地上凭空多出一个（04 §四） | skill/tainted_fisher/cang_release、skill/tainted_fisher/domain_open | skill/tainted_fisher/handout、clear_player | ✅ |
| `kitpvp.tainted_fisher_domain` | 领域展开进行中（前摇 + 60 秒领域都在这个 tag 里） | skill/tainted_fisher/domain_start | skill/tainted_fisher/domain_end、clear_player | ✅ |
| `kitpvp.tainted_fisher_self` | 落水球时临时标记自己，用来把自己排除在"最近的一名玩家"之外 | skill/tainted_fisher/cang_release | skill/tainted_fisher/cang_release（同刻自清）、clear_player | ✅ |
| `kitpvp.in_water` | 「处于水中」（里·渔夫水中被动用；每刻重建） | skill/tainted_fisher/water_passive（每刻重建） | skill/tainted_fisher/water_passive（每刻重建）、clear_player | ✅ |
| `kitpvp.soul_ghost_active` | 幽灵魂石激活中 | skill/soul/use_ghost | skill/soul/ghost_expire、clear_player | ✅ |
| `kitpvp.soul_pirate_held` | 魂石手炮持有中 | skill/soul/use_pirate | skill/soul/pirate_expire、clear_player | ✅ |
| `kitpvp.soul_fisher_active` | 渔夫魂石生效中（20 秒） | skill/soul/use_fisher | skill/soul/fisher_expire、clear_player | ✅ |
| `kitpvp.sun_hit` | 被太阳魂石的日蚀锁定中（20 秒；标记在人身上，走出 10 格也继续吃噪音） | skill/soul/sun_mark | skill/soul/sun_hit（倒计时结束）、clear_player、game/reset | ✅ |
| `kitpvp.burger_beast` | 汉堡小子蓄力满召唤的汉堡兽（50 血、免疫击退、抗性 V、跳跃 VI、敌对所有人） | summon/burger_beast | game/reset（reset_entities 兜底） | ❌ 挂实体上 |
| `kitpvp.soul_fisher_token` | 渔夫魂石刷出的那条鳕鱼（蛋的 `EntityTag`） | skill/soul/give | skill/soul/use_fisher（当场清）、game/reset | ❌ 挂实体上 |
| `kitpvp.soul_zombie_active` | 僵尸魂石生效中（20 秒，+20 生命上限） | skill/soul/zombie_apply | skill/soul/zombie_expire、clear_player | ✅ |
| `kitpvp.soul_slime_active` | 史莱姆魂石生效中（20 秒：常驻跳跃提升 III + 速度 I + 蓄力火箭跳） | skill/soul/slime_apply | skill/soul/slime_expire、clear_player | ✅ |
| `kitpvp.rocket_jump` | 可蓄力（里·史莱姆被动 / 史莱姆魂石共用；魂石到期时 kit=31 不摘） | kit/tainted_slime → skill/tainted_slime/passive、skill/soul/slime_apply | skill/soul/slime_expire（kit≠31 才摘）、clear_player | ✅ |
| `kitpvp.rocket_full` | 满蓄力的提示音已响过（charge 停在 60 会每刻经过判定，靠它只响一次） | skill/tainted_slime/charge | skill/tainted_slime/charge（charge..59）、slime_expire、player/after_death、clear_player | ✅ |
| `kitpvp.rocket_air` | 上一刻在空中（用来认"落地后的第一刻"，好在那刻清掉蓄力效果） | skill/tainted_slime/charge（每刻重建） | skill/tainted_slime/charge（每刻重建）、clear_player | ✅ |
| `kitpvp.soul_slime_token` | 史莱姆魂石蛋刷出的那只载体史莱姆（`EntityTag`：`Size:0` 不分裂 + 本 tag；按 tag 认，不按名字） | skill/soul/give（蛋的 EntityTag） | skill/soul/use_slime（当场 kill） | ❌ 挂实体上 |
| `kitpvp.bomb_token` | 炸弹兵所有令牌载体的总标记（清场用） | skill/bomber/give_*（蛋的 EntityTag） | skill/*bomber/*_cast（当场 kill）、game/reset | ❌ 挂实体上 |
| `kitpvp.bomb_small_token` | 小炸弹令牌载体（隐形 / 静音 / 无 AI） | skill/bomber/give_small | skill/bomber/small_cast、skill/tainted_bomber/small_cast、game/reset | ❌ 挂实体上 |
| `kitpvp.bomb_big_token` | 大炸弹令牌载体 | skill/bomber/give_big | big_cast（两边各一个）、game/reset | ❌ 挂实体上 |
| `kitpvp.bomb_fake_token` | 假核弹令牌载体（只有表有） | skill/bomber/give_fake | skill/bomber/fake_cast、game/reset | ❌ 挂实体上 |
| `kitpvp.bomb_track_token` | 跟踪炸弹令牌载体 | skill/bomber/give_track | track_cast（两边各一个）、game/reset | ❌ 挂实体上 |
| `kitpvp.bomb_nuke_token` | 核弹令牌载体 | skill/bomber/give_nuke | nuke_cast（两边各一个）、game/reset | ❌ 挂实体上 |
| `kitpvp.bomb_rider` | 跟踪炸弹的隐形小僵尸骑手 | summon/bomber_track | tick 的 bomb_life、game/reset | ❌ 挂实体上 |
| `kitpvp.bomb_rider_new` | 刚召出的骑手（写完寿命后自清） | summon/bomber_track | summon/bomber_track（同刻自清） | ❌ 同刻自清 |
| `kitpvp.bomb_track_new` | 刚召出的跟踪炸弹（苦力怕 + 骑手，进队后自清） | summon/bomber_track | summon/bomber_track（同刻自清） | ❌ 同刻自清 |
| `kitpvp.soul_earth_marker` | 地球魂石的落点标记（每 10 刻召一只，4 只后自清） | skill/soul/earth_apply | skill/soul/earth_step（到点 kill）、game/reset | ❌ 挂实体上 |
| `kitpvp.soul_earth_new` | 刚落地的落点标记（用来写主人数与倒计时） | skill/soul/earth_apply | skill/soul/earth_apply（同刻自清） | ❌ 同刻自清 |
| `kitpvp.soul_li_pig` | 李朱俊泽魂石召出的"种子" iLsacuL（照常参与复制 / ≥14 计数；**不参与第 6 秒引爆、也跳过每刻自爆**，这样它能活到下一圈；2026-11-10 起不再带抗性 V） | skill/soul/li_apply | skill/soul/li_expire（20 秒后 kill）、game/reset、li_purge | ❌ 挂实体上 |
| `kitpvp.arrow_user` | 用箭职业（落地箭清理的前置） | kit/archer、kit/tainted_archer、kit/sun | clear_player | ✅ |
| `kitpvp.sun_flare` | 短波通信干扰中（太阳耀斑的中招标记，5 秒） | skill/sun/flare_hit | skill/sun/flare_end、player/eliminate、clear_player | ✅ |
| `kitpvp.sun_self` | 耀斑 / 黑子结算范围时临时标记自己，用来把自己排除在"周围玩家"之外 | skill/sun/flare_fire、skill/sun/spot_fire | 同上两处（同刻自清）、clear_player | ✅ |
| `kitpvp.sun_flare_token` | 太阳耀斑令牌刷出的那只蜜蜂（蛋的 `EntityTag`） | skill/sun/give_flare | skill/sun/flare_fire（当场清）、tick（兜底）、game/reset | ❌ 挂实体上 |
| `kitpvp.sun_spot_token` | 太阳黑子令牌刷出的那只蝙蝠（蛋的 `EntityTag`） | skill/sun/give_spot | skill/sun/spot_fire（当场清）、tick（兜底）、game/reset | ❌ 挂实体上 |
| `kitpvp.molten_core` | ~~熔火核心窗口内~~ **已删除**（改成施放瞬间变一次，见 2.1 的说明） | — | — | — |
| `kitpvp.turret` | 炮台（挂骷髅） | summon/turret | game/reset | ❌ 挂实体上 |
| `kitpvp.turret_new` | 本批新召唤的炮台 | summon/turret | skill/tainted_archer/turret_fire | ❌ 挂实体上 |
| `kitpvp.turret_molten` | 炮台熔火形态中 | skill/tainted_archer/turret_to_molten | skill/tainted_archer/turret_from_molten、core_expire | ❌ 挂实体上 |
| `kitpvp.token_turret` | 炮台令牌刷出的流浪者（落点标记） | skill/tainted_archer/give_token_turret（蛋的 `EntityTag`） | skill/tainted_archer/turret_fire、game/reset | ❌ 挂实体上 |
| `kitpvp.token_core` | 熔火核心令牌刷出的烈焰人 | skill/tainted_archer/give_token_core（蛋的 `EntityTag`） | skill/tainted_archer/core_fire、game/reset | ❌ 挂实体上 |
| `kitpvp.arsonist_burst` | 燃烧瓶落地已触发（挂药水实体） | skill/arsonist/burst | 随药水实体消失 | ❌ 挂实体上 |
| `kitpvp.arsonist_fire` | 火焰守护 marker | skill/arsonist/place_one | skill/arsonist/flame_tick | ❌ 挂实体上 |
| `kitpvp.arsonist_new` | 本批未初始化 marker | skill/arsonist/place_one | skill/arsonist/place | ❌ 挂实体上 |
| `kitpvp.ghost_minion` | 阴兵（骷髅） | summon/ghost_minion | —（**无清理**：`PersistenceRequired:1b`，到期只清效果不 kill） | ❌ 挂实体上 |
| `kitpvp.ghost_minion_new` | 本批新召唤的阴兵 | summon/ghost_minion | summon/ghost_minion_pair | ❌ 挂实体上 |
| `kitpvp.soul_mars_active` | 火星魂石生效中（20 秒；clear_player 里会顺带停掉该玩家的 rumbling 播放链） | skill/soul/use_mars | skill/soul/mars_expire、clear_player | ✅ |
| `kitpvp.soul_mars_giant` | 火星魂石的巨人（1000 血 Giant，无 AI） | skill/soul/mars_spawn | skill/soul/mars_expire、game/reset | ❌ 挂实体上 |
| `kitpvp.soul_mars_controller` | 火星魂石巨人的驾驶员（800 血僵尸，会追人） | skill/soul/mars_spawn | skill/soul/mars_expire、game/reset | ❌ 挂实体上 |
| `kitpvp.soul_mars_token` | 火星魂石蛋刷出的那只劫掠兽（载体，`NoAI` + 静音，站着不动；用完立即清，`game/reset` 再兜一行） | `skill/soul/give` 的 `EntityTag` | skill/soul/use_mars（当场 kill）、game/reset | ❌ 挂实体上 |
| `kitpvp.soul_mars_wild` | 火星魂石巨人在巨人处刷出的地球生灵（每 24 刻一只，同地鸣的 `mars_wild`） | skill/soul/mars_wild_spawn | game/reset（earth_minion 那行本来也会兜住） | ❌ 挂实体上 |
| `kitpvp.tf_leader` | 里·农夫的「农民起义领袖」（200 血，常驻力量 II / 速度 I） | summon/tainted_farmer_leader（+ `tf_new`） | game/reset | ❌ 挂实体上 |
| `kitpvp.tf_stone` | 里·农夫的「石锄农民」（20 血，每 12 秒从领袖处刷出，上限 8） | summon/tainted_farmer_stone（+ `tf_new`） | game/reset | ❌ 挂实体上 |
| `kitpvp.tf_wood` | 里·农夫的「木锄农民」（20 血，每 12 秒由随机一只石锄农民刷出，上限 12） | summon/tainted_farmer_wood（+ `tf_new`） | game/reset | ❌ 挂实体上 |
| `kitpvp.tf_new` | 刚召出、还没写 `tf_owner` / 没进队的起义军 | `summon/tainted_farmer_*` | util/team_join（同刻摘掉） | ❌ 同刻自清 |
| `kitpvp.team_new` | 刚召出、还没入队的友方生物（`util/team_join` 按它找目标并摘掉） | 阴兵 / 里·农夫三件套 / 农夫魂石领袖 | `util/team_join`（同刻摘掉） | ❌ 同刻自清 |
| `kitpvp.soul_farm_token` | 农夫魂石蛋刷出的那只僵尸村民（载体，`NoAI` 静音） | `skill/soul/give` 的 `EntityTag` | skill/soul/use_farm（当场 kill）、game/reset | ❌ 挂实体上 |
| `kitpvp.soul_farm_leader` | 农夫魂石的 20 血起义领袖（同时带 `tf_leader`，所以兵源计时与 reset 都走同一套） | `summon/soul_farm_leader`（+ `tf_new`） | game/reset（按 `tf_leader` 清） | ❌ 挂实体上 |
| `kitpvp.displayitem` | 装饰实体（盔甲架 / 物品框 / 画 / 箱子矿车） | load | — | ❌ 挂实体上 |

> tag 只用于"有/没有"的二值判断。编号、计数、冷却用计分板。
> 每刻重建的 tag（`hold_*`）与位置状态 tag（`in_lobby` / `on_pad` / `spawn_assigned`）**不写入** `load` / `clear_player`。
> 太阳的两个令牌**没有发回窗口 tag**：它们用"`cd` 走完 + 手上 / 地上都没有"的自愈判据
> （`skill/sun/refill_flare` / `refill_spot`），理由与已接受的漏洞见 04 §4.2。

---

## 四、物品 NBT 标记

| 标记 | 挂在什么物品上 | 归属 / 来源 | 给出方 | 回收方 |
|---|---|---|---|---|
| `KitBow:1b` | `minecraft:bow` | 弓箭手 | kit/archer、skill/archer/give_bow | skill/archer/return、skill/archer/steal |
| `KitTankEgg:1b` | `minecraft:iron_golem_spawn_egg` | 坦克 | skill/tank/give_egg | tick 生成物清理 |
| `KitShield:1b` | `minecraft:shield` | 坦克 | skill/tank/fire | skill/tank/expire、clear_player |
| `KitAssassinEgg:1b` | `minecraft:enderman_spawn_egg` | 刺客 | skill/assassin/give_item | tick 生成物清理 |
| `KitFireBomb:1b` | `minecraft:splash_potion` | 纵火狂 | kit/arsonist、skill/arsonist/give | skill/arsonist/burst、clear_player |
| `KitFisherEgg:1b` | `minecraft:drowned_spawn_egg` | 渔夫 | skill/fisher/give_egg | tick 生成物清理 |
| `KitFisherTrident:1b` | `minecraft:trident` | 渔夫 | kit/fisher、skill/fisher/refill | —（掷出后靠忠诚 II 回旋） |
| `KitEnderPearl:1b` | `minecraft:ender_pearl` | 末影人 | kit/enderman、skill/enderman/give | clear_player |
| `KitPirateAxe:1b` | `minecraft:diamond_axe` | 海盗 | kit/pirate | clear_player |
| `KitCrossbow:1b` | `minecraft:crossbow` | 海盗 | kit/pirate、skill/pirate/give_crossbow | skill/pirate/return、skill/pirate/steal |
| `KitPirateRocket:1b` | `minecraft:firework_rocket` | 海盗 / 海盗魂石 | kit/pirate、skill/pirate/reload、skill/soul/use_pirate（魂石给 3 发散装炮弹） | skill/pirate/reload（换弹先清后给；嵌在弩里的不受影响）、skill/soul/use_pirate（先清再给 3） |
| `KitLobbyRod:1b` | `minecraft:carrot_on_a_stick` | 大厅 | lobby/give_items | lobby/exit、ready_on/off、game/start_impl |
| `KitLobbySword:1b` | `minecraft:stone_sword` | 大厅 | lobby/give_items | lobby/exit、game/start_impl |
| `KitSoul:1b` | 各魂石刷怪蛋（共用基标记） | 魂石系统 | skill/soul/give | 一次性蛋，用后消失 |
| `KitSoulWarrior:1b` | `minecraft:blaze_spawn_egg` | 魂石·战士 | skill/soul/give | skill/soul/use_warrior |
| `KitSoulArcher:1b` | `minecraft:skeleton_spawn_egg` | 魂石·弓箭手 | skill/soul/give | skill/soul/use_archer |
| `KitSoulTank:1b` | `minecraft:iron_golem_spawn_egg` | 魂石·坦克 | skill/soul/give | skill/tank/dispatch → skill/soul/use_tank |
| `KitSoulAssassin:1b` | `minecraft:enderman_spawn_egg` | 魂石·刺客 | skill/soul/give | skill/assassin/dispatch → skill/soul/use_assassin |
| `KitSoulGhost:1b` | `minecraft:vex_spawn_egg` | 魂石·幽灵 | skill/soul/give | skill/soul/use_ghost |
| `KitSoulPirate:1b` | `minecraft:pillager_spawn_egg` | 魂石·海盗 | skill/soul/give | skill/soul/use_pirate |
| `KitSoulPirateCrossbow:1b` | `minecraft:crossbow` | 魂石·海盗（效果物：大型手炮，多重射击、未装填） | skill/soul/use_pirate | skill/soul/pirate_expire |
| `KitSoulFisher:1b` | `minecraft:cod_spawn_egg` | 魂石·渔夫 | skill/soul/give | 一次性蛋，用后消失 |
| `KitSoulZombie:1b` | `minecraft:husk_spawn_egg`（尸壳蛋在本服只有这一处发，是唯一来源） | 魂石·僵尸 | skill/soul/give | 一次性蛋，用后消失 |
| `KitSoulSlime:1b` | `minecraft:slime_spawn_egg`（蛋带 `EntityTag`：`Size:0` 最小号史莱姆（击杀不分裂）+ tag `kitpvp.soul_slime_token`；史莱姆蛋在本服只有这一处发） | 魂石·史莱姆 | skill/soul/give | 一次性蛋，用后消失 |
| `KitBombSmall:1b` | `minecraft:mooshroom_spawn_egg`（载体隐形 / 静音 / 无 AI / 无掉落） | 炸弹兵小炸弹 | skill/bomber/give_small | 使用即消耗；表 10 秒补 1（上限 3）；里不再发 |
| `KitBombBig:1b` | `minecraft:mooshroom_spawn_egg`（同上） | 炸弹兵大炸弹 | skill/bomber/give_big | 使用即消耗；表 20 秒（上限 2）/ 里 20 秒（上限 4）补 1 |
| `KitBombFake:1b` | `minecraft:mooshroom_spawn_egg`（同上；只有表有） | 炸弹兵假核弹 | skill/bomber/give_fake | 使用即消耗；25 秒补 1、上限 1（与大炸弹各算各的） |
| `KitBombTrack:1b` | `minecraft:mooshroom_spawn_egg`（同上） | 炸弹兵跟踪炸弹 | skill/bomber/give_track | 使用即消耗；表 40 秒（上限 1）/ 里 20 秒（上限 2）补 1 |
| `KitBombNuke:1b` | `minecraft:mooshroom_spawn_egg`（同上） | 炸弹兵核弹 | skill/bomber/give_nuke | 使用即消耗；表一次性 4 枚不补货 / 里 15 秒补 1 |
| `KitSoulEarth:1b` | `minecraft:villager_spawn_egg`（村民蛋在本服只有这一处发，是唯一来源） | 魂石·地球 | skill/soul/give | 一次性蛋，用后消失 |
| `KitSoulLi:1b` | `minecraft:pig_spawn_egg`（与李朱俊泽自己的 `KitLiPig` 共用同种蛋，靠生成生物名字「李朱俊泽魂石」分流） | 魂石·李朱俊泽 | skill/soul/give | 一次性蛋，用后消失 |
| `KitSoulFisherTrident:1b` | `minecraft:trident`（与里·渔夫那把逐字一致：激流 I、实际伤害 5） | 魂石·渔夫（效果物） | skill/soul/use_fisher | skill/soul/fisher_expire |
| `KitTaintedAxe:1b` | `minecraft:stone_axe` | 里·弓箭手（小锤40） | kit/tainted_archer | clear_player |
| `KitTaintedBow:1b` | `minecraft:bow` | 里·弓箭手 | kit/tainted_archer、skill/tainted_archer/give_bow | skill/tainted_archer/steal_bow、return_bow |
| `KitTaintedTurretEgg:1b` | `minecraft:stray_spawn_egg` | 里·弓箭手（炮台令牌） | skill/tainted_archer/give_token_turret | clear_player |
| `KitTaintedCoreEgg:1b` | `minecraft:blaze_spawn_egg` | 里·弓箭手（熔火核心令牌） | skill/tainted_archer/give_token_core | clear_player |
| `KitWerewolfAxe:1b` | `minecraft:stone_axe` | 狼人（嗜血狼牙） | kit/werewolf | clear_player |
| `KitWerewolfEgg:1b` | `minecraft:wolf_spawn_egg` | 狼人（嗅闻令牌） | kit/werewolf、skill/werewolf/give_egg | skill/werewolf/cast（连同那只狼一起清） |
| `KitTamerEgg:1b` | `minecraft:wolf_spawn_egg` | 驯兽师（狼蛋）——与狼人共用同种蛋，靠本标记区分；蛋另带 `EntityTag:{Tags:["kitpvp.tamer_wolf"]}`，**刻意不给 display.Name**（会变成狼的名字） | kit/tamer、skill/tamer/give_egg | —（蛋用来放狼，不回收；狼由 game/end / game/reset / map/restore 清除，繁殖后代由 game/reset 按类型清） |
| `KitSoulBow:1b` | `minecraft:bow` | 魂石·弓箭手（效果物） | skill/soul/use_archer | skill/soul/bow_expire |
| `KitSoulArrow:1b` | `minecraft:arrow` | 魂石·弓箭手（效果物） | skill/soul/use_archer | skill/soul/bow_expire |
| `KitTaintedFisherBlue:1b` | `minecraft:glow_squid_spawn_egg` | 里·渔夫（「苍」令牌） | kit/tainted_fisher、skill/tainted_fisher/give_blue | 放领域展开时 skill/tainted_fisher/domain_start 收走、clear_player |
| `KitTaintedFisherDomain:1b` | `minecraft:squid_spawn_egg` | 里·渔夫（「领域展开」令牌） | kit/tainted_fisher、skill/tainted_fisher/give_domain | 放苍时 skill/tainted_fisher/blue_start 收走、clear_player |
| `KitSunBow:1b` | `minecraft:bow`（火矢 I） | 太阳（日冕物质抛射） | kit/sun、skill/sun/give_bow | skill/sun/steal、skill/sun/return |
| `KitSunFlareEgg:1b` | `minecraft:bee_spawn_egg` | 太阳（太阳耀斑令牌） | kit/sun、skill/sun/give_flare | 放黑子时 skill/sun/spot_fire 收走、clear_player |
| `KitSunspotEgg:1b` | `minecraft:bat_spawn_egg` | 太阳（太阳黑子令牌） | kit/sun、skill/sun/give_spot | 放耀斑时 skill/sun/flare_fire 收走、clear_player |
| `KitAlchemistPotion:1b` | `minecraft:splash_potion`（四种喷溅药剂的共用标记） | 药剂师（技能组 1 整套） | kit/alchemist、skill/alchemist/give_* | skill/alchemist/clear_splash、tick（掉虚空清理）、clear_player |
| `KitAlchemistSpeed:1b` | `minecraft:splash_potion` | 药剂师（迅捷药剂） | skill/alchemist/give_speed | skill/alchemist/clear_splash |
| `KitAlchemistRegen:1b` | `minecraft:splash_potion` | 药剂师（再生药剂） | skill/alchemist/give_regen | skill/alchemist/clear_splash |
| `KitAlchemistJump:1b` | `minecraft:splash_potion` | 药剂师（跳跃药剂） | skill/alchemist/give_jump | skill/alchemist/clear_splash |
| `KitAlchemistInvis:1b` | `minecraft:splash_potion` | 药剂师（隐匿药剂） | skill/alchemist/give_invis | skill/alchemist/clear_splash |
| `KitAlchemistElixir:1b` | `minecraft:potion`（四种秘药的共用标记） | 药剂师（技能组 2 整套） | kit/alchemist、skill/alchemist/give_elixir_* | skill/alchemist/clear_elixir、clear_player |
| `KitAlchemistFireRes:1b` | `minecraft:potion` | 药剂师（抗火药水） | skill/alchemist/give_elixir_fire_res | skill/alchemist/clear_elixir |
| `KitAlchemistStrength:1b` | `minecraft:potion` | 药剂师（力量药水） | skill/alchemist/give_elixir_strength | skill/alchemist/clear_elixir |
| `KitAlchemistSlowFall:1b` | `minecraft:potion` | 药剂师（缓降药水） | skill/alchemist/give_elixir_slow_fall | skill/alchemist/clear_elixir |
| `KitAlchemistTurtle:1b` | `minecraft:potion` | 药剂师（神龟药水） | skill/alchemist/give_elixir_turtle | skill/alchemist/clear_elixir |
| `KitTtGroup1` | `zombie` / `skeleton` / `creeper` 刷怪蛋（技能组 1 共用标记） | 里·驯兽师 | skill/tainted_tamer/give1 | start_cd1 收走整套、refill1 判整套是否还在 |
| `KitTtGroup2` | `vindicator` / `witch` / `vex` / `blaze` 刷怪蛋（技能组 2 共用标记） | 里·驯兽师 | skill/tainted_tamer/give2 | start_cd2、refill2 |
| `KitTtZombie` / `KitTtSkeleton` / `KitTtCreeper` | 对应刷怪蛋 | 里·驯兽师（技能组 1 分型） | skill/tainted_tamer/give1 | —（整套一起发，分型只为查重） |
| `KitTtVindicator` / `KitTtWitch` / `KitTtVex` / `KitTtBlaze` | 对应刷怪蛋 | 里·驯兽师（技能组 2 分型） | skill/tainted_tamer/give2 | —（同上） |
| `KitVenusChill` | `minecraft:polar_bear_spawn_egg` | 金星（制冷模块） | skill/venus/give_chill | 使用即消耗；cd 走完由 refill_chill 补回 |
| `KitVenusArm` | `minecraft:evoker_spawn_egg` | 金星（武装模块） | skill/venus/give_arm | 使用即消耗；cd2 走完由 refill_arm 补回 |
| `KitVenusBomb` | `minecraft:silverfish_spawn_egg` | 金星（自爆模块） | skill/venus/give_bomb | 使用即消耗；venus_cd3 走完由 refill_bomb 补回 |
| `KitCivilStick` | `minecraft:stick`（锋利 V） | 文明小子主武器 | kit/civil | 恶魔形态换成烈焰棒时 clear、demon_end 换回 |
| `KitCivilBrick` | `minecraft:brick`（击退 II） | 文明小子红砖 | kit/civil | 恶魔形态换成恶魔板砖时 clear、demon_end 换回 |
| `KitCivilRod` | `minecraft:blaze_rod`（锋利 V + 火焰附加 I） | 文明小子恶魔形态主武器 | skill/civil/demon_start | skill/civil/demon_end |
| `KitCivilDemonBrick` | `minecraft:brick`（击退 III） | 文明小子恶魔板砖 | skill/civil/demon_start | skill/civil/demon_end |
| `KitCivilSpit` | `minecraft:splash_potion` | 文明小子（口水） | kit/civil、skill/civil/give_spit、demon_end 换回 | 投出即消耗；auto 补货、demon_start 换恶魔口水 |
| `KitCivilDemonSpit` | `minecraft:splash_potion` | 文明小子（恶魔口水） | skill/civil/give_demon_spit、demon_start 换入 | 投出即消耗；auto 补货、demon_end 换回 |
| `KitCivilDemon` | `minecraft:strider_spawn_egg` | 文明小子（恶魔形态令牌） | kit/civil、skill/civil/give_demon_token | 使用即消耗；cd2 走完由 refill_demon 补回 |
| `KitLiPig` | `minecraft:pig_spawn_egg`（`EntityTag` 打 `kitpvp.li_pig`、名字 iLsacuL、20 血；**刻意不带 display.Name**，否则猪会被改成蛋的名字） | 李朱俊泽（iLsacuL 召唤蛋） | kit/li_zhujunze、skill/li_zhujunze/give_egg | 使用即消耗；auto 按上限 5 补货 |
| `KitEarthEgg` | `minecraft:goat_spawn_egg`（`EntityTag` 打 `kitpvp.earth_token`；**刻意不带 display.Name**） | 地球（召唤生灵） | kit/earth、skill/earth/give_egg | 使用即消耗；auto 按上限 3 补货 |
| `KitEarthTable` | `minecraft:crafting_table`（锋利 III） | 地球主武器 | kit/earth | clear_player |
| `KitFarmerHoe` | `minecraft:iron_hoe`（无法破坏，攻速 -2.0 / 伤害 +4.5） | 农夫主武器 | kit/farmer | clear_player |
| `KitSoulMars` | `minecraft:ravager_spawn_egg`（蛋另带 `EntityTag:{Tags:["kitpvp.soul_mars_token"]}`；劫掠兽蛋本服只有这一处发） | 魂石·火星 | skill/soul/give | 一次性蛋，用后消失 |
| `KitTaintedFarmerShovel` | `minecraft:iron_shovel`（无法破坏，原版数值） | 里·农夫主武器 | kit/tainted_farmer | clear_player |
| `KitTaintedFarmerHoe` | `minecraft:iron_hoe`（无法破坏，击退 II） | 里·农夫耕地工具（也喂 farm_used 统计） | kit/tainted_farmer | clear_player |
| `KitTaintedRise` | `minecraft:mooshroom_spawn_egg`（`display.Name` = 开始一场起义，会成为生成生物的 CustomName） | 里·农夫技能 1（一次性） | kit/tainted_farmer | 一次性蛋，用后消失 |
| `KitTaintedRally` | `minecraft:husk_spawn_egg`（`display.Name` = 召集农民） | 里·农夫技能 2（上限 1 / 60 秒冷却） | kit/tainted_farmer、skill/tainted_farmer/rally_refill | 使用即消耗，冷却走完补回 |
| `KitSoulFarm` | `minecraft:zombie_villager_spawn_egg`（蛋另带 `EntityTag:{Tags:["kitpvp.soul_farm_token"],NoAI:1b,Silent:1b}`；僵尸村民蛋本服只有这一处发） | 魂石·农夫 | skill/soul/give | 一次性蛋，用后消失 |

> 新增标记时：值统一用 `1b`；不要给非本职业物品写 `<标记>:0b`（`SelectedItem.tag.<标记>` 只判路径存在，不判值）。

---

## 五、新增名字时的自检

- [ ] objective / tag 名是否以 `kitpvp.` 开头？
- [ ] 是否与本文档已登记的任何一个名字**重名**？
- [ ] 新增 objective 是否已在 `load.mcfunction` 里创建？
- [ ] 若该 objective 是 `*_last` 快照，是否在 `load` / `player/join` / `util/clear_player` 三处都初始化？
- [ ] 新增 tag 是否回答了"`clear_player` 要不要清"？
- [ ] 本文件是否已补行？（发现遗漏时补即可，不必回溯历史）
