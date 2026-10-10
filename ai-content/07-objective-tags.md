# Objective / Tag / 物品标记 索引

> **定位**：本文件是**派生账本**——记录代码里实际用了哪些名字，用于查重与速查。
>
> **权威顺序**：**代码优先**。真身在 `load.mcfunction` / `util/clear_player.mcfunction` / `tick.mcfunction` / `skill/*`。
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

| 名称 | 用途 | 初始化于 | 消费者 |
|---|---|---|---|
| `kitpvp.kit` | 职业 ID（0=未选） | load / clear_player | dispatch、tick 各检测行 |
| `kitpvp.cd` | 主技能冷却（刻） | load / clear_player | tick 递减、dispatch 闸门 |
| `kitpvp.cd2` | 第二技能冷却（刻，预留） | load / clear_player | tick 递减 |
| `kitpvp.alive` | 存活（1=活 0=旁观） | load / clear_player | tick 各检测行 |
| `kitpvp.lives` | 剩余命数 | load / clear_player | 死亡结算 |
| `kitpvp.kills` | 击杀数 | load / clear_player | 结算 |
| `kitpvp.deaths` | 死亡数 | load / clear_player | 结算 |
| `kitpvp.map` | 当前地图 ID（预留） | load | 地图选择 |
| `kitpvp.timer` | 全局倒计时（秒） | load | timer_tick |
| `kitpvp.inv` | 无敌剩余刻数 | tick 补零 / clear_player | 无敌结束判定 |
| `kitpvp.death_detect` | 死亡计数器（写入方未定，待补） | — | death_dispatch |
| `kitpvp.death_seen` | 死亡快照 | load / join / clear_player | death_dispatch |
| `kitpvp.game` | 游戏状态 | load | check_winner |
| `kitpvp.item` | 预留 | load / clear_player | — |
| `kitpvp.tank_last` | 坦克快照 | load / join / clear_player | tick |
| `kitpvp.assassin_last` | 刺客快照 | load / join / clear_player | tick |
| `kitpvp.ready_last` | 准备快照 | load / lobby/enter / clear_player | tick |
| `kitpvp.arsonist_last` | 投掷快照 | load / join / clear_player | tick |
| `kitpvp.arsonist_ammo` | 剩余燃烧瓶数量（上限 2） | load / kit/arsonist / join / clear_player | dispatch、cast |
| `kitpvp.fire_timer` | 火焰守护剩余刻数（挂在 marker 上） | arsonist_place | arsonist_flame_tick |

### 2.2 统计类型

| 名称 | 类型 | 用途 | 初始化于 | 消费者 |
|---|---|---|---|---|
| `kitpvp.tank_used` | `minecraft.used:minecraft.iron_golem_spawn_egg` | 坦克令牌使用 | load | tick |
| `kitpvp.assassin_used` | `minecraft.used:minecraft.enderman_spawn_egg` | 刺客令牌使用 | load | tick |
| `kitpvp.ready_used` | `minecraft.used:minecraft.carrot_on_a_stick` | 大厅准备钓竿使用 | load | tick |
| `kitpvp.arsonist_used` | `minecraft.used:minecraft.splash_potion` | 燃烧瓶投掷 | load | tick |
| `kitpvp.gapple_used` | `minecraft.used:minecraft.golden_apple` | 战士补给（已停用，保留登记） | load | — |

> 统计类型 objective 一律在 `load.mcfunction` 里统一创建。

### 2.3 假玩家

| 名称 | 用途 |
|---|---|
| `#state kitpvp.game` | 游戏状态机（0=待机 1=进行中 2=结算中） |
| `#tick kitpvp.game` | 胜负轮询节流计数器 |
| `#test kitpvp.game` | 测试模式开关（1=自动判定胜利关闭） |

---

## 三、Tag

| tag | 用途 | add 于 | remove 于 | clear_player 清 |
|---|---|---|---|---|
| `kitpvp.joined` | 已登记接入 | player/join | — | ❌ 刻意不清 |
| `kitpvp.in_lobby` | 在大厅 | lobby/enter | lobby/exit | ❌ 刻意不清 |
| `kitpvp.selected` | 已选职业 | kit/xxx | clear_player | ✅ |
| `kitpvp.invincible` | 无敌中 | player/invincible | player/end_invincible / clear_player | ✅ |
| `kitpvp.sudden_death` | 突然死亡激活 | game/sudden_death_start | clear_player | ✅ |
| `kitpvp.spectator` | 旁观者 | player/eliminate | clear_player | ✅ |
| `kitpvp.respawn_pending` | 待重生处理 | player/on_death | player/after_death / clear_player | ✅ |
| `kitpvp.death_immune` | 死亡不计 | 职业专属 | clear_player | ✅ |
| `kitpvp.keep_inventory` | 保留背包 | 职业专属 | clear_player | ✅ |
| `kitpvp.skill_ready` | 战士持有补给 | warrior_ready | warrior_consume / clear_player | ✅ |
| `kitpvp.skill_consume` | 预留 | — | clear_player | ✅ |
| `kitpvp.shield_held` | 坦克持盾中 | tank_fire | tank_expire / clear_player | ✅ |
| `kitpvp.assassin_hidden` | 刺客隐匿中 | assassin_fire | assassin_unhide / clear_player | ✅ |
| `kitpvp.ready` | 已准备 | lobby/ready_on | lobby/ready_off / clear_player | ✅ |
| `kitpvp.ready_pending` | 准备待处理 | lobby/ready_toggle | clear_player | ✅ |
| `kitpvp.arsonist_burst` | 药水落地已触发 | arsonist_burst | 随药水实体消失 | ❌ 挂实体上 |
| `kitpvp.arsonist_fire` | 火焰守护 marker | arsonist_place_one | 随 marker 被 kill | ❌ 挂实体上 |
| `kitpvp.arsonist_new` | 本批未初始化 marker | arsonist_place_one | arsonist_place | ❌ 挂实体上 |
| `kitpvp.hold_fb` | 当前手持燃烧瓶 | tick（每刻重建） | tick（每刻重建） | ❌ 每刻重建 |
| `kitpvp.hold_fb_prev` | 上一刻手持燃烧瓶 | tick（每刻重建） | tick（每刻重建） | ❌ 每刻重建 |

> tag 只用于"有/没有"的二值判断。编号、计数、冷却用计分板。
> 每刻重建的 tag（`hold_*`）**不写入** `load` / `clear_player`。

---

## 四、物品 NBT 标记

| 标记 | 挂在什么物品上 | 归属职业 | 给出方 | 回收方 |
|---|---|---|---|---|
| `KitTankEgg:1b` | `minecraft:iron_golem_spawn_egg` | 坦克 | skill/tank_give_egg | tick 生成物清理 |
| `KitShield:1b` | `minecraft:shield` | 坦克 | skill/tank_fire | tank_expire / clear_player |
| `KitFireBomb:1b` | `minecraft:splash_potion` | 纵火狂 | skill/arsonist_give | arsonist_fire / clear_player |

> 弓箭手（`kitpvp.kit=2`）用的是**原版弓 + advancement 触发器**，未使用自定义 NBT 标记，因此不在本表。
> 新增标记时：值统一用 `1b`；不要给非本职业物品写 `<标记>:0b`（`SelectedItem.tag.<标记>` 只判路径存在，不判值）。

---

## 五、新增名字时的自检

- [ ] objective / tag 名是否以 `kitpvp.` 开头？
- [ ] 是否与本文档已登记的任何一个名字**重名**？
- [ ] 新增 objective 是否已在 `load.mcfunction` 里创建？
- [ ] 若该 objective 是 `*_last` 快照，是否在 `load` / `player/join` / `util/clear_player` 三处都初始化？
- [ ] 新增 tag 是否回答了"`clear_player` 要不要清"？
- [ ] 本文件是否已补行？（发现遗漏时补即可，不必回溯历史）
