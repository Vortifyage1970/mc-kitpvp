# 已知坑位与约定（Hazards & Reminders）

> 本文件记录已踩到、易踩到的坑，以及若干必须共同遵守的约定。
> 每次动过代码后，若踩到新坑就补进来；旧坑被修掉也要更新本文档。
> 版本红线：**1.20.1 数据包**（pack_format 15）。任何 1.20.2+ 的语法出现即报错，详见 `00-version.md`。

---

## 一、结算链路（game/end 与 game/reset）

> 现状（2026-10-14 对照 `src/` 核对）：结算链路已经跑通，下面五条是"现在就是这么实现的"，不再是待办。

1. **`#state` 只在开局 / 结算 / 重置三处写。** `game/start_impl` 置 1、`game/end` 置 2、`game/reset` 归 0，`load` 初始化 0。证据在两根线上：
   - `tick.mcfunction` 的胜负兜底轮询：`if score #state kitpvp.game matches 1 run function kitpvp:game/check_winner`；
   - `player/eliminate.mcfunction` 末尾直接调 `check_winner`，**没有 `#state` 守卫**，所以 `check_winner` 自己必须能分辨"进行中"和"结算中/已结束"（它读了 `#state` 与 `#debug`）。
2. **结算 10 秒定时器**用 `schedule function kitpvp:game/reset 200t replace` 发射。`replace` 保证同一次结算里重复触发不会叠多个定时器；`game/end` 已把 `#state` 锁成 2，正常路径也不会被重复调用。
3. **0 幸存者分两种走向**（都在 `game/check_winner` 里）：场上还有在线旁观者（`@a[tag=kitpvp.spectator]`）→ 判平局、自动结算；全员掉线（0 幸存者且无旁观者）→ **不结算**，避免误清场。`#debug=1` 时一律不自动结算。
4. **`reset` 的非玩家清理是"生成 + 白名单"**，不再是裸 `kill @e`：掉落物 `kill @e[type=item]`，其余按 tag 清，
   清单由 `tools/gen_cleanup.py` 从**所有 `summon` 的 `Tags`、刷怪蛋的 `EntityTag`、运行期 `tag @e add`** 反推生成到
   `game/reset_entities.mcfunction`；画 / 物品框 / 装饰实体靠 `load` 打的 `kitpvp.displayitem` + `Invulnerable:1b` 保护，
   大厅展台 `kitpvp.kit_stand` 与 `_new` 瞬态 tag 在生成器里排除。
   **每新增一种召唤物：重跑 `python tools/gen_cleanup.py`**（`check.py` 会拦住"忘了重跑"）。
   顺序敏感的两类在生成器里单列：地球守卫 / 时钟必须排在本体前面删。
5. **结算 10 秒内打不动人**：`game/end` 给全体 `effect give @a minecraft:resistance 10 4 true`（抗性 V = 100% 减伤）。

---

## 一之三、tick 分层（2026-11-15 起）

`tick.mcfunction` 只剩 10 行模块调用 + 两个慢拍闸门，模块内容就是拆分前那 548 行的连续片段（顺序未变）。

| 位置 | 放什么 |
|---|---|
| `tick/life` | 接入检测 + `cd` / `cd2` / `sun_reload` / `venus_cd3` 每刻递减 |
| `tick/lobby` | 大厅物品兜底、饱和、传送、起跳柱、准备按钮 |
| `tick/kits_a..f` | 各职业的每刻逻辑（顺序按原文件，不能互换） |
| `tick/player` | 无敌、虚空、死亡检测、胜负轮询 |
| `tick/world` | 多伦多按钮的**递减**、火星 / 混沌弓箭手 / 哈雷 |
| `tick/slow2` | 每 2 刻：读 `used` 快照的触发 + `cd` 到点才补的发放（幂等） |
| `tick/slow4` | 每 4 刻：多伦多按钮的**判定**（按钮按下 10 刻，4 刻采样够用） |

**绝不能搬进慢拍的东西**（搬了就会漏触发或计时变慢）：

- 每刻重建的 tag：`hold_*_prev`、`pirate_charged_prev`、`venus_chilled`、`tep_ready`、`arrow_user`
- 每调用一次就 -1 的计时器（`cd`、各类 `*_timer`、`#cart_cdN`）——慢拍里调用会变成 2/4 倍时长
- 投掷类 `cast`（`hold_*_prev` 只活 1 刻，晚一拍就丢技能）
- 箭落地清理、实体跟随（金星狗 / 冥王星鹦鹉）、蓄力、太阳的 `effect clear`
- 卡在 `ChaosBlade` 数量差上的弓 / 弩判定

新增职业时：往 `tick/kits_*` 加每刻逻辑，或往 `slow2` 加幂等触发；**别把 `tick.mcfunction` 写胖回去**。

---

| 地图 | 时间 | 昼夜循环 |
|---|---|---|
| 沙漠 (1) | `time set 11000`（黄昏） | 不关，会自然入夜 |
| 竞技场 (2) | `time set day`（早上） | 不关 |
| 雪原 (3) | `time set night`（晚上） | 不关 |
| 地球 (7) | `time set day` | **关**（定格白天） |
| 豪宅 (9) | `time set night`（晚上） | 不关 |
| 君士坦丁堡 (10) | `time set noon`（正午） | **关**（定格正午） |
| 多伦多 (11) | `time set day`（白天） | 不关 |
| 海洋 (12) | `time set day`（白天） | **关**（定格白天） |

结算 `game/end` 会把 `doDaylightCycle` 放回 `true`；`load` 也默认 `true`，只有地球/君士坦丁堡在开局时关。

---

## 二、debug 模式（`debug/`）

入口就一个：`/function kitpvp:debug/on`（菜单里点按钮也行）。2026-11-07 起原来的 `debug/test/` 目录拍平到 `debug/`，
分数开关从 `#test` 改名为 `#debug`，措辞统一叫"debug 模式"。

菜单内容：`solo_start` / `play` / `build` / `status` / `music` / `notch_mode` / `force_reset` / `sudden_death` / `soul_stone_give` / `suicide` / `off`。
旧的 `force_end` 已删（要结算就走 `game/end` 或直接 `force_reset`）；`select_list`、`soul_probe` 都在 2026-11-10 按车主的要求删掉了。

1. **`#debug` 一旦为 1，自动判定胜利永远不触发。** 正式局前先跑一次 `function kitpvp:debug/status`，确认 `#debug` 是 0。
2. **`build` 模式会摘掉 `kitpvp.selected`**，这会让 survivors 统计少一个人。这是刻意设计——建造期间不参与游戏统计。要"边建造边参与统计"，用 `play` 而不是 `build`。
3. **`force_reset` 里的 `schedule clear kitpvp:game/reset` 只能清掉还没发射的那一次。** 如果 `end` 的 200t 倒计时已经跑完并执行了 `reset`，那 `force_reset` 只是再跑一次 `reset`，是幂等的，不会出错（它现在会顺手播一行提示）。
4. **`solo_start` 和 `play` 都不做传送。** 大厅坐标已经定了（见 `lobby/spawn` 顶部的坐标注册表：出生点 `0 64 0`），这两个调试入口把玩家留在原位，方便就地试技能；要回大厅跑 `function kitpvp:lobby/enter`。
5. **`effect give ... instant_health 1 5 true` 是 `/heal` 的替代写法**（1.20.1 没有 `/heal`，那是 Mod 提供的）。`util/clear_player.mcfunction` 末尾和 `invincible.mcfunction` 都用这个模式。如果实测发现回不满，把 amplifier 调到 9。
6. **`notch_mode` 是逐人开关**（`#notch` 用 `%2` 翻转）：开启时给饱和 I + 生命恢复 X（amplifier 9，都是 `infinite`）**并挂一条 `generic.attack_damage` +10 的修饰符**（UUID `…0077`），再点一次清掉（`debug/off` 与 `util/clear_player` 也会兜底摘掉）。挂 `kitpvp.notch_mode` tag 是为了 `debug/off` 能一次收干净——**太阳的被动每刻 `effect clear @s`，会把 Notch 模式的增益一起清掉**，这是已知冲突。
7. **`suicide` 走 `kill @s`**，所以命数扣减、`death_detect`、旁观判定都按正常死亡结算，不是"假死"。
8. **`music` 只列还在用的三首**：雨爱（`kitpvp:music/yu_ai`，内置音符盒）、ISOxo - 非人类与伊邪那岐（`mvpmusic` 数据包）。
   `touhoumusic`（世界里的 `thmusic` 数据包）已弃用，菜单里不再出现；`music_stop` 里也只剩还活着的那几个 stop。
9. **雨爱没有"播放器状态"，只有一条 `schedule` 链**：每个 `ev_NNNN` 用 `replace` 排下一个，所以停播只能逐个 `schedule clear`
    （`music/yu_ai/stop.mcfunction` 由脚本生成 114 行），别再手写。

---

## 三、tellraw 的 clickEvent 必须带斜杠

单独拆成一节，因为写菜单按钮时最容易在这里翻车。

**规则：`"action":"run_command"` 的 `value` 必须以 `/` 开头。**

正确：

```json
{"text":"[开始游戏]","color":"green","clickEvent":{"action":"run_command","value":"/function kitpvp:game/start"}}
```

错误（漏前导斜杠，点击无效）：

```json
{"text":"[开始游戏]","color":"green","clickEvent":{"action":"run_command","value":"function kitpvp:game/start"}}
```

配套约定：

- `suggest_command` 的 `value` 是填进聊天输入框的内容，也建议带 `/`。
- `copy_to_clipboard` 的 `value` 是纯文本，是否带 `/` 按用途决定；想让玩家粘贴即可执行，就必须带。
- **`hoverEvent` 字段名是 `contents`，不是 `value`**；`show_text`、`show_item`、`show_entity` 三种 action 都是 `contents`。
- **`show_item` 的 `tag` 必须是 SNBT 字符串**，写成 JSON 对象会让整个数据包加载失败（全部函数报"未知函数"）。带 `tag` 的物品**不会**自动继承默认 `AttributeModifiers`，攻击力/攻速/护甲要自己写全。
- 生成 JSON 时留意转义：外层用单引号包住整段 JSON 时，**内部全部用双引号**。

参照实现：`lobby/menu.mcfunction`。

---

## 四、给予物品类技能：冷却检测不能被"丢出物品"绕过

这一节是设计"给玩家发物品"的技能时的**通用坑**。新增同类技能时请照抄现有参照实现（见 4.2）。

### 4.1 为什么"检测背包里物品消失"是错的

如果把冷却条件设计成"**背包里没有了该物品 → 说明用掉了 → 进入冷却 / 补发**"，那么玩家只要**把物品丢到地上、塞进箱子、交给队友**，背包里就会"没有了"，从而触发本来只有"**真正使用**"才该触发的逻辑。玩家的操作没有消耗物品、也没有吃到效果，却把"已被使用"的状态骗了过去。

后果分两类，都是坏结果：

- **补发型（无限刷）**：技能实现为"背包里没有 X 就再给一份"。玩家丢一份 → 立刻补一份 → 再丢 → 又补一份……循环刷。
- **冷却型（语义污染）**：技能实现为"背包里没有 X 就进冷却"。看似玩家被冷却了，其实只是"丢了"而不是"用了"。而且如果地图里散落了野生的 X，玩家捡起来再丢，冷却会被反复触发/反复重置。

**目标：保证进入冷却的唯一依据是"玩家真的使用了这个物品"。**

### 4.2 参照实现

当前项目两类都有实例：

- **补货型（发物品型自动技能）**：`skill/enderman/auto`（末影之珠）、里·弓箭手的令牌补货
  （`tick` 的里·弓箭手段 + `skill/tainted_archer/give_token_turret` / `give_token_core`）。
  共同点：**不用**"背包里没有就发"，而是用 `clear <目标> <物品>{<nbt>} 0` 数出背包真实数量，
  低于上限才补，并由补货方自己 `set kitpvp.cd`（第二技能用 `cd2`）控节奏。
- **主动技能**：判据是"**真的使用了**"——统计 objective 的 `used` 增长（如 `skill/tank/dispatch`），
  不能是"背包里没有这个物品"。
- **上限 1 的一次性令牌**（坦克举盾 / 刺客隐匿 / 渔夫寻回三叉戟 / 里·渔夫的两个令牌）用的是"**发回窗口**"：
  `<职业>/cast` 里开窗（快照推进 = 令牌真的被用掉了），整段冷却走完由 `<职业>/handout` 一次性发回并关窗。
  这是上限 1 时最紧的做法：**没有任何事件在"背包里缺"的时候触发补发**，所以拖动物品 / 丢地上 / 塞箱子都不会多给。
  它同时兜住"白按"（冷却中按、或渔夫的"三叉戟尚未离场"）：没进冷却也会在下一刻把令牌发回。
  代价：玩家**故意**把令牌扔掉后，要等下一次技能周期才会回来（要即时兜底就退回上面那条"补货侧置冷"）。
- **上限 1 + 完整冷却 + 自愈补货**（太阳的耀斑 / 黑子）：判据是"**`cd` 走完 + 手上没有 + 地上也没有（16 格内没有同类掉落物）**"，
  真的补上了才播"已就绪"提示（`skill/sun/refill_give_flare` / `refill_give_spot`；提示不能写在 `refill_flare` 里——那儿每刻都被调到）。
  这是窗口模型在实战里失效后的修正：窗口只在玩家按冷却正常循环时才成立，
  **任何非施法路径的丢失**（背包满时 give 掉在地上、被队友捡走、自己失误丢地上）都会让令牌永远回不来——
  真实故障：world 日志里太阳的耀斑出现过 89 秒空档（20:03:52 → 20:05:21）。
  **已接受的漏洞**：故意丢远处能提前拿回一颗；但 (a) 施法被 `cd` 闸门拦着，多发一颗换不到额外一发，
  (b) 地上已有同类令牌就不补，"丢一颗换一颗"没有净收益。里·渔夫的"整把锁"仍用窗口模型。

落地步骤见 4.3 / 4.4。

### 4.3 如果该类物品没有 `used` 统计项怎么办

自定义物品（用 NBT/Name 区分）没法从 `minecraft.used:` 里单拿出来（1.20.1 没有 `execute if items`；那是 1.20.5+）。三条路，选一条：

1. **接受"全部同类型物品合并统计"**：只要该物品在服务器上的唯一来源就是本职业技能（黄金苹果、面包、雪球之类），直接用 `minecraft.used:minecraft.<item>`。前提是**没有其他职业发、也没有地图上的野生刷新**。
2. **改为"发物品即进冷却"**：`skill/<职业>/give_*` 里给完物品**立刻** `set kitpvp.cd <刻数>`，"使用"这个动作不再参与冷却判断。这样绝不会有刷物品漏洞；代价是玩家可以拖到冷却结束再吃来多留一个。部分职业（例如"一次性召唤物"或"持续 Buff 卷轴"）用这个模式反而更贴切。
3. **走自定义触发器记录"使用"**：1.20.1 能用 `advancement`（`minecraft.used_item`、`minecraft.consume_item` 这一类统计触发器）或者右键检测来判"使用"，**但具体触发器字段必须先 `/help` 或实测确认，不要照抄 1.20.2+ 的写法，也不要照抄 1.20.5+ 的 `components` 写法**。走这条路之前，务必先：
   - 决定"使用事件"用什么触发器；
   - 验证该触发器在 1.20.1 里存在、字段名正确；
   - 决定快照变量怎么随重连/清场同步。
   任何一环不确定，就退回方案 2（发放即冷却）。

### 4.4 新增"发物品"技能的自检清单

- [ ] 冷却触发条件是"**使用了物品**"，而不是"背包里没有物品了"？
- [ ] 若用的是 `minecraft.used:`，该物品在服务器上有没有其它来源会污染统计？
- [ ] 是否有一个 tag 明确表示"技能物品待消耗"？给出时 `add`，被使用（或改成"发放即冷却"）时 `remove`？
- [ ] `last` 快照变量在 `player/join` 与 `util/clear_player` 里都做过初始化？
- [ ] 玩家中途掉线重连后会不会被错判为"刚使用过"？会的话，在重连时把快照推到 `used` 当前值。
- [ ] 玩家物品栏满时获得的技能物品会不会掉地上被别人捡走？会不会导致 tag 与背包不一致？
- [ ] 冷却只由单一变量（`kitpvp.cd` 或 `kitpvp.cd2`）驱动，不会在同一个 tick 里被写两次互相覆盖？
- [ ] 发放里有没有"先判断某格是否为空、再按判断发放"的两分支写法？判断必须在发放**之前**冻结（见 4.5）。

### 4.5 一次给两份：同一刻里"判断"与"发放"的顺序

太阳的令牌补货曾经写成这样（**错**）：

```
execute unless data entity @s Inventory[{Slot:8b}] run function .../give_flare_at_hotbar8
execute if     data entity @s Inventory[{Slot:8b}] run function .../give_flare
```

意图是"固定槽位空就塞固定槽位，被占才走普通发放"。但第一行 `item replace entity @s hotbar.8 ...` 把那一格填满之后，
**第二行的条件当场也成立了**——同一次补货发出两份令牌（玩家反馈"一次给两个蛋"）。
两个分支读的是同一份状态，而第一个分支改了这份状态。

只有一种思路是对的：**先把判断冻结成结果，再发放**。

- 判断只算一次，写进临时 tag / 临时分数，两个分支都读它
  （`tag @s add` → `execute if data ... run tag @s remove` → 再按 tag 分流）；
- 或者干脆**不要分支**：`give` 会填进最靠前的空位——也就是刚用掉令牌空出来的那一格——位置本来就稳定。
  太阳最后选的是这条（少一个 tag、少一整类顺序坑）。

同类的坑：`clear <目标> <物品> 0` 只计数**不清除**，所以"数数量"必须在**同一个 tick 的发放之前**读出来；
一旦 `give` 之后再读，读到的就是新数量（里·弓箭手补货、纵火狂补货都按"先数后给"写，见 4.2）。

---

## 五、其它经常踩的坑

- **文件夹是 `functions`（复数）**，不是 `function`。加载钩子在 `data/minecraft/tags/functions/load.json`，每刻钩子在 `data/minecraft/tags/functions/tick.json`。
- **`.mcfunction` 每行一条命令，行尾无分号**，`#` 开头是注释，**不要写行号**。
- **命名空间只允许小写字母、数字、下划线**：`kitpvp` ✅，`KitPvP` ❌，`kit-pvp` ❌。
- **`scoreboard objectives add` 必须在 `load.mcfunction` 里统一创建。** 需要初始分数的玩家/假玩家也在 `load` 里初始化。新增 objective 时同步补进 `load`（现有清单见 `07-objective-tags.md` §2）。
- **1.20.1 无 `/heal`**，用 `effect give @s minecraft:instant_health 1 5 true` 代替（见 `util/clear_player.mcfunction`）。
- **1.20.1 没有以下语法，出现即报错**：`return` / `return run`、`tick` 命令、`random` 命令、`execute if items`、`dialog`、`waypoint`、`function xxx with {...}`、`function #tag`（调用函数标签）、宏 `$()`、函数参数。这些全都是 1.20.2+ 才有的。
- **1.20.1 物品 NBT 是旧版格式**：`{Enchantments:[{id:"minecraft:sharpness",lvl:5}]}`、`{display:{Name:'...'}}`、`{Unbreakable:1b}`。**不要**写 `components` / `enchantments` / `custom_name` / `unbreakable:{}`（那都是 1.20.5+）。
- **亡灵（骷髅 / 僵尸）对 `regeneration` 与 `poison` 免疫**：`LivingEntity#canBeAffected` 见到 `MobType.UNDEAD` 直接返回 false——**给了也不回血**。
  要治疗亡灵只能用**瞬伤**（`instant_damage` 对亡灵是反向的，等于回血）；反过来给亡灵 `instant_health` 是**掉血**。
  数值别记错：`instant_damage` 放大器 0 时对亡灵是 **`4 << amplifier` = 4 点（2 颗心）**，
  而对非亡灵是 `6 << amplifier` 伤害（同理 `instant_health` 是"治愈 4 / 伤亡灵 6"）。
  里·弓箭手"用石斧打炮台回血"就是这么实现的（规格里写的生命恢复对炮台完全无效），并配 1 秒冷却（`kitpvp.turret_heal_cd`）。
- **白天自燃看的是"头顶槽非空"，不是"是不是头盔"**：`Mob#aiStep` 里只要 `HEAD` 槽有物品就置位不点燃
  （可损坏的装备会掉耐久，**不可损坏的方块不掉**）。所以给骷髅头顶放个 `minecraft:iron_block`
  就能永久免疫日晒——里·弓箭手炮台靠这个，不需要 `fire_resistance`。
- **`generic.attack_speed` 对怪物的攻击频率无效**：怪物什么时候打、多久射一箭由 AI 决定
  （骷髅的弓间隔 `setMinAttackInterval` 由**难度**写死：困难 20 刻、其余 40 刻），改属性没有任何效果。
  想让"炮台射得更快"只能改全局难度（不可接受）或者改成提高**伤害**。
- **荆棘（thorns）允许写到原版上限之上**：原版最高 III，`{id:"minecraft:thorns",lvl:5}` 依然生效
  （附魔等级在 NBT 里没有上限，触发概率按 `15% × 等级` 算）。里·坦克全身四件都挂 V，
  装备写了 `Unbreakable:1b`，所以荆棘触发不会磨损耐久。
  （"一次受击只结算一件装备的荆棘"这一条**尚未实测**，测过之后把结论补进来。）
- **1.20.1 文本组件用小驼峰**：`clickEvent` / `hoverEvent`，不是 `click_event` / `hover_event`；`show_text` 的字段是 `contents`，不是 `value`。
- **`data get` / `data modify` 的路径用点号分隔**（`SelectedItem.tag.xxx`），数组用方括号（`Inventory[0]`）。
- **`load.mcfunction` 里那一大段 `tag @a remove` 是刻意为之，但 `kitpvp.joined` 与 `kitpvp.in_lobby` 不能在 `util/clear_player` 里清。** `kitpvp.joined` 一清，`tick.mcfunction` 的接入检测会重复触发 `player/join`；`kitpvp.in_lobby` 一清，`player/on_death.mcfunction` 的"大厅死亡不计"判定会失效。
- **`gamerule sendCommandFeedback false` 会吞掉大量命令反馈。** 调试时"没报错 ≠ 命令真的执行了"。写调试函数时优先配合 `tellraw` / `say` 显式输出，别靠默认反馈判断成败。
- **`tick.mcfunction` 里"虚空判死"用的是 `if entity @s[y=-1024,dy=950]`**，覆盖 y ∈ [-1024, -74]。若地图要改判定阈值，**只改 `dy`**（`y + dy - 1` 是上界），不要动 `y`，否则会漏掉更低的位置。
- **本包关了 `doWeatherCycle`（`load` 第 6 行），所以任何 `weather` 都要自己收尾**：`weather rain <秒>` 给的时长不会被消耗（天气循环不跑），
  雨只会被显式的 `weather clear` 停下。里·渔夫的领域展开与渔夫魂石（`skill/soul/use_fisher`）都是
  "起手转雨 + 各自的 expire 与 `game/reset` 两道 `weather clear`"兜底。
- **`fill` 出来的是水源方块，会顺着空处向外流**：`fill ... minecraft:water replace air` 只保证"不破坏已有方块"，
  但水自己会扩散（半径 1 的水球只有 7 格，仍会向四周空处蔓延）。场上的水由 `map/restore` 的 `place template` 清，
  而 `place template` 只覆盖模板体积——**流出模板范围的水会留下来**。里·渔夫的水球已知取舍（未封边）。
- **主动技能的通用模式（1.20.1）**：主动技能不能挂 `tick → dispatch`，必须靠"检测玩家操作"来触发。当前项目里用**统计 objective**（如 `minecraft.used:minecraft.iron_golem_spawn_egg`）检测"用掉了专属物品"，tick 里比对 `used > last` 后转交 `skill/<职业>/cast`。触发物默认选**颜色贴主题的刷怪蛋**（坦克用铁傀儡），生成物由 tick 立刻 `kill`。函数入口首行必须是快照推进（`operation last = used`），否则每刻重复触发。令牌的快照变量要在 `player/join` 与 `util/clear_player` 都初始化。
- **被动药水效果要在"真正重生之后"重挂，而不是死亡检测那一 tick 上**——两者相差至少 1 刻，写错就等于没挂。时序与正确写法见第六节。
- **幽灵魂石的阴兵本局内不会自行消失**（PersistenceRequired:1b，设计如此），只在 game/reset 统一 kill。
  不要把"20 秒后自己消失"当前提；game/reset 里的清理列表要随每种新召唤物同步补行。
- **让召唤物不攻击主人，靠"同队"就够了**：MC 的怪物仇恨选择会排除同队实体（`isAlliedTo`），`summon/ghost_minion_pair` 把阴兵与主人 `team join` 同一队即可。**不要**改成 `friendlyFire false` —— 那会变成"同队玩家互相打不到"，一旦队槽复用把两名玩家分进同一队就会出新 bug。
- **同队必须"两边都进队"**：只把**召唤物** `team join` 进去是不够的——主人不在任何队里，
  `isAlliedTo` 依然为假，召唤物照样打主人。必须同时 `team join <队> @s`（里·弓箭手炮台踩过这个坑）。
- **队槽编号必须每局重建，且按"谁占了"来分配**：`team join` 会跨局保留，`kitpvp.etid` 不清零的话，
  两名地球玩家很容易落到同一队，两人的召唤物就永远互不攻击（连下一局都恢复不了）。
  正确做法是 `game/start_impl` 里 `team leave @a[team=earth_*]` + 槽位清零，
  召唤时再取第一个空闲槽；分配槽位只认"这次召唤落点脚下"的召唤物（带距离），不要全局按 tag 认领。
- **补货型技能：`unless data ... Inventory[...]` 的幂等守卫会挡住"补到上限"**：
  那句只判"有没有"，手里有 1 个就再也不给——上限永远到不了。
  正确做法是**用 `clear ... 0` 数数量**、低于上限才补，并由补货方自己 `set cd`（否则 count 一直低于上限，每刻都补）。
- **史莱姆 / 岩浆怪被 `/kill` 时会分裂**：`Slime#die` 里 `size > 1` 就生成更小的个体
  （受 `doEntityDrops` 控制，本包没关它，默认会分）。**别拿岩浆怪/史莱姆当令牌生物**：
  1.20.1 里 `data merge entity @s {Size:1}` 实测**压不住**尺寸，一死就分裂；
  再配"每刻兜底清"会分裂出指数级的量（已实际踩过，代价很大）。
  真要清掉已经存在的岩浆怪/史莱姆：`/gamerule doEntityDrops false` → `kill` → 把 gamerule 还原，
  这样击杀不产生分裂体，一次清干净。
- **令牌类技能刷出来的生物，一律"当场清"**：刷怪蛋是令牌的载体，右键**必定真的刷出一只生物**
  （坦克铁傀儡、魂石六种、炮台流浪者、熔火核心烈焰人……），它是纯副作用。
  ① **首选不会分裂的生物**（熔火核心从岩浆怪改成烈焰人就是为此）；
  ② 技能自己的函数里立刻清（`skill/soul/use_*`、`skill/tainted_archer/core_fire`、`turret_fire` 都是这么写的）；
  ③ `game/reset` 里再清一遍——**每新增一种召唤物都必须在这里追加一行**（函数内的 A2 约定）；
  ④ **不要在 `tick` 里做"每刻清怪"的兜底**：清不干净时会滚成灾难，宁可当场清 + reset 兜底。
- **统计目标（`minecraft.used:*`）的 criterion 改过之后，老世界必须 `remove` 再 `add`**：
  `scoreboard objectives add` 对**已存在**的目标**不会更新 criterion**（而且不报错），
  于是老世界里的目标还在记旧物品：把令牌载体从岩浆怪蛋换成烈焰人蛋之后，用新令牌计数不涨、
  技能完全静默，**日志里没有任何提示**。统计目标是只读的（值由统计实时给出），
  所以 `remove` + `add` 不会丢数据，只是重建注册；同时要把对应的 `*_last` 快照重新对齐
  （`execute as @a run scoreboard players operation @s <obj>_last = @s <obj>_used`），
  否则快照里的残留旧值会大于新计数，永远不触发。
  判据：用令牌前后 `/scoreboard players get <玩家> <obj>` 的值不变 ⇒ 就是这个问题。
  烈焰人蛋 = 熔火核心令牌 / 战士魂石），**两侧都必须走 dispatch**：首行**无条件**推进各自的快照
  （`last = used`），再按**生成生物的自定义名** + `distance=..8`（刷怪蛋右键射程）分流，
  照抄 `skill/tank/dispatch`。反面教材：魂石那侧原来只写 `if score ...used > ...last` 就触发，
  在只有魂石会给该种蛋的年代看不出问题，一旦有第二种技能也用同一种蛋，
  **用另一种蛋会直接放出魂石效果**（而且快照不推进，下一次还会提前触发）。
  另外 `EntityTag:{Tags:["kitpvp.xxx"]}` 会把 tag 直接写进刷出来的生物（蛋的实体数据键），
  用它认自己的生物比 `name=` 稳；既有惯例是用 `name=` 分流，两者都可靠。
  **魂石侧也已补齐**这层分流：`skill/soul/use_archer` / `use_ghost` 先用 `name="弓箭手魂石"` / `"幽灵魂石"`
  守住，效果体分别落在 `archer_apply` / `ghost_apply` —— 里·驯兽师的骸骨 / 恼鬼蛋与它们共用同种蛋。
- **`execute ... run function` 只写 `as` 不写 `at` 时，函数里的 `~` 全部失效**：
  tick 函数的执行位置是**世界出生点**（不是玩家、不是 0,0,0）。凡是技能里要用相对坐标
  （粒子、音效、`summon`、`distance=..N` 选择器），调用处必须 `at @s` 锚定，
  否则粒子/音效跑到出生点、刷出的生物落在出生点、范围选择器筛错地方。
  本包 tick 里已有的写法是 `... as @a[...] at @s run function ...`，照抄即可。
- **令牌类技能必须处理"刷怪蛋自己刷出来的那只"**：蛋一用就会生成生物（坦克/刺客/渔夫/海盗魂石/炮台/熔火核心全都一样），
  技能函数里要么当场 `kill`（用 `display.Name` 变成的 `CustomName` 精确匹配），要么它会留在场上乱跑。
  炮台还顺手用"那只的落点"当召唤位置。
- **秒级心跳里"归零后重置倒计时"必须留 catch-all 分支**：`game/soul_tick` 的重置按命数分档
  （3 命 900 / 2 命 700 / 1 命 500 刻），最后一档写成 `matches ..1` 而不是 `matches 1`——
  命数一旦是 0 或负数，倒计时就会永远停在 ≤0，表现是**每秒发一颗魂石**。
  凡是"按某个分数分档选出重置值"的地方都要这样兜底。
- **落地箭清理每刻都要跑，只以"场上存在用箭的职业"为前置**：`tick.mcfunction` 里
  `execute if entity @a[tag=kitpvp.arrow_user] run kill @e[type=arrow,nbt={inGround:1b}]`。
  **不能按秒节流**（曾经是 20 刻一次）：落地到清理之间留出窗口，玩家能在这段时间把箭捡回来，刷过上箭上限。
  前置 tag `kitpvp.arrow_user` 由 `kit/archer` 与 `kit/tainted_archer` 打上，`util/clear_player` 摘掉；
  **新增任何用箭 / 能拾回箭的职业时，必须在该职业的 `kit/<职业>` 里补这个 tag**，否则场上没有"已登记"的用箭职业时，
  落地箭会被捡回、刷过上箭上限。
- **"打到人 / 杀死人"这类事件只能靠 advancement**：`player_hurt_entity` / `player_killed_entity` 配
  `conditions.entity.type` 才算"目标是玩家"。条件写错**不报错**，只是 advancement 永不发放（同 §十 的静默失败）；
  "用什么打的" 塞不进 conditions，只能在函数里判 `SelectedItem.tag.<标记>`。
- **advancement 的 rewards 函数不保证执行位置**：函数里凡用到 `~` 的（`playsound` / `particle` / `summon`）都要先 `at @s`。
- **选择器里比不了身份**：要给"除自己以外的所有人"上效果时，用同刻自清的临时 tag——
  `tag @s add kitpvp.<临时>` → `effect give @a[tag=!kitpvp.<临时>] ...` → `tag @s remove kitpvp.<临时>`，
  别拿 `distance` 之类的位置近似（贴脸站位会漏掉）。
- **补货型令牌的 `cd` 两侧都要写，使用侧必须带 `cd<=0` 守卫**：只写补货侧 ⇒ 满仓用掉一个当场补回来（每刻都在判"不足上限"，而 `cd` 还是 0）；
  使用侧不带守卫 ⇒ 连续出手把补货推到无限远。五套令牌（纵火狂 / 末影人 / 里·弓箭手炮台 / 狼人 / 驯兽师）
  现在都是"使用侧 `..0` 守卫置冷 + 补货侧无条件置冷"（见 `05` §十三）。
- **刷怪蛋令牌不要给 `display.Name`**：蛋的 `display.Name` 会变成生成生物的 `CustomName`，
  于是每只唤出来的狼都顶着"嗅闻令牌 / 狼蛋"的名字。要认自己的生物就用 `EntityTag:{Tags:["kitpvp.xxx"]}`（见 §五）。
- **`/effect` 的时长参数，单位随效果类型变**（源码 `EffectCommands` 实测）：普通效果是**秒**，
  **瞬时型效果（`saturation` / `instant_health` / `instant_damage`）是刻**，且瞬时型在持续期内**每刻生效一次**
  （`InstantenousMobEffect.isDurationEffectTick` = `duration >= 1`，不是"只生效一次"）。
  踩过一次：狼人的命中/击杀写 `saturation 2` / `saturation 5` 本意是"2 秒 / 5 秒"，实际只有 2 刻 / 5 刻，
  收益是 +2 饱食 +4 饱和 / +5 饱食 +10 饱和（换算与推导见 `02` §六）。
  要"秒"就得自己换算成刻；`saturation 20` 就已经是从零回满。
- **饱食度 / 饱和的换算**（源码 `FoodData` 实测，用于判断这类被动到底值多少）：
  4 点疲劳 = 1 点饱和（饱和为 0 时改扣 1 点饱食）；疲劳上限 40；
  快速再生门槛是**饱食 = 20 且饱和 > 0 且未满血**，每 10 刻回 `min(饱和,6)/6` 血并扣等量疲劳（⇒ **1 点血 = 1.5 点饱和**，每 0.5 秒最多 1 点血）；
  慢速再生只需**饱食 ≥ 18 且未满血**，每 80 刻回 1 血、扣 6 疲劳（**不要求饱和**）。
  所以"能不能续航"取决于饱食度能否保持在 18 以上，而不是饱和。
  疲劳来源：攻击 0.1 / 次、冲刺 0.1 / 米、跳 0.05、冲刺跳 0.2、游泳 0.01 / 米、挖方块 0.005、受击按伤害类型 0.1 或 0。
- **生羊肉 8 块 = 16 饱食（0.8 条）**：1 块生羊肉 2 饱食 + 1.2 饱和、吃一块 32 刻（1.6 秒）。
  狼人命中一次就给 2 饱食 + 4 饱和，**一次命中的收益已经 ≥ 吃一块生羊肉**——评估"食物稀缺"型职业时要按这个量级算。
- **两个职业共用同一种刷怪蛋时，各自只能靠自己的标记认那一份**：狼人的嗅闻令牌与驯兽师的狼蛋都是
  `minecraft:wolf_spawn_egg`。狼人靠蛋的 `EntityTag:{Tags:["kitpvp.werewolf_token"]}` 认刷出来的狼；
  驯兽师的蛋只有 `KitTamerEgg:1b` 标记（它没有使用侧逻辑），补货计数用 `clear ... 0` 带自己的标记数。
  两边因此互不触发、互不误杀 —— 别让任何一边改成"见 wolf 蛋就动手"。
- **有职业的"产物就是生物"时，清场方式要跟着改**：驯兽师放出的狼 / 马 / 鹦鹉… 不是令牌副产物，
  **不当场清**，在 `game/end` 先按 `kitpvp.tamer_wolf` 清召唤狼（避免结算延迟期间卸载），`game/reset` 与 `map/restore` 再次清理；按类型清理同时覆盖无 tag 的繁殖后代。
  按类型清必须带 `tag=!kitpvp.displayitem`，否则会把模板里的装饰动物一起清掉（见 §七）。
- **`game/reset` 的实体清理必须排在"回大厅"之前。** 正确顺序：清掉落物 / 召唤物 → `weather clear`
  → `lobby/enter` → `map/restore`。玩家一走，地图区块随时可能卸下（并写盘），实体随之离开世界实体列表，
  后面那些 `kill @e[...]` 就**静默什么也清不掉**。2026-10-16 实测踩到：驯兽师蛋放出的狼
  （`kitpvp.tamer_wolf`）在结算后仍留在西安地图里，下一局照旧在场上跑。
  查证方式：**1.17+ 实体单独存在 `saves/<世界>/entities/r.<x>.<z>.mca`，不在 `region/` 里** ——
  那只狼在 `entities/r.-3.-2.mca` 里还是活的，而该文件的写入时间正好是结算那一 tick。
  顺带一条好处：清理排在地图复原之前，也就不会误杀模板里带 `kitpvp.displayitem` 的装饰动物。
- **大厅的按钮 / 讲台触发走 `item_used_on_block` + `location_check`**（`advancements/player/lobby_launch.json`、
  `lectern_teleport_*.json`）：按钮自己的 `onUse` 返回 accepted，触发器一定会响，**与手里拿着什么无关**
  （举着大厅钓竿去按也不会算成钓竿使用）；`position` 写方块自身坐标（min = max）。
  **`blocks` 只能写显式 id 的数组**：写成字符串（`"#minecraft:buttons"`）加载期就报
  `Expected blocks to be a JsonArray`；写成数组里带标签（`["#minecraft:buttons"]`）报
  `Non [a-z0-9_.-] character in namespace of location: #m…`。两种都是**整份 advancement 被丢弃**、
  按钮点了毫无反应（2026-11-11 踩过：`latest.log` 里 `Parsing error loading custom advancement
  kitpvp:player/lobby_launch` 连刷 6 次，而方块本身确实是 `minecraft:stone_button`）。
  `tools/check.py` 现在拦这两种写法。
- **`location_check` 的 `position` 要包含"玩家自己站的那一格"**：起跳按钮的方块在 `(0,63,98)`，
  但玩家是站在它上面（脚在 `y=64`），只写 `y=63..63` 永远不匹配 —— 改成整列 `x -1..1 / y 62..66 / z 97..99`
  才触发（讲台那两份一开始就是 `y=63..66` 的宽盒子，所以没这个问题）。写这类判定时按"玩家可能站的格子"开盒，
  别只按方块坐标。
  另外排查这类按钮：
  ① 先看 `latest.log` 有没有 `Parsing error loading custom advancement`；
  ② 再挂一个**无条件**的 `item_used_on_block` 探针 advancement 打印一行，区分"触发器不响"和"条件不匹配"
  （2026-11-11 就是这样定位到是位置盒的）；③ 函数首行照例 `advancement revoke @s only ...`，
  `load` 里也对所有人清一遍，避免旧版本授过奖之后永不再触发。
- **给"高速路过某坐标"的玩家挂效果时，检测盒别做薄**：漂浮 47 的上升速度约 2.35 格/刻，
  盒子的 `dy` 小于这个值就可能整格跳过、效果永远不触发（起跳柱在 y=70 的检测盒特意给了 `dy=3`）。

---

## 六、死亡 → 重生的时序：被动与无敌必须等"真正重生"之后

**现象**：死亡后被动效果不再恢复（史莱姆的跳跃提升 III 没了、刺客的速度 I 没了），
`player/after_death` 给的 5 秒无敌也形同虚设；`/reload` 后重新选职业一切正常，
很容易被误判成"偶发"或"重载就好了"。

**根因**（原版 `ServerPlayer#die()` 递增 `deathCount`，Paper/Spigot 对该行的补丁可佐证）：

1. `minecraft.deathCount` 在**死亡那一 tick** 的 `die()` 里递增；而 `tick` 函数标签就在同 tick
   末尾执行，于是 `death_dispatch` → `on_death` → `after_death` 全在**玩家还处于死亡状态**时跑完。
2. 重生**不是服务端主动做的**：`doImmediateRespawn=true` 时由客户端收到死亡后回发重生包触发，
   服务端要**晚至少 1 刻**才经 `PlayerList#respawn` 重建玩家。
3. 重建玩家时**药水效果整个被清空**——`keepInventory` 保的是背包，效果不在保留之列。
4. 于是"死亡当刻挂上的效果"会在下一 tick 被重生清掉，等于没挂。

**正确写法**：拿"玩家还没活过来"当闸门，把 `player/after_death` 推迟到真正重生之后：

```mcfunction
execute as @a[tag=kitpvp.respawn_pending,tag=!kitpvp.spectator] unless entity @s[nbt={Health:0.0f}] run function kitpvp:player/after_death
```

**要点**：

- 死亡状态下 `Health` 恒为 `0.0f`（`LivingEntity#setHealth` 把下限钳到 0），
  所以 `nbt={Health:0.0f}` 判"仍在死亡状态"是可靠的。
- **不要**改用 `schedule function kitpvp:player/after_death 1t`：`schedule` 调起的函数执行者是
  服务端而不是玩家，`@s` 会失效，被动会挂到错误对象上。
- `respawn_pending` 必须由 `after_death` 自己摘掉（保证只跑一次）；它在死亡期间还顺带屏蔽了
  `death_dispatch` 的重复触发，这两件事不能拆开。
- **凡"死亡后要重挂"的东西（被动、无敌、状态）一律加进 `player/after_death`**，由这条闸门统一
  保证时序；不要写进 `player/on_death` 或其它死亡当刻的分支。
- 死亡时只有 1 条命的职业（幽灵）不会走到这里——死亡即淘汰、变旁观，
  `after_death` 的 `tag=!kitpvp.spectator` 守卫会把它挡掉，属正常。

---

## 七、地图复原（`place template`）

1. **模板必须随仓库提交。** 文件在 `src/data/kitpvp/structures/<名字>.nbt`，
   `map/*/restore` 里的 `place template kitpvp:<名字>` 靠它。
   ⚠ 这一行**解析失败**（模板名打错、行首混进全角字符/BOM、写坏的半行）不是"运行时报错"，
   而是**整个 restore 文件在加载期被丢弃**：聊天里毫无提示，只有日志（见 §十），
   表现为"地图没复原、装饰实体越积越多"。实际已经踩过一次（2026-10-14 凌晨沙漠
   restore 的 line 7）。`python tools/check.py` 会核对模板文件是否存在，
   但拼错名字只有 `tools/scan_logs.py` 能查。
   新增地图 = 加模板文件 + 加 restore 函数 + 在 `map/restore` 里加一行分派。

2. **七张地图的拼块尺寸一致：全是 48×48×48。**

   | 地图 | 拼法 | 放置原点 y |
   |---|---|---|
   | arena | 3×3（x/z 相隔 48） | 65 |
   | earth | 2×2 | 81 |
   | xian | 1×2 | 62 |
   | desert | 2×2 | 72 |
   | snow | 2×2 | 96 |
   | mansion | 三块 48³（6651 60 -46 / 6651 61 2 / **6621 61 -47 西翼**） | 60 / 61 / 61 |
   | cobblestone | 3×3（x 每列 +48、z 每行 +48，起点 -58 57 -5046） | 57 |

   mansion 的两块**不是同一 y**（第一块 60、第二块 61），是这座建筑本身跨层导致的，与沙漠那 1 格偏移同理，不要"修正"。

3. **模板只存方块；复原时先清空区域所有实体，再用 `summon` 一条条摆回来。**（2026-11 起的硬性规范）

   固定三步，别自己发明顺序：

   ```mcfunction
   kill @e[x=6621,y=60,z=-47,dx=127,dy=96,dz=98]  # ① 清空这张图范围内的一切实体（玩家不受影响）
   # ② 方块回滚。顺序有意义：mansion3（西翼 6621 61 -47）和 mansion1 在 x 6651..6668 上重叠 18 格，
   #    两块重叠区内容不同，而世界与 mansion1 一致 ⇒ 先放 3 再放 1，让 1 覆盖重叠区
   place template kitpvp:mansion3 6621 61 -47
   place template kitpvp:mansion1 6651 60 -46
   place template kitpvp:mansion2 6651 61 2
   function kitpvp:map/mansion/decor               # ③ 实体一条条摆回来
   ```

   - **导出**：结构方块关掉「包含实体」，模板里只留方块。
   - **① 的清场范围必须覆盖全部模板的并集**：desert 是 2×2 块，用 `x=-382,y=72,z=-97,dx=96,dy=96,dz=96`；
     只清单块会让其余三块的旧实体留在原地。
   - **③ 的 `decor.mcfunction` 由工具生成**，不要手写四十几行：

     ```
     python tools/nbt_tool.py emit-entities <模板.nbt> <out.mcfunction> --origin <x> <y> <z> [--decor]
     ```

     - 坐标 = 模板内的**相对** `pos` / `blockPos` **+ 放置原点**。模板 NBT 里自带的 `Pos`、`TileX/TileY/TileZ`
       都是**导出时的绝对值**，直接抄只在这一个位置成立，所以工具一律用相对值加原点。
     - 字段走**白名单**：每个实体类型只写该写的（盔甲架写 `Pose/Small/ShowArms/HandItems/ArmorItems`，
       挂件写 `Tile*/Facing/Item/variant`，船与矿车写 `Type/Items`）。**绝不能带 `UUID` / `Motion` /
       `Air` / `OnGround` / forge `Attributes`**：`UUID` 重复会让 `summon` 直接失败，forge 属性写错也让整行失败。
     - `--decor` 顺手给 画 / 展示框 / 盔甲架 加 `Invulnerable:1b` 与 `kitpvp.displayitem`
       （`reset` 里按类型清的行都带 `tag=!kitpvp.displayitem` 守卫，没这个 tag 的装饰每局会被误杀）。
   - 已有实例：`map/mansion/decor`（49 个：6 盔甲架 / 4 船 / 1 矿车 / 38 画）、
     `map/desert/decor`（36 个：26 展示框 / 6 发光展示框 / 3 盔甲架 / 1 箱子矿车）。
     cobblestone（君士坦丁堡）没有 decor：导出时就没带实体，模板里唯一的实体是导出角点上的
     `structure_block`，已按 §七.4 剥掉，复原只有「清实体 + place」两步。
   - ⚠ 模板里常有建设时掉的 `minecraft:item`（例：desert3 里 6 个）。**不要摆回来**：它们 5 分钟就自己消失，
     还会被 `util/clear_item` 扫掉，摆了也是噪音。

4. **老模板里带的实体要剥掉，用 `tools/nbt_tool.py`。**
   `strip-entities` 清空实体、`strip-paintings` 只清画；两者都会打印"方块数与调色板是否不变"。
   改模板前先跑 `roundtrip` 自证"解析再写回与原文逐字节一致"——写坏一个 4MB 模板很难发现。
   已处理：mansion1 / desert1..4 全部 0 实体（2026-11），方块 110592 与调色板 386 项不变。

5. **画为什么尤其不能进模板（补充原因）。**
   画带 `TileX / TileY / TileZ`（挂在哪面墙上）与 `facing`；`pos` 只是中心浮点值
   （`27.96875 = 27 + 31/32` 是贴墙那 1/32 的内缩）。`place template` 只按 `pos` 平移实体，
   **画的贴附锚点仍取那三个绝对值**，于是换原点 / 旋转 / 镜像 → 所有画一起去挂"旧坐标"，整体错位；
   多格画（2×1 / 2×2 / 4×4）中心不同，即使角点一致也会各自差一点。
   参考数据：mansion1 曾带 38 幅画，`Tile − (6651,60,-46)` 与模板内 `blockPos` 全部吻合，照样不可靠。

6. **出生点的编号顺序 = 玩家实际挨着的顺序，要按"相邻尽量远"排。**
   `map/*/pass` 是按编号顺序把玩家依次塞进 spawn_1 → spawn_2 → … 的（`#cur` 只是决定从哪一号开始），
   所以**编号相邻的两个点，就是最可能同时站在场上的两对**；玩家给的坐标清单不要照着原顺序贴。
   雪原的 6 个点就是这么排的：环上任意相邻一对（含 6→1）都 ≥ 36 格，而原始清单里最近的 E-F 只有 12 格、
   A-B 只有 17 格。新地图排序时照抄这个做法（穷举 n! 让"最短相邻距离"最大即可）。
   君士坦丁堡的 7 个点同样处理：原始清单里 A-F 只有 22.2、D-E 只有 25.2，重排成
   A→B→E→C→F→G→D 后环上最短 46.6 格（`map/cobblestone/spawn_1..7` 的注释里记了编号对应哪个点）。

---

## 八、弹药类技能的三个坑

### 8.1 别用自制计数器记数量，用 `clear ... 0` 读真实背包

`kitpvp.ender_ammo` 原来是"给一颗 +1、投一颗 -1"的自制计数器，**会和真实背包漂移**：
珍珠掉在地上、背包满时 `give` 落在脚下没捡到、玩家把珍珠丢给别人……
计数器照加不误。一旦虚高到上限（3），补货条件 `ammo <= 2` 永不成立，
**表现就是"到后面一颗都不补"**，且玩家自己完全看不出原因。

正确做法（1.20.1 可用）：

```mcfunction
scoreboard players set @s kitpvp.ender_ammo 0
execute store result score @s kitpvp.ender_ammo run clear @s minecraft:ender_pearl{KitEnderPearl:1b} 0
```

`clear <目标> <物品>{<nbt>} 0` 的 `maxCount=0` **只计数、不真清除**，返回值是匹配到的
物品**总数**（含堆叠数量）。第一行必须先归零：目标没有匹配物品时命令失败、不写分数，
不归零会留下上一刻的旧值。用这个读法，补货判据永远是"背包里现在真有几颗"。

### 8.2 "投出 / 射出"这种瞬时动作：用状态翻转检测

主动技能靠 `used > last` 统计触发，但**"发射"这个动作没有对应统计**：
`minecraft.used:minecraft.crossbow` 会把"装填"也算进去，而
`minecraft.used:minecraft.firework_rocket` 根本不会因弩发射而增长。

可用的办法是**状态翻转**：每刻重建"手持物品处于某个状态"的 tag，
再和上一刻的 tag 比较，从"有"翻到"无"就是那次动作发生了。

```mcfunction
tag @a remove kitpvp.pirate_charged_prev
tag @a[tag=kitpvp.pirate_charged] add kitpvp.pirate_charged_prev
tag @a remove kitpvp.pirate_charged
scoreboard players set @a[scores={kitpvp.kit=9}] kitpvp.tmp 0
execute as @a[scores={kitpvp.kit=9}] if data entity @s SelectedItem.tag.KitCrossbow store result score @s kitpvp.tmp run data get entity @s SelectedItem.tag.Charged
execute as @a[scores={kitpvp.kit=9,kitpvp.tmp=1..}] run tag @s add kitpvp.pirate_charged
execute as @a[tag=kitpvp.pirate_charged_prev,tag=!kitpvp.pirate_charged,scores={kitpvp.kit=9,kitpvp.alive=1},tag=!kitpvp.spectator] if data entity @s SelectedItem.tag.KitCrossbow run function kitpvp:skill/pirate/fire
```

两个要点：

- **判"还在手持"**：最后一行再查一次 `SelectedItem.tag.KitCrossbow`。
  否则玩家"把已装填的弩切到别的槽"也会被当成射击。
- **`Charged` 必须比"值"，不能判路径**：1.20.1 里发射后游戏写回 `Charged:0b`
  ——**键还在、值为 0**。`if data entity @s SelectedItem.tag.Charged` 永远为真，
  检测会完全失效。这里用 `data get` + `execute store result` 读出字节值再比 `1..`。
  （同理适用于任何 `0b/1b` 开关字段，见 07 的"只判路径存在，不判值"。）

### 8.3 同一种弹药不能同时存在两处

海盗的"换弹"原来只 `clear` 背包里的火箭，**清不到已经装进弩里的那发**
（它在 `ChargedProjectiles` 里）。于是"装填一发 → 再换弹"能同时持有
"弩里 1 发 + 背包 1 发" = 2 发，平均射速直接翻倍。

规则：**发放前先确认这种弹药是不是已经"以别的形态"存在**。
现在换弹用 `clear @s minecraft:crossbow{KitCrossbow:1b,Charged:1b} 0` 数一下
"已装填的手炮"，数量 ≥ 1 就视为已有弹药、不再补发。

反过来说，只把冷却挪到"射出一发"并不能堵住这个洞——积攒发生时冷却还是 0，
照样能换弹。**冷却管节奏，去重管上限，两件事要分开修。**

---

## 九、属性修饰符要按"基础值"折算

**约定：口述与文档里的"攻击伤害 N"一律指实际造成的伤害。** 卡片（`06`）填的也是实际值。

但写物 NBT 的 `AttributeModifiers` 时**不能直接填这个数**——修饰符是**加法叠加在玩家基础值上**的，
物品提示显示的也正是"基础 + 修饰符"的合计（"铁剑 = 6"即 1 + 5，不是铁剑自带 6）。

| 属性 | 玩家基础值 | 想得到实际值 N 就写 |
|---|---|---|
| `generic.attack_damage` | **1** | `N - 1`（实际 8 → 写 `7.0`） |
| `generic.attack_speed` | **4** | `N - 4`（实际 1.0 → 写 `-3.0`） |
| `generic.armor` | 0 | 直接写 `N` |
| `generic.armor_toughness` | 0 | 直接写 `N` |

基础值来源：`PlayerEntity.createPlayerAttributes()` 里 `GENERIC_ATTACK_DAMAGE = 1.0`、
`GENERIC_ATTACK_SPEED = 4.0`；护甲/韧性为 0（`util/clear_player` 也把它们 base set 回 1 / 4 / 0）。

**已踩过一次**：海盗的钻石斧原来写 `Amount:8.0`，实际打出 9，与卡片写的 8 差 1。
现在写 `7.0` → 实际 8。各职业现状（卡片值 = 实际值）：

| 职业 | 武器 | 写法 | 实际 |
|---|---|---|---|
| 海盗 | 钻石斧 | `Amount:7.0` + 攻速 `-3.0` | 8 / 攻速 1.0 |
| 渔夫 | 三叉戟 | `Amount:6` + 攻速 `-3` | 7 / 攻速 1.0 |
| 里·渔夫 | 三叉戟（激流 I） | `Amount:4` + 攻速 `-3.0` | 5 / 攻速 1.0 |
| 幽灵 | 金斧 | `Amount:7.0` + 攻速 `-2.9`（不带附魔） | 8 / 攻速 1.1 |
| 水星 | 石剑 | `Amount:4.0` + 攻速 `-2.0` + 最大生命 `-10.0` | 5 / 攻速 2.0 / 生命 10 |
| 其余职业 | 用武器默认修饰符（不写 `AttributeModifiers`） | — | 铁剑 6、石剑 5、木剑 4 … |

**顺带一条**：写了 `AttributeModifiers` 就**整体取代**该物品的默认修饰符，
所以攻伤与攻速必须写全（不写就相当于没有），这与上面"要减基础值"是两件事。

**玩家身上的常驻修饰符**（不是挂在物品上的）用命令挂：
`attribute <目标> <属性> modifier add <uuid> <名字> <值> <op>`。
1.20.1 的 `<op>` 是 `add` / `multiply_base` / `multiply`（1.20.5 起改名为 `add_value` / `add_multiplied_base` / `add_multiplied_total`）。
这种修饰符**随死亡与重生保留**，所以选职业时挂一次就够；但**换职业时必须摘掉**，
否则会跟着带到别的职业。`util/clear_player` 里已经写了对应的 `modifier remove`（不存在时静默失败，不影响后续行）。
当前实例：水星的 `kitpvp.mercury_speed`（`00000000-0000-0000-0000-000000000066`，+0.2 → 基础 0.1 变 0.3）。

---

## 十、function 静默不加载：单实体参数的加载期校验

现象：技能**完全没反应**，聊天里连红字都没有。原因常常不是逻辑写错，而是
**那个 function 文件根本没被加载**。

1.20.1 在**加载期**解析整行命令，有些参数类型要求选择器"只能匹配一个实体"：

- `data get / merge / modify entity <单个实体>`
- `attribute <单个实体> ...`
- `spectate <单个实体>`

`@e[type=...,name="..."]` 不带 `limit=1` 时会在加载期直接抛
`IllegalArgumentException: 只允许一个实体，但提供的选择器允许多个实体`，
于是**该文件整份被丢弃**（同文件里其它行也一起失效），但包照常可用：
其它 function 都正常，调用它的地方（tick 里的 `function ...`）只是安静地什么都不做。

不要靠"记得加 `limit=1`"，直接写成单实体语义最稳：

```
execute as @e[type=...,name="..."] run data merge entity @s {Size:1}
```

同一类"整份文件被丢、聊天里还看不出原因"的还有两种，都长得像排版问题：

- **行首空格。** `.mcfunction` 的命令行要顶格写。缩进对命令没有任何好处，而加载期对行首空白不保证容忍——
  一旦解析失败就是整份文件被丢掉（症状与本节一致：调用处只报 `Unknown function`）。行尾空白则是安全的。
  改别人的函数时顺手检查一下行首，这种事肉眼很难看出来（雪原的 `map/snow/restore` 就被人手动缩进过一次）。
- **行内 JSON 折行 / 漏引号。** `tellraw` / `title` 里的文本组件被真回车折断、或 `"text":` 后面漏了起始引号，
  同样让整份 `.mcfunction` 不加载。文案池的批量修法见 `04` §十三 与 `tools/normalize_noise.py`。
- **`scoreboard objectives add` 的 criteria 多打一个冒号。** 统计类条件必须是 `minecraft.used:minecraft.<物品>`
  （`used:` 之后是 `命名空间.物品`，只用一个冒号）。写成 `minecraft.used:minecraft:mooshroom_spawn_egg` 会在加载期抛
  `Non [a-z0-9/._-] character in path of location: minecraft:minecraft:...`，把**整份 `load.mcfunction` 丢掉**——
  症状是全包 objectives / gamerule / 初始分全部没建，但游戏照常能进，很容易误判成"某段逻辑没生效"。
  2026-11-15 实际踩过（里农夫的两个统计条件），`tools/check.py` 现在会扫这类多冒号写法。

### 10.1 排查方式：直接读世界日志

聊天和控制台都不会提示，只能看日志。本机世界 `datapacks/kitpvp` 是指向
`D:\mc-kitpvp\src` 的 junction，游戏读的就是工作区本体，所以加载错误能直接从日志里读：

```
D:\Minecraft\.minecraft\versions\1.20.1-Forge_47.4.4\logs\<日期>-N.log.gz / debug-N.log.gz
```

搜 `Failed to load function kitpvp:`，紧跟其后的那行就是
`Whilst parsing command on line N: 原因`。

**N 就是文件的真实行号（注释和空行都算）**——已用 `core_fire` 的 `line 3` 验证过。

另一类**同症状但不同病因**的加载期死法：**行内 JSON 语法错**。最常见的是把**裸换行**（真按了回车）
写进了文本组件字符串里，或漏写转义的双引号。效果一样——整个函数文件被丢掉、包照常可用，
调用处只报 `Unknown function`。所以贴长文案时，多行只能写 `\n` 两个字符（见 `02` §7.2）。

排查命令：`python tools/scan_logs.py`（读日志，列出版本+行号+原因+当前源码行；
旧日志可能来自已改动的版本，源码行只是参考）与 `python tools/check.py`
（静态查"模板引用不存在""单实体参数用了多实体选择器"这两类加载期错误）。

---

## 十一、出生点被水（或方块）占住 → 玩家重生在主大厅

**现象**：里·渔夫反复放水球之后，有人死亡会出现在**主大厅**，而不是竞技场里自己的出生点。

**根因**：`/spawnpoint` 是以 `forced=true` 写入的，所以普通出生点走的是
1.20.1 `PlayerEntity#findRespawnPosition`（由 `PlayerManager#respawnPlayer` 调用）的这个分支：

```java
} else {
    boolean bl  = block.canMobSpawnInside(blockState);                    // 出生点那一格
    BlockState above = world.getBlockState(pos.up());
    boolean bl2 = above.getBlock().canMobSpawnInside(above);              // 出生点正上方那一格
    return bl && bl2 ? Optional.of(...) : Optional.empty();
}
// Block#canMobSpawnInside = !state.isSolid() && !state.isLiquid()
```

也就是说：**出生点那一格与它正上方那一格，都必须"既非固体、也非液体"**。水是液体 ⇒ 判定失败
（玩家自己垫的方块同样会让它失败）。失败时 `respawnPlayer` 用 `server.getOverworld()` 重建玩家，
落点就变成主世界出生点，也就是主大厅 `0 64 0`。

**兜底做法**：分配出生点时在出生点上留一个隐形 marker 锚点（`map/<地图>/spawn_N` 里的
`summon minecraft:marker`，带 `kitpvp.spawn_anchor` + `kitpvp.spawn_anchor.N` 两个 tag），
玩家侧记一个 `kitpvp.spawn_slot` 编号；重生时 `player/after_death` 调 `player/spawn_anchor`，
按编号把自己 `tp` 回锚点。这样"出生点那一格是什么"就不再影响结果。

**要记住的**：

- 锚点是**实体**，必须每局重建：`map/distribute` 开头先清掉旧的（否则会把人送回上一张图的坐标），
  `game/reset` 再清一次（结算白名单，见第一节）。
- `player/spawn_anchor` **不写守卫**：1.20.1 没有 `/return`（见 `game/start` 顶部注释），
  而每行自带 `if score` + `at @e[...]`，编号不匹配或锚点已被清掉时自己就静默不执行，
  不会把玩家 `tp` 到奇怪的地方。用 `return` 的写法会让整个文件在 1.20.1 里不加载（见第十节）。
- 编号只到该地图的出生点数量（arena / desert / earth 各 9 个，xian 6 个），
  所以 xian 上 `matches 7..9` 那几行不命中，属正常。
- 出生点干燥时原版重生本来就成功，这条兜底只是把落点对齐到锚点（差 0.1 格），玩家察觉不到；
  它真正生效的场景就是上面那条判定失败。
- 水球之外的同类风险：**任何落在出生点或其正上方的固体方块**（玩家垫的方块、掉落的结构）
  同样会把重生打回大厅，兜底对它一样有效。

---

## 十二、"免疫一切状态效果"这类被动，会连本包自己的效果一起清掉

太阳（kit 65）的被动是每刻 `effect clear @s`（见 `skill/sun/passive`）。这种"清空自己效果"的写法有三个连带伤害，
被清掉的都不是敌人给的 debuff，而是本包自己维护的机制：

1. **无敌**（`player/invincible`）用的就是抗性 V。清效果会把 5 秒保护一起清掉，太阳比别的职业少 5 秒保护。
   做法：清完后按 `kitpvp.inv` 补回 1 秒（`effect give @s minecraft:resistance 1 4 true`）。
   补 1 秒而不是 5 秒——清效果每刻都在跑，1 秒足够接上；最后那 1 秒余量由
   `player/end_invincible` 的 `effect clear @s minecraft:resistance` 收掉，否则无敌会被悄悄延长。
2. **结算期封锁**（`game/end` 给全体的抗性 V）。清掉它，太阳在结算的 10 秒里还能被打死。
3. **大厅的饱和**（tick 的 lobby 段每刻给 `saturation 1`）。清掉它，太阳在大厅会掉饱食。

第 2、3 条用同一个办法解决：**把清效果限定在 `#state=1`（游戏进行中）**。

**要记住的**：

- 写"免疫 / 净化"类被动前，先 grep `effect give @a` 和本职业会收到的 `effect give @s`：
  会一起被清掉的东西里，往往有保护与秩序。
- 1.20.1 没有"只清某几个效果"的写法：`effect clear @s <效果>` 清的是**该效果的所有等级**。
  想保留某个效果只有两条路——**清完再补**（无敌就是这条），或者干脆别用清空式写法。
- 连带效果还有：**突然死亡的"全体发光"照不到太阳**（`game/sudden_death_start` 的 `effect give @a glowing`），
  以及任何给太阳的增益立刻失效（里·战士的狂战士药水、魂石类效果等）。
  这是"免疫一切效果"的必然结果，不是 bug。

---

## 十三、约定：`skill/sun/noise/` 是纯文案池，不要读

`src/data/kitpvp/functions/skill/sun/noise/1..128.mcfunction` 是太阳"短波通信干扰"的随机文案池，
**一份文件就是一帧**（4 行文本 + 1 行 `playsound`）。

- **不要读它的内容。** 它只为随机刷屏存在，读它没有任何决策价值，只会白白吃掉上下文。
  要确认某个槽位在不在，看 `01-file-structure.md` 的目录树就够。
- 要**改**某一帧：只改那一个文件（字数与换行 / emoji 的写法见 `02` §7.1、§7.2），
  不要为了"看一眼格式"把 128 个文件都读一遍。
- 池子容量与刷新节拍在 `skill/sun/noise_pick` 与 `skill/sun/flare_tick`（账本见 `07` 的 `#noise_count` / `#noise_step`）。
- **整池改配色 / 批量修粘贴破损**用 `tools/normalize_noise.py`（只动格式不动文字：接回被裸换行折断的行、
  补 `"text":` 漏掉的起始引号、转义文字里裸的半角引号、去掉文末多余空行、按槽位轮换 6 套亮色 + 主标题加粗）。
  手写文案贴进来最常坏在两处：① 文字里带了真回车 → 一行 JSON 被折成两三行；② `"text":` 后面漏开引号。
  两者都会让**那一份 `.mcfunction` 整份在加载期被丢掉**：症状是那几帧永远不刷，而 `check.py` 只报 JSON 不合法、tick 不报错。

---

## 十四、未加载区块里的实体：看不见、杀不掉、会被当成"不存在"

三件表面上无关的事是同一个根：**命令里的 `@e` 只看得见已加载区块里的实体**。区块一卸，实体还在区域文件里，但所有选择器都选不到它。

### 14.1 金星两条舔狗

`dog_alive_check` 用 `@e[tag=kitpvp.venus_dog]` 判断"狗还在不在"。狗被留在没加载的区块时（主人死亡重生、开局跨区传送），这里读到 0 → 30 秒后又召一只 → 老狗所在区块重新加载时两只并存。
三条一起上才修得住：

- `tick` 每刻调 `skill/venus/dog_follow`，把 12 格外的狗拉回主人身边：狗始终待在主人所在区块，就压根掉不了队；
- `player/after_death` 重生后立刻再拉一次，堵住"跨区传送那一瞬"；
- `summon_dog` 生成前先按 `dog_owner` 清掉同号的可见残留（幂等闸门）：复活计时误判也不会叠出第二只。

配套改的是归属编号：原先 1..6 循环复用，玩家换号后旧狗仍在，且第七名玩家会绕回 1 与第一名同号；现在**每选一次金星就领一个新号**，只增不复用。
另外，狗**没**做成"一次性技能"：开局直发解决不了"死了之后 30 秒复活"，而真正的病根是跟随断了。

### 14.2 驯兽师狼留到下一局

`game/reset` 的 `kill @e[tag=kitpvp.tamer_wolf]` 排在玩家回大厅之前，狼会被主人"跟着传送"带进走廊，那一刻已经过去了。
现在三处扫：`game/end` 结算当刻一次；`game/reset` 末尾 `schedule game/wolf_sweep 20t`，在大厅状态（`#state=0`）连扫 4 轮；`game/start_impl` 开头按 tag 再扫一次兜底。
仍挡不住的只有"整局都没再加载过的区块里的狼"——纯数据包除了 `forceload` 没有别的手段能碰到它。

### 14.3 iLsacuL 尸体爆炸

`kill` 只作用于选得到的实体。落在未加载区块的猪带着"没死透"的状态存进区域文件，下一局 `apocalypse` 逐刻重跑（它按 tag 每刻引炸），苦力怕越积越多。
专用清除 `game/li_purge` 的顺序是硬性的：**先关自爆开关**（`#liapoc` / `#litimer` / `#licount`）→ 再 `tp @e[tag=kitpvp.li_pig]` 到一名玩家身上（那段区块必然加载）→ 再 `kill` → 最后 `schedule game/li_purge_verify 1t` 隔刻复核，最多 6 轮，清不干净会 tellraw 警告。
调用点：`game/end`（结算同时，玩家还在图里）与 `game/reset` 开头（覆盖结算到重置这 10 秒里新放的蛋）。

### 14.4 由此得出的通用结论

- 凡是清场，`kill` 必须排在玩家传送之前；传送之后写什么 kill 都可能静默落空。
- 会被玩家"随身带走"的实体（宠物、坐骑、跟随的召唤物）只有两条活路：**每刻跟随**，或在**传送那一刻补拉**。
- 判"某只召唤物还在不在"时，别拿"看不见"当"不存在"——宁可先跟随保证它看得见，也不要靠定时补发兜底。
- **凡是要「判死」的机制，都要给宽限**：冥王星（kit 76）的鹦鹉一死本体就得死，但跨区传送那一两刻 `@e` 也选不到它，立刻判死 = 进图白死一条命。现在用 `kitpvp.parrot_miss` 数持续缺失的刻数，缺满 6 刻才判死，中途找到就清零（2026-11 实测踩到，详见 `06 §76`）。

---

## 十五、队槽编号不能跨局留用

`ghost_1..6` / `turret_1..6` / `ttamer_1..6` / `earth_1..6` 四套队槽的编号记在玩家分数上（`tid` / `ttid` / `ttamer_tid` / `etid`），
只在 `load`（重载数据包）时清零是不够的：同一台服务器连开多局，`#ghost_tid` / `#ttamer` / `#ttid` 这些游标会一路加下去，加到 7 就 `matches 7..` 回绕到 1，**第七个用该职业的玩家会与第一个同号**，两人进同一个 `team`，彼此的召唤物从此互不攻击。

- 修法：`game/start_impl` 每局开头 `team leave @a` + 清空四个编号与三个游标。
- 一次 `team leave @a` 就够：一名玩家在四套队槽里只可能占一套，不必逐队 `team leave @a[team=xxx]`。
- 队内 `friendlyFire` 默认 **true**，同队玩家之间仍然可以互相伤害；真正被破坏的是"召唤物不攻击自己人"的归属判定——这才是唯一需要修的东西。

### 15.1 由此引出的第二个坑：清零之后没人再分配（里·弓箭手炮台打主人）

**现象**（2026-11-05 实机一次）：里·弓箭手放下的炮台会朝主人射箭。

**机制**：职业是在大厅里选的，`kit/tainted_archer` 那时就把 `ttid` 分配好了；随后开局进 `game/start_impl`，
按上面的修法 `scoreboard players set @a kitpvp.ttid 0` —— 分配结果被清掉，而**本局没有再分配**。
于是部署炮台时 `turret_fire` 里那 6 行 `team join turret_N @s` 一行都不命中（`ttid=0`），玩家和炮台都没进队，
骷髅的目标筛选就没有同队豁免了。顺带 `turret_owner` 也全变成 0，多个弓箭手的"存在上限 3"会互相串。

**修法**：把"分配 + join 主人"抽成 `skill/tainted_archer/team_slot`，`kit/tainted_archer` 和
`skill/tainted_archer/turret_fire` 都调它；部署时若 `ttid=0` 就现场补发一个。凡是"大厅里分配、开局被清空"的
编号都要按这个模式检查一遍：**清空的那一刻之后，必须有地方能在使用时重新分配**。

### 15.2 魂石 / 道具召唤的"友方"绝不改主人自己的队（2026-11-15 审计）

一名玩家**同一时刻只能属于一支队**。所以"用某个道具召唤一只友方生物"如果顺手把主人 `team join` 到道具自己那套队，
主人原本的召唤物（炮台 / 阴兵 / 生灵 / 起义军）就留在旧队里，**立刻变成敌人**。

正确写法：先查主人现在在哪套队，**有队就沿用**，没有队才开一个自己的槽（这也是唯一允许换队的时机）：

```
function kitpvp:util/team_index           # 36 行逐队比对，结果压进 #steam（0 = 不在任何队）
execute if score #steam kitpvp.game matches 0 run function .../team_slot   # 只有没队时才分配
# 召唤物在 NBT 里带 kitpvp.team_new，召唤完调一次：
function kitpvp:util/team_join            # 把 team_new 加进 #steam 那套队，并摘掉临时 tag
```

**审计结果（六套队 × 6 槽，编号 1..36 = 幽灵 / 炮台 / 里·驯兽师 / 地球 / 炸弹兵 / 里·农夫）**：

| 系统 | 友方判定 | 结论 |
|---|---|---|
| 幽灵阴兵 | team | 原实现会把主人塞进 `ghost_N` → 已改成"有队沿用" |
| 里·农夫起义军 / 农夫魂石 | team | 原实现会把主人塞进 `farmer_N` → 已改成"有队沿用" |
| 地球魂石生灵 | team（`#steam`） | 原来只认 4 套队（1..24），主人在炸弹兵 / 里农夫队时生灵会敌对他 → 扩到 36 |
| 炮台 / 里·驯兽师 / 地球 / 炸弹兵 | team | 本来就在"使用时分配 + 同时 join 主人与被召唤物"，✓ |
| 驯兽师 / 金星魂石 / 驯兽师魂石的狗 | 原版 `Owner` UUID | ✓ 与队伍无关 |
| 火星魂石的巨人 | 敌对所有人（地鸣原味） | 设计如此 |
| 李朱俊泽的 iLsacuL 复制体 | 复制父体的队 | ✓ |

**新增队槽时**：`load` 里 `team add` → 重跑 `out/gen_team_files.py`（生成 `util/team_index` 与 `util/team_join`）
→ `skill/soul/earth_step` 里补 6 行映射。

---

## 十六、蓄力类机制：跳跃提升只有一格、起跳时还按着 Shift

里·史莱姆的"蓄力火箭跳"（`skill/tainted_slime/charge`）踩到的六条，凡"按住某键累积、松手 / 起跳结算"的机制都适用。

1. **不要给常驻效果做每刻补**：`effect give` 只在"新等级更高"或"同等级且更长"时覆盖，同一个效果只有一个槽。
   魂石 / 表史莱姆的跳跃提升 III 只在挂上时发一次；蓄力档位本身每刻按当前档位重挂 4 秒即可。
2. **起跳那一刻玩家还按着 Shift**：只判"松手"会漏掉起跳，必须再加一条
   `unless entity @s[nbt={OnGround:1b}]`。归零排在效果结算之前不要紧——上一步挂的 4 秒效果正好给这一跳用。
3. **1.20.1 没有现成的"在地面 / 在下蹲"查询**：下蹲走 `entity_properties.flags.is_sneaking` 谓词
   （`predicates/sneaking.json`），落地走玩家 NBT `OnGround:1b`（玩家存档里确实是这一位）。
4. **满蓄力的音效要有一次性开关**：蓄力值停在 60 时每刻都经过同一个判定，只写 `matches 60` 会每刻重播。
   用 tag（`kitpvp.rocket_full`）记"已响过"，蓄力值回落时摘掉；死亡重生（`player/after_death`）与
   `clear_player` 也要摘，否则同一条命里再也听不到。
5. **`matches` 不接受逗号列表**：`matches 13,25,37` 会让**整份函数在加载期被丢掉**，
   游戏里的表现是"完全不触发"、聊天栏也没有任何提示。多个值只能一行一个 `matches <值>`，
   或者用 `matches a..b`。排查入口：`logs/latest.log` 里的 `Failed to load function`。
   2026-11-11 的蓄力火箭跳就是这么整份没加载的。
6. **跳跃提升的时长要覆盖整段滞空，落地后再清**：跳跃提升每级减 1 点摔落伤害，所以蓄力效果不能只挂 1 秒——
   满蓄力一跳滞空约 2.4 秒，效果提前过期就是全额摔落伤害（2026-11-11 车主实测）。现在挂 4 秒。
   4 秒的尾巴会让人"落地还能白跳"，所以落地后的第一刻（玩家 NBT `OnGround:1b` + 上一刻在空中）由
   `skill/tainted_slime/land` 清掉跳跃提升：**命令跑在实体 tick 之前**，落地伤害在上一 tick 的实体阶段
   就按当时的效果结算完了，这一刻清不会少减伤。
7. **清效果要照顾"别的来源"**：`effect clear @s jump_boost` 不区分来源。落地清空后必须把常驻来源补回：
   表史莱姆（kit 10）重挂 `skill/slime/passive`；魂石的 III 由 tick 的"缺了才补 1 秒"（`predicates/has_jump_boost.json`）维持。
   临时来源（药剂师的跳跃药剂）会被一起清掉，属于可接受损失。

---


> **BOM 也算"行首混进字符"**：Windows PowerShell 5.1 的 `Set-Content -Encoding utf8` 会写 UTF-8 BOM，
> 游戏会把它当成首行命令的一部分，报 ` Whilst parsing command on line 1: 未知或不完整的命令 at position 0`，
> 整份 function 被丢掉。写文件只走 `write` 工具 / Python 的 utf-8（无 BOM）；`tools/check.py` 现在会扫 BOM。

## 十七、核弹：半径拉满只伤人不炸地形，但会清掉装饰实体

炸弹兵的核弹（`summon/bomber_nuke`）是一颗 `ExplosionRadius:63b` 的苦力怕，5 秒后爆炸（2026-11-11 从 127 收到 63：范围够用又不至于把整张图算进爆风）。

- **地形安全**：`mobGriefing` 已关（`load` 里写死），爆炸不改方块。
  假核弹是同一个召唤，只有 `ExplosionRadius:0b`——名字 / 血量 / 引信 / 黄字提示全一样，只响不炸。
- **伤害看掩体**：半径拉满后爆炸只在 16³ 个方向上做稀疏采样（步长按半径放大），
  所以"面对冲击波方向有掩体就几乎不掉血"；反过来，掩体不是绝对安全。
- **风险（2026-11-11 车主确认接受）**：爆炸仍然对实体结算，**没有 `Invulnerable:1b` 的装饰实体
  （物品展示框 / 盔甲架 / 画）会被清掉**。以后要根治就给地图装饰实体补 `Invulnerable:1b`，本次不动。
- **40 血**：`Health:40f` 必须和 `Attributes:[{Name:"minecraft:generic.max_health",Base:40}]` 一起写，
  否则会被原版上限 20 压回去。
- 核弹可以被提前打死（40 血）——这是给对手的拆弹窗口，别顺手改成无敌。


---

## 十八、部署形态：从「局域网 + 内网穿透」改成「租的 2G2核服务器」（2026-11-26）

只影响**运行环境**，不影响数据包本身；但下面几条以后排查问题时要想起来：

- **内存只有 2G**。常驻负担主要在实体上：地球生灵 / 起义军 / 陷阱师满图陷阱（掉落物也是实体）、
  混沌武器的掉落与清理、音乐引擎（`nbs_*` 是逐玩家分数）。**不要再无上限地加召唤物**；
  "玩家可自由摆放"的技能（陷阱师这种），上限要么低、要么按玩家人数收敛。
  JVM 建议 `-Xms2G -Xmx2G`，别让堆外和系统抢同一份内存。
- **2 核**。tick 预算比本地紧：`tick/slow2` 与 `slow4` 分层的意义在这里放大——
  往每刻车道加东西前，先想清楚能不能降到 2/4 刻跑。
- **远端玩家延迟高**。依赖"同一 tick 内命中→结算"的手感会变差（烛之武那种 1 刻窗口、
  马斯地鸣的 3.2 格近似命中），这是网络不是 bug，别照着本地手感反复调数值。
- **同步不再是"改完即生效"**。以前 `saves/.../datapacks/kitpvp` 是指向 `D:\mc-kitpvp\src` 的 junction，
  `/reload` 直接吃到改动；现在服务器在远端，流程变成
  **改 `src` → `git push` → 服务器拉取（或手工传包）→ `/reload`**。
  每次上线前都要显式确认"远端拿到的是最新提交"（`git log -1` 对一下）。
- **日志在远端**。`Failed to load function` 这类静默失败只能去服务器 `logs/latest.log` 看；
  本地测试服（`D:\mc-test-server`）继续负责"提交前验证"，别拿生产服试错。

---

## 十七、2026-11 火星 / 混沌 / 音乐批次踩到的坑（务必先读）

> 这一节是"移植 1.12.2 机制到 1.20.1"时反复出现的同一类错误，新增职业前先对照一遍。

### 17.1 药水效果的 `Duration` 必须是整数
`CustomPotionEffects:[{Id:19,Amplifier:0,Duration:200}]` —— **不能写 `Duration:200b`**。
字节会溢出成 -56 / -144 之类，效果直接被丢弃。症状：**只有时长 <127 刻的效果生效**（当时只有 70 刻的漂浮箭有效）。

### 17.2 属性修饰符 `Amount` 是"玩家基础 1 + 增量"
实际 2 点伤害 = `{"generic.attack_damage",Amount:1,Operation:0}`。
写成 `Amount:-2` 会让武器总伤害变成 0 → **打谁都打不动、诅咒计数也不涨**（当时排查了很久）。

### 17.3 `@e[distance=..N]` 一定包含施法者自己
"命中瞬间取最近实体"这种近似判定，必须先把施法者打 tag 再 `tag=!...` 排除，否则永远命中自己（火星诅咒自己就是这么来的）。

### 17.4 统计型触发器的口径陷阱（本项目最大的坑源）
| 目标 | 口径真相 |
|---|---|
| `minecraft.used:minecraft.bow` | 数的是"拉弓"，**取消拉弓也 +1** → 弓的"射箭计数"不能用它；改数背包箭数（`clear @s minecraft:arrow 0` 只统计不清） |
| `minecraft.used:minecraft.crossbow` | **预装填弩**（`Charged:1b`）射击时**不涨**（`use` 返回 consume，不记 item_used） |
| `minecraft:shot_crossbow` advancement | 预装填烟花路径下**不触发** |
| 手炮（预装填弩）正确判定 | 谓词匹配 `SelectedItem.tag.Charged` 由 1 → 0（`predicates/chaos_xbow_charged.json`） |
| `minecraft.used:minecraft.trident` | 在**投掷出手那一刻**就 +1，此时手上已空 → 不能用 `SelectedItem` 判定；改用 give 时打的 `kitpvp.chaos_tri` tag |
| 三叉戟"最后一发" | 出手即扣会被 `chaos_wipe` 当场杀掉还在飞的实体 → 必须**待结算**（`chaos_tri_pending`，飞完/超时才扣） |

**红线**：凡是"用一次就算一次"的道具，先确认统计是否真在该动作时 +1，再决定用统计 / advancement / 谓词。

### 17.5 共享物品的统计目标：**先分清"只有本职业用"还是"别人也用"**
同一个 `minecraft.used:xxx_spawn_egg` 经常被两拨人共用。两条相反的处理，判据是"这个蛋除了本职业，别人会不会拿到"：

- **只有本职业会用**（职业令牌）：加 kit 闸门，否则"别的职业射一箭，混沌弓箭手就补魔法箭"。
  写法：`@a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=<N>},tag=!kitpvp.spectator]`。
  实例：`archer_shot`（弓）、`halley_used`（岩浆怪蛋）、`tainted_turret/core`（流浪者/烈焰人蛋）、`tainted_fisher_blue/domain`（鱿鱼蛋）、`bomb_used`。
- **本职业 + 魂石/别的技能也会用同一个蛋**：**绝不能卡 kit**，否则"非本职业拿到魂石完全没反应"（2026-11-16 实机：坦克魂石 / 刺客魂石在别的职业手里全哑）。
  改为**不带 kit 的入口 + dispatch 内部分流**：入口行只判 `tag=kitpvp.selected,scores={kitpvp.alive=1}`，
  dispatch 首行无条件推快照，再按载体 `tag`（首选）或 `CustomName`（次选）分两支：
  职业令牌分支里再写 `execute if score @s kitpvp.kit matches <N> ... run .../cast`。
  实例：`tank_used`（铁傀儡蛋：举盾令牌 + 坦克魂石）、`assassin_used`（末影人蛋：隐匿 + 刺客魂石）、
  `mars_domain_used`（恼鬼蛋：地鸣 + 幽灵魂石 + 里·驯兽师怨灵）、`soul_*` 系列。
- **分流用 tag 而不是中文名字**：名字跨控制台/编码易失真（`name=地鸣` 之类），tag 是 ASCII 且蛋的 `EntityTag` 已写好。
- **dispatch 首行必须无条件推进快照**（`operation @s xxx_last = @s xxx_used`），否则"用了别人的蛋"会积压，下次真用时提前触发。

### 17.13 「每刻 tp 贴身」的跟随物，别的玩家可能根本看不见（2026-11-26 实机）

冥王星（kit 71）的鹦鹉分身原本每刻 `tp @s ~ ~1.85 ~` 钉在本体头顶：
**本体视角正常跟随，其他玩家完全看不到这只鸟**（连 `CustomNameVisible` 的名字都没有），
而实体 NBT 里没有任何 `Invisible` —— 服务端一切正常，问题出在"每刻传送到玩家身上"这种跟随方式上。

佐证：玩家的旧经验是"**强行杀一次鸟再复活就正常了**"，本质就是让实体重新注册一次。

结论：**贴在某个实体身上的跟随物，用「骑」而不是「每刻 tp」**。
乘客随载具移动，所有客户端都会渲染，也不占用每刻的 tp 预算：

```mcfunction
# mount：@s = 本体
tag @s add kitpvp.pluto_self
execute as @e[type=minecraft:parrot,tag=kitpvp.pluto_parrot] if score @s kitpvp.parrot_owner = #ptid kitpvp.game run ride @s mount @e[tag=kitpvp.pluto_self,limit=1]
tag @s remove kitpvp.pluto_self

# follow：先判"身上有没有这只乘客"，没有再上鞍；实在骑不上退回每刻 tp 兜底
execute unless data entity @s Passengers[{id:"minecraft:parrot"}] run function kitpvp:skill/pluto/mount
execute unless data entity @s Passengers[{id:"minecraft:parrot"}] as @e[...归属匹配...] run tp @s ~ ~1.85 ~
```

`execute if data entity @s Passengers[{id:"minecraft:parrot"}]` 是判断"有没有骑着"的可靠写法（已在测试服用 mob 验过：
上鞍前 `unless` 命中、上鞍后 `if` 命中）。

### 17.12 刷怪蛋载体：一律打 tag，且清理**绝不能早于判定**（2026-11-26 实机两连）

**刺客（kit 4）**：令牌是末影人蛋，`skill/assassin/dispatch` 在 `slow2`（每 2 刻）里靠
`@e[type=enderman,name="隐匿",distance=..8]` 判定技能；而 `tick/kits_a` 里有一行每刻的
`kill @e[type=enderman,distance=..16,name="隐匿"]`。**kits_a 跑在 slow2 之前** → 载体先被清掉，
dispatch 永远判不到 → 表现是"技能召出的末影人立刻消失、没有技能效果、也不补货"（handout 窗口没开）。
另外末影人有随机瞬移，2 刻窗口里也可能跳出 8 格。

**渔夫（kit 7）**：寻戟载体只按 `name="寻戟"` + 主人 16 格清，海洋图里它会游走 / 渔夫死后没人清，
而 `reset_entities` 只按 tag 清 → **跨局残留**（"溺尸不会被正常处死"）。

两条统一成同一个写法：

1. 蛋的 `EntityTag` 里给载体打 tag（顺手加 `NoAI:1b,Silent:1b` 免得它乱跑/乱叫）：
   `EntityTag:{Tags:["kitpvp.<职业>_token"],NoAI:1b,Silent:1b}`。
2. 清理按 tag 走，并且**放在判定之后**（通常就在 `cast` 里，与技能效果同刻）：
   `execute at @s run kill @e[tag=kitpvp.<职业>_token,distance=..8]`。
3. `tools/gen_cleanup.py` 会自动把该 tag 收进 `reset_entities`，跨局兜底不用手写。

**判断口诀**：凡是"蛋生出来、只为让 `used` 有个落点"的载体，都必须能回答两个问题——
「它在判定之前会不会被清掉？」「它跑远了 / 主人死了，谁清它？」

### 17.10 改动过的统计判据必须 `objectives remove` 再 `add`（2026-11-26 实机）

`scoreboard objectives add` 对**已经存在**的目标是**静默空操作**：改数据包里的 `add` 行不会改变老存档里那个目标的判据。

实例：水星魂石的 `kitpvp.soul_mercury_used` 早年是 `minecraft.used:minecraft.dolphin_spawn_egg`，
后来改成 `tropical_fish_spawn_egg`，只改了 `add` 行 → 老存档仍按**海豚蛋**计数 →
表驯兽师一召唤海豚（它发 32 个海豚蛋）就白拿水星魂石的 20 秒速度 X。

写法（`tainted_core_used` 早就是这么做的，水星当时漏了）：

```mcfunction
scoreboard objectives remove kitpvp.<目标>
scoreboard objectives add kitpvp.<目标> minecraft.used:<物品>
```

删了会清零所有人的该分数，所以 `load` 里紧跟着的 `operation @a <x>_last = @a <x>_used` 正好把快照也归零，不会误触发。
**凡是改过判据的统计目标，都要走这条**。

### 17.11 「别人捡走我的东西」类判定：闸门不能只写本职业

陷阱师的陷阱是**掉落物**，规则是"自己捡回来=回收，别人捡走=触发"。第一版把事件闸门写成

```mcfunction
execute as @a[scores={kitpvp.kit=77,...}] if score @s <pick>_used > @s <pick>_last run function .../pick_x
```

于是**只有陷阱师自己捡东西时才做归属判定**，别人踩到陷阱根本没人检查 → 表现为"完全不触发、物品也没被清掉"。

正确闸门是所有参战玩家：`@a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator]`，
归属判定靠物品 NBT 里的 `KitTrapOwner` 与持有者自己的 `kitpvp.trap_id` 比较（不是靠"谁在用这个技能"）。

### 17.6 1.20.1 已删掉的字段 / 选择器细节
- **两个分数比较时，源选择器后面不能再跟 objective**：写
  `if score #a kitpvp.game < @s kitpvp.b`（对）；`< @s kitpvp.b kitpvp.game`（错，多了一个参数，整份函数不加载）。
- **`minecraft.dropped:` / `minecraft.picked_up:` 在 function 里必须写点号形式**：
  `minecraft.dropped:minecraft.tripwire_hook`（对）；写成冒号 `...:minecraft:tripwire_hook` 时
  **RCON 能建但 function 解析会报 `Non [a-z0-9/._-] character in path`**，把整份 load 丢掉——这个差异极容易误判，
  验证判据一定要用「写进函数 + reload + 看日志」，不要只用 RCON 试。
- **丢出类冷却不能用 `used:` 判据**（`tripwire_hook` / `quartz` / `spider_eye` 这些物品右键没有"使用"事件）：
  陷阱师的做法是每 2 刻比一次「背包数量快照」，数量变少即视为丢出（`skill/zhanshishi/drop_watch`）。
- **`firework_charge` 在 1.13 后改名为 `firework_star`**：写旧名会让 `give` / `clear` 所在的整份函数
  加载失败（陷阱师的蠹虫陷阱踩过这个坑）。批量搬 1.12 物品 id 时，先 `clear <id> 0` 试一条再大规模用。
- **没有 `armor_stand_spawn_egg`**（也没有 giant / ender_dragon 等蛋）：写了这条会让整份函数
  静默不加载，`objective criteria` 里写它会让**整份 load 失效**。选令牌载体前先确认该蛋真实存在，
  并用「全库 grep + spawn_egg 判据清单」确认没被别人占用。烛之武的辞令用的是 `sniffer_spawn_egg`。
- **没有 `Tame` 字段**：驯服狼 = 带 `Owner` UUID，选择器无法"存在性匹配" → 清狗只能 `@e[type=minecraft:wolf]` 全清（繁殖幼崽不继承 tag，这正是狗清不干净的原因）。
- 飞行中的三叉戟物品在 **`Trident`** 字段（不是 `Item`/`item`）。
- `name=地鸣` 这类中文值**必须加引号**，否则整份函数解析失败（`Expected end of options`）。
- `@a` 上不能写 `type=`；只在 `@e` 有效。

### 17.7 音乐数据包（rumbling，独立包）
- 引擎口径：每刻给 `nbs_rumbling` 加 `speed` 分，每个音符占 **80 分** → `秒 = 分数 / (speed × 20)`；`T ≈ 秒 × speed / 4`（speed=154 时 T ≈ 秒×38.5）。
- 改 `speed` 必须**同步重排歌词**，否则整首错位。
- NBS 生成的包里 `playsound minecraft:Tempo Changer ...` 是非法音效，会让该音符函数**整份不加载**，安装后要清掉。
- 歌词用 `schedule` 串联（同雨爱），停止时逐条 `schedule clear`；音乐/歌词的生命周期要有 `#xxx_active` 之类状态机，保证"巨人/驾驶员同时消失"也能收场。
- **要从中间开播不用改音符库**：`nbs_rumbling` 是逐玩家分数（每刻 +`speed`=154，每个音占 80 分），`nbs_rumbling_t` 记"已经响到第几个音"，
  叶子守卫是 `nbs_rumbling_t=..T-1`。所以 `play` 之后把分数与快照推到目标位置即可：
  **最后 20 秒** = 分数 `277760 - 400×154 = 216160`（第 2702 个音）+ 快照 `2701`；全曲最后一个音是 3472（277760 分），正好再放 400 刻自停。
  实例：`skill/soul/use_mars`（火星魂石）。歌词链是 `schedule` 串联的绝对时间轴，中间开播要**直接接对应那一句**：
  最后 20 秒 = `music/rumbling_lyric/ev_018`（曲内第 1401 刻 ≈ 70.05 秒），收场用 `rumbling_lyric/stop` 清整条链。

### 17.8 清场兜底（未加载区块）
未加载区块的实体既选不中也杀不掉 → 标准做法：**先 tp 到玩家身上（该区块必加载）→ kill → 隔刻复核**（`game/li_purge` / `li_purge_verify`，最多 6 轮）。狗和 iLsacuL 现在共用这一套。

### 17.9 其它
- `summon` 出来的 Giant **不要加 `NoAI`**（它会浮空；Giant 本来就没 AI）。
- 召唤物落点用 `spreadplayers` 找地表，避免生成在方块里憋死。
- 跨数据包调用（`kitpvp:music/rumbling/*`）不在 src 里，`tools/check.py` 用 `EXTERNAL_PREFIXES` 放行。
- 混沌武器的"会不会碎"由记分板 `chaos_uses` 决定，物品一律带 `Unbreakable:1b`（防止多重射击/斧类多耗耐久把武器提前打碎）；`Damage` 只作视觉。
