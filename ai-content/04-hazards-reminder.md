# 已知坑位与约定（Hazards & Reminders）

> 本文件记录已踩到、易踩到的坑，以及若干必须共同遵守的约定。
> 每次动过代码后，若踩到新坑就补进来；旧坑被修掉也要更新本文档。
> 版本红线：**1.20.1 数据包**（pack_format 15）。任何 1.20.2+ 的语法出现即报错，详见 `00-version.md`。

---

## 一、结算链路（game/end 与 game/reset）

> 以下四条来自历史骨架，当前工程里用户还没有贴出 `game/end.mcfunction` 与 `game/reset.mcfunction` 的正文，若有出入以实际文件为准。

1. **`#state` 未置 1 = 结算永不触发。** 目前 `#state` 只在 `load.mcfunction` 里被初始化为 0，需要有人把它置成 1（应是 `game/start` 的职责）。证据在两根线上：
   - `tick.mcfunction` 的胜负兜底轮询：`if score #state kitpvp.game matches 1 run function kitpvp:game/check_winner`；
   - `player/eliminate.mcfunction` 末尾直接调 `check_winner`，**没有 `#state` 守卫**，所以 `check_winner` 自己必须能分辨"进行中"和"结算中/已结束"。
2. **结算 10 秒定时器**建议用 `schedule function kitpvp:game/reset 200t replace` 发射。`replace` 模式保证同一次结算里重复触发不会叠多个定时器；若 `game/end` 已被某个状态值（如 `#state=2`）锁死，正常情况下也不会被重复调用。
3. **0 幸存者不自动结算。** 最后两人互相耗死在同一刻、或剩下的人全部掉线时，局会卡在"进行中"状态，需要管理员手动跑 `function kitpvp:game/end` 或 `function kitpvp:game/reset`。是否需要"平局自动结算"是设计决策，当前按保守方案（不自动）写。
4. **`reset` 里的 `kill @e` 白名单未定。** 画、物品展示框、装饰实体、地图专用载具会被误杀。骨架里这段已全部注释掉，**未验证前不要取消注释**。
5. **结算 10 秒内玩家仍能互相攻击。** 设计文档第九节"无敌实现方式"未定，没有冒然加抗性 V 或屏蔽伤害的方案。

---

## 二、测试开关（debug/test）

1. **`#test` 一旦为 1，自动判定胜利永远不触发。** 正式局前先跑一次 `function kitpvp:debug/test/status`，确认 `#test` 是 0。
2. **`build` 模式会摘掉 `kitpvp.selected`**，这会让 survivors 统计少一个人。这是刻意设计——建造期间不参与游戏统计。要"边建造边参与统计"，用 `play` 而不是 `build`。
3. **`force_reset` 里的 `schedule clear kitpvp:game/reset` 只能清掉还没发射的那一次。** 如果 `end` 的 200t 倒计时已经跑完并执行了 `reset`，那 `force_reset` 只是再跑一次 `reset`，是幂等的，不会出错。
4. **`solo_start` 和 `play` 都不做传送。** 大厅坐标和地图坐标还是 TODO，玩家会留在原地。确定坐标后，把 `solo_start` 末尾注释里的 `tp @s <x> <y> <z>` 取消注释。
5. **`effect give ... instant_health 1 5 true` 是 `/heal` 的替代写法**（1.20.1 没有 `/heal`，那是 Mod 提供的）。`util/clear_player.mcfunction` 末尾和 `invincible.mcfunction` 都用这个模式。如果实测发现回不满，把 amplifier 调到 9。

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
- 生成 JSON 时留意转义：外层用单引号包住整段 JSON 时，**内部全部用双引号**。

参照实现：`lobby/menu.mcfunction`。

---

## 四、给予物品类技能：冷却检测不能被"丢出物品"绕过

这一节是设计"给玩家发物品"的技能时的**通用坑**。战士的"补给"是当前唯一的参照实现，新增同类技能时请照抄这套模式。

### 4.1 为什么"检测背包里物品消失"是错的

如果把冷却条件设计成"**背包里没有了该物品 → 说明用掉了 → 进入冷却 / 补发**"，那么玩家只要**把物品丢到地上、塞进箱子、交给队友**，背包里就会"没有了"，从而触发本来只有"**真正使用**"才该触发的逻辑。玩家的操作没有消耗物品、也没有吃到效果，却把"已被使用"的状态骗了过去。

后果分两类，都是坏结果：

- **补发型（无限刷）**：技能实现为"背包里没有 X 就再给一份"。玩家丢一份 → 立刻补一份 → 再丢 → 又补一份……循环刷。
- **冷却型（语义污染）**：技能实现为"背包里没有 X 就进冷却"。看似玩家被冷却了，其实只是"丢了"而不是"用了"。而且如果地图里散落了野生的 X，玩家捡起来再丢，冷却会被反复触发/反复重置。

**目标：保证进入冷却的唯一依据是"玩家真的使用了这个物品"。**

### 4.2 初版本战士怎么做（目前基本已删除，逻辑无误，可参考）

战士的"补给"用 `minecraft.used:minecraft.golden_apple` 这个**统计类 objective** 作为"真正吃掉了"的唯一判据：

- **丢地上**：`used` 不动 → 不触发冷却；`tag=kitpvp.skill_ready` 保持 → 不补发。
- **放箱子 / 交给别人**：同丢地上，`used` 不动。
- **真吃掉**：`used` +1 → 由 `skill/warrior_consume` 摘掉 `skill_ready`、`set kitpvp.cd 800`（40 秒）。

三态由 `tag=kitpvp.skill_ready` + `kitpvp.cd` 两个变量唯一决定：

| 状态 | `skill_ready` | `kitpvp.cd` | 行为 |
|---|---|---|---|
| 持有中 | 有 | 0 | 不补发，等玩家使用 |
| 冷却中 | 无 | 800..1 | 什么都不做 |
| 待补发 | 无 | 0 | 立刻补一份 |

用到的函数与职责：

- `tick.mcfunction`：`execute as @a[scores={kitpvp.kit=1,kitpvp.alive=1}] if score @s kitpvp.gapple_used > @s kitpvp.gapple_last run function kitpvp:skill/warrior_consume`
- `skill/dispatch.mcfunction`：只在 `cd <= 0` 时被 `tick` 调用，按 `kit` 分派到 `skill/warrior`
- `skill/warrior.mcfunction`：`execute if entity @s[tag=!kitpvp.skill_ready] run function kitpvp:skill/warrior_ready`
- `skill/warrior_ready.mcfunction`：`give` 物品 + `tag @s add kitpvp.skill_ready`
- `skill/warrior_consume.mcfunction`：推平 `last` 快照 + 摘 tag + `set kitpvp.cd 800`

**必记要点：**

- **`warrior_consume` 的第一行必须是 `scoreboard players operation @s kitpvp.gapple_last = @s kitpvp.gapple_used`**，否则下一刻 `used > last` 依旧成立，冷却被反复触发。
- **`gapple_last` 的初始快照要在两处做**：`player/join.mcfunction`（新玩家进服）和 `util/clear_player.mcfunction`（清场归零）。漏掉会导致"刚进服/刚清场"的玩家被错判为"刚吃过"。
- **`tick.mcfunction` 里 `cd` 递减必须排在金苹果检测之前。** 顺序是"先 `cd--`，再判 `used > last`"，否则 `warrior_consume` 写的 `cd = 800` 会当刻被减到 799，差 1 刻。
- `skill/dispatch` 的调用条件 `if score @s kitpvp.cd matches ..0` 就是整套的"冷却归零才允许重试"闸门，不要绕过它。
- **`minecraft.used:` 只覆盖原版物品，且不分来源。** 地图里散落的金苹果、其它职业给的金苹果，都会算进 `gapple_used`。战士这套能成立的前提是"金苹果在服务器上的来源只有战士技能"。新增同类技能时，先确认这条前提是否成立。

### 4.3 如果该类物品没有 `used` 统计项怎么办

自定义物品（用 NBT/Name 区分）没法从 `minecraft.used:` 里单拿出来（1.20.1 没有 `execute if items`；那是 1.20.5+）。三条路，选一条：

1. **接受"全部同类型物品合并统计"**：只要该物品在服务器上的唯一来源就是本职业技能（黄金苹果、面包、雪球之类），直接用 `minecraft.used:minecraft.<item>`。前提是**没有其他职业发、也没有地图上的野生刷新**。
2. **改为"发物品即进冷却"**：`warrior_ready` 里给完物品**立刻** `set kitpvp.cd <刻数>`，"使用"这个动作不再参与冷却判断。这样绝不会有刷物品漏洞；代价是玩家可以拖到冷却结束再吃来多留一个。部分职业（例如"一次性召唤物"或"持续 Buff 卷轴"）用这个模式反而更贴切。
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

---

## 五、其它经常踩的坑

- **文件夹是 `functions`（复数）**，不是 `function`。加载钩子在 `data/minecraft/tags/functions/load.json`，每刻钩子在 `data/minecraft/tags/functions/tick.json`。
- **`.mcfunction` 每行一条命令，行尾无分号**，`#` 开头是注释，**不要写行号**。
- **命名空间只允许小写字母、数字、下划线**：`kitpvp` ✅，`KitPvP` ❌，`kit-pvp` ❌。
- **`scoreboard objectives add` 必须在 `load.mcfunction` 里统一创建。** 需要初始分数的玩家/假玩家也在 `load` 里初始化。新增 objective 时同步补进 `load`（当前工程在 `load` 里已经建了 `kitpvp.kit / cd / cd2 / alive / lives / kills / deaths / map / timer / inv / death_detect / death_seen / game / item`）。
- **1.20.1 无 `/heal`**，用 `effect give @s minecraft:instant_health 1 5 true` 代替（见 `util/clear_player.mcfunction`）。
- **1.20.1 没有以下语法，出现即报错**：`return` / `return run`、`tick` 命令、`random` 命令、`execute if items`、`dialog`、`waypoint`、`function xxx with {...}`、`function #tag`（调用函数标签）、宏 `$()`、函数参数。这些全都是 1.20.2+ 才有的。
- **1.20.1 物品 NBT 是旧版格式**：`{Enchantments:[{id:"minecraft:sharpness",lvl:5}]}`、`{display:{Name:'...'}}`、`{Unbreakable:1b}`。**不要**写 `components` / `enchantments` / `custom_name` / `unbreakable:{}`（那都是 1.20.5+）。
- **1.20.1 文本组件用小驼峰**：`clickEvent` / `hoverEvent`，不是 `click_event` / `hover_event`；`show_text` 的字段是 `contents`，不是 `value`。
- **`data get` / `data modify` 的路径用点号分隔**（`SelectedItem.tag.xxx`），数组用方括号（`Inventory[0]`）。
- **`load.mcfunction` 里那一大段 `tag @a remove` 是刻意为之，但 `kitpvp.joined` 与 `kitpvp.in_lobby` 不能在 `util/clear_player` 里清。** `kitpvp.joined` 一清，`tick.mcfunction` 的接入检测会重复触发 `player/join`；`kitpvp.in_lobby` 一清，`player/on_death.mcfunction` 的"大厅死亡不计"判定会失效。
- **`gamerule sendCommandFeedback false` 会吞掉大量命令反馈。** 调试时"没报错 ≠ 命令真的执行了"。写调试函数时优先配合 `tellraw` / `say` 显式输出，别靠默认反馈判断成败。
- **`tick.mcfunction` 里"虚空判死"用的是 `if entity @s[y=-1024,dy=950]`**，覆盖 y ∈ [-1024, -74]。若地图要改判定阈值，**只改 `dy`**（`y + dy - 1` 是上界），不要动 `y`，否则会漏掉更低的位置。
- **主动技能的通用模式（1.20.1）**：主动技能不能挂 `tick → dispatch`，必须靠"检测玩家操作"来触发。当前项目里用**统计 objective**（如 `minecraft.used:minecraft.iron_golem_spawn_egg`）检测"用掉了专属物品"，tick 里比对 `used > last` 后转交 `skill/xxx_cast`。触发物默认选**颜色贴主题的刷怪蛋**（坦克用铁傀儡），生成物由 tick 立刻 `kill`。函数入口首行必须是快照推进（`operation last = used`），否则每刻重复触发。令牌的快照变量要在 `player/join` 与 `util/clear_player` 都初始化。
- 被动药水效果均需要在重生时重新给予。