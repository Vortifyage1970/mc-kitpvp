# 结论

同意，但要把症结说准，否则改写会跑偏。

**真正的痛点不是"03 太长"，而是"03 混装了三类寿命完全不同的信息"：**

| 层 | 例子（现 03 里的） | 变更频率 |
|---|---|---|
| 规则层 | 主线流程、胜利条件、职业模板、分类定义 | 改游戏规则才动 |
| 实例层 | 职业清单、5 张职业卡片、kit 编号表 | **每加一个职业就动** |
| 账本层 | 计分板登记表、tag 登记表 | **每加一个技能就动** |

三层挤在一个文件里，导致：

1. **重复**。一个职业的"编号/分类/技能类型"同时存在于 §4 清单、§5 卡片、§9.5 编号表的三个地方——重复必然不同步。`07` 那两张表也是同理，它们的真身在 `load.mcfunction` / `clear_player.mcfunction` 里。
2. **枚举代替规则**。用 79 个 checkbox 表达"职业清单"，粒度太细，每加一个就漏一个。
3. **没有维护契约**。没有一句话说明"什么该放哪"，所以每加东西就顺手往 03 塞——这才是膨胀的根因。

所以改写的核心不是"删减"，是**按变更频率分层 + 一份事实只写一处**：

- **规则留 03**，并且给一条硬判据：*「一条信息只要在新增一个职业/技能时必须被修改，就不属于本文件」*。
- **实例外置 06**（职业注册表）。
- **账本外置 07**（objective / tag / 物品标记索引），并明确降级为"派生、以代码为准、允许滞后"——**这一条是免除同步负担的关键**，否则你只是把麻烦从 03 搬到 07。

顺带一处收益：`03 §2.4` 用「配额」代替「逐项清单」后，混沌名单待定也不会让文件变成半成品。

---

## 改动清单

- **改写**：`src/03-project-spec.md`
- **新增**：`src/06-kit-registry.md`、`src/07-objectives-tags.md`
- **未动**：`00` / `01` / `02` / `04` / `05`
- **落地后需顺手改的两处引用**：`04-hazards-reminder.md` 第五节「新增任何 objective，必须同步**本表**」→ 指向 `07`；`05-skill-patterns.md` 第七节 `*_last` 清单 → 改为指向 `06` 总表，不再就地列举

---

src/03-project-spec.md

````markdown
# KitPvP 项目设计文档

> **定位**：本文件是**设计意图与规则**的唯一依据——描述"玩家体验到什么"，不描述"代码怎么写"。
> 任何与本文档冲突的实现方案，以本文档为准。
>
> **收录判据（硬性）**：一条信息只要在"新增一个职业 / 一个技能"时必须被修改，就**不属于**本文件。
>
> 本文件只在**改了游戏规则**时才动：加一条判定、改一次胜利条件、调一次时间、改一次分类配额。
> "又做完一个职业"不该碰它。

---

## 零、文档地图

| 文件 | 收录什么 | 何时动 | 何时读 |
|---|---|---|---|
| `00-version.md` | 版本红线、禁止语法 | 版本变更时 | 动任何语法前 |
| `01-file-structure.md` | 函数/文件清单 | 每次改代码（扫描生成） | 想知道"有哪些函数" |
| `02-commands-1.20.1.md` | 命令手册、易错点 | 发现新易错点时 | 写命令前 |
| `03-project-spec.md` | 设计意图、规则、判据、模板 | 改规则时 | 决定"该做成什么样" |
| `04-hazards-reminder.md` | 已知坑位与约定 | 踩到新坑时 | 写易错逻辑前 |
| `05-skill-patterns.md` | 技能实现模板 | 出现新类型技能时 | 实现技能时 |
| `06-kit-registry.md` | 职业实例：编号 / 分类 / 状态 / 卡片 | 每加一个职业 | 加职业、查编号 |
| `07-objectives-tags.md` | objective / tag / 物品标记 索引 | 每加一个名字 | 加名字、查重名 |

一句话：**规则在 03，实例在 06，账本在 07。**

---

## 一、项目概况

| 项 | 值 |
|---|---|
| 版本 | Minecraft Java Edition 1.20.1 |
| 类型 | 纯数据包，无模组、无插件 |
| 命名空间 | `kitpvp` |
| pack_format | 15 |
| 人数 | 3-6 人小规模联机 |
| 形式 | 与自定义地图配套的职业战争 |
| 职业规模 | 79（不含混沌）+ 混沌若干，配额见 §2.4 |

"已实现几个职业"不在本文件追踪，看 `06-kit-registry.md` 总表。

---

## 二、通用规则

### 2.1 数据包加载

- 按需设置 gamerule
- 创建所有计分板、队伍、标签
- 所有玩家状态归零
- 不强制传送、不改时间天气（由"开局"处理）

### 2.2 主大厅流程

1. 玩家进入 → 传送到大厅，冒险模式，清空背包
2. 在大厅自由走动
3. 选择职业：查看职业介绍 → 聊天栏点击确认
4. 随机职业：点"随机"按钮，从可用职业池随机
5. 选择地图：从已注册地图中选，也可随机
6. 按下开始按钮：所有人就绪后触发 `game/start`

### 2.3 职业选择界面

每个职业在选择时，聊天栏统一显示（缺项标"—"）：

```
┌──────────────────────────────
│ 职业名：战士
│ 分类：经典（表）
│ 简介：铁甲冲锋的正面战士
│ 武器单次伤害：7
│ 武器攻击速度：1.6
│ 总护甲值：15
│ 总护甲韧性：0
│ 被动：—
│ 技能：无
└──────────────────────────────
[ 确认选择 ]  [ 返回 ]
```

点击"确认选择"后 → 设 `kit` 分 → 发放装备 → 聊天栏提示"已选择战士"。

### 2.4 职业分类与配额

配额是**设计决策**，不随实现进度变化；"已完成多少"去 `06-kit-registry.md` 看。

| 分类 | 说明 | 配额 |
|---|---|---|
| 经典（表） | 标准职业，平衡 | 22 |
| 经典（里） | 经典职业的黑暗强化版 | 22 |
| 经典（混沌） | 多职业杂糅，机制复杂 | 待定 |
| 星象 | 基于星座 / 天象设计 | 12 |
| 职业职业 | 参考明日方舟，机制较复杂 | 10 |
| 抽象 | 梗向、搞笑向 | 10 |
| 历史 | 基于历史人物 / 事件 | 3 |
| 合计 | — | 79 + 混沌 |

### 2.5 重合职业处理

允许多人选同一职业。每个玩家独立计算状态：

- 不共享冷却、不共享物品、不共享效果
- 检测必须保证多人同一职业不会出现重叠
- 涉及召唤物、衍生物的职业，每个召唤物必须绑定到拥有者，不能让召唤物与召唤者敌对

### 2.6 开局

1. 所有人传送到地图，在多个重生点中抽取
2. 在各自落点设置 `spawnpoint`
3. 冒险模式切换为生存模式
4. 每人获得 5 秒无敌
5. 标题提示"游戏开始"，播放音效
6. 8 分钟倒计时开始

### 2.7 命数与重生

- 默认每人 3 条命
- 部分职业命数特殊
- 部分职业有"死亡不计"的机制
- 死亡后：
  - 命数 -1
  - 传送回自己的重生点
  - 5 秒无敌
  - 保留背包，仍使用选职业时发放的装备
- 命数归 0 → 进入旁观模式

### 2.8 战斗规则

- 无阵营，所有人互为敌人
- 允许有限度放置 / 破坏方块（不破坏平衡为前提）
- 大部分装备无法破坏（`Unbreakable:1b`）
- 食物受限：每个职业食物种类和数量不同
- 死亡不掉落

### 2.9 特殊物品与地形

**瞬移类物品**（紫颂果、末影珍珠等）：

- 允许使用，但需考虑穿墙、卡位、掉出地图
- 边界外掉落 → 判定为死亡（扣命数）
- 不应导致"卡在虚空不死"的状态

**虚空地图**：

- 无护栏、下方即虚空的地图必须有兜底机制
- 玩家 Y 坐标低于阈值时触发死亡判定

### 2.10 突然死亡（8 分钟后）

- 触发条件：开局满 8 分钟（可配置）
- 效果：每 20 秒给所有存活玩家一个一次性技能物品
- 物品类型：对应各职业的"魂石"（如战士的魂石、弓箭手的魂石、地球的魂石）
- 一次性：使用后消失，下次刷新再给
- 目的：加速比赛进程

### 2.11 胜利与重置

结束条件：仅剩 1 名玩家命数 > 0 → 该玩家获胜。

结算流程：

1. 宣布胜利者（title + 音效）
2. 等待 10 秒
3. 所有人初始化（清背包、清分数、清 tag、清队伍）
4. 传送回主大厅
5. 清除所有非玩家实体：
   - 清除：掉落物、箭、召唤物、衍生物、粒子实体等
   - 不清除：玩家、画、物品展示框、永久装饰实体、地图设计所需的载具
6. 尽可能复原地图（方块回滚）
7. 重置完成 → 回到"主大厅流程"第 1 步

### 2.12 地图

- 每张地图有独立特性（地形、边界、特殊机制）
- 地图信息记录在单独的注册表里
- 支持多个默认出生点有效随机重生

---

## 三、职业模板

写每个职业时按模板填。没写的项按默认值处理。

**本模板是"怎么填"，不是"填了什么"。填好的实例放 `06-kit-registry.md`。**

```yaml
职业名: 战士
分类: 经典（表）
简介: 铁甲冲锋的正面战士

装备:
  头盔: minecraft:iron_helmet
  胸甲: minecraft:iron_chestplate
  护腿: minecraft:iron_leggings
  靴子: minecraft:iron_boots
  主手: minecraft:iron_sword
  副手: 无
  食物: minecraft:cooked_beef x 16
       minecraft:golden_apple x 2

属性:
  最大生命: 20
  移动速度: 0.1
  攻击力: 1
  护甲: 15
  护甲韧性: 0
  永久效果: 无

被动: 无

技能: 无

命数: 3
特殊: 无
```

**复用语法**：如果某职业和另一个职业大部分相同，只写差异：

```yaml
职业名: 某职业
分类: 某分类
继承: 某职业
技能:
  名称: 某技能
  冷却: 60 秒
  效果: ...
命数: 5
```

---

## 四、设计决策记录

> 本节原样保留，本次改写不涉及。

（具体内容以现有文件为准）

---

## 五、跨职业待办

> 只登记**跨职业、跨模块**的待办。
> "某个职业还没做"这种待办不在此列——去 `06-kit-registry.md` 总表看那行的状态列。

- [ ] 确定混沌版本名单
- [ ] 确定地图清单和每张地图的特性
- [ ] 确定突然死亡的魂石清单
- [ ] 设计地图复原方案

---

## 六、维护契约

> 本节回答一个问题：**下次加东西时，我该动哪个文件。**
> 目的是让本文件不再因为"又做了一个职业"而膨胀。

### 6.1 什么放哪

| 信息 | 放哪 |
|---|---|
| 版本红线、禁止语法 | `00` |
| 函数 / 文件清单 | `01`（扫描生成，不手写） |
| 命令语法、易错写法 | `02` |
| 玩家体验、判定、时间、胜利条件、分类配额、模板 | `03` |
| 坑位、约定、已踩过的错 | `04` |
| 技能实现模板（主动 / 自动 / 投掷） | `05` |
| 职业编号、分类归属、状态、职业卡片 | `06` |
| objective / tag / 物品标记 的实际占用 | `07` |

### 6.2 加东西时动什么

**加一个职业：**

1. `06` 总表加一行（编号 = 现有最大编号 + 1）
2. `06` 卡片加一节
3. `util/give_kit.mcfunction` + `skill/dispatch.mcfunction` 同步编号
4. 若占用了新的 objective / tag / 物品标记 → `07` 补行
5. **不碰 `03`**

**加一条规则**（改命数上限、改倒计时、改胜利条件、改分类配额）：

- 只改 `03`
- 改完检查 `06` / `07` 里有没有需要跟进的实例

**改一个职业的数值：**

- 改 `06` 卡片 + 对应 `kit/*.mcfunction`
- 不动 `03`

**加一个新技能：**

- 按 `05` 的模板选类型实现
- `07` 补 objective / tag / 物品标记
- 若产生了新的通用坑位 → 补 `04`
- 只有"规则本身变了"才动 `03`

### 6.3 派生文件的权威顺序

`01` 与 `07` 是**账本**，代码是**事实**。二者冲突时：

- **以代码为准**，修正账本。
- 账本允许暂时滞后，但**不允许写与代码相反的内容**。
- 这条约定是刻意的：它免除"每次改代码必须同步文档"的负担，只要求在**发现不一致时**修账本。

### 6.4 编号铁律

职业编号只增不复用。编号一旦发出，就是该职业的永久身份；职业被删除，编号作废，不还给后来者。
详见 `06-kit-registry.md` 第一节。

### 6.5 未来可能新增的注册表

若某类信息开始具备"实例层"特征（每加一项就改一次），按同样模式外置，不往 `03` 塞：

- 地图注册表（每加一张地图就改一次）
- 魂石注册表（每加一个职业的魂石就改一次）
````

---

src/06-kit-registry.md

````markdown
# 职业注册表

> **收录**：有哪些职业、编号几号、归哪一类、做到哪一步、设计卡片。
> **不收录**：规则与判据（→ `03-project-spec.md`）、技能实现细节（→ `05-skill-patterns.md`）、objective / tag / 物品标记总账（→ `07-objectives-tags.md`）。
>
> 本文件**每加一个职业就改一次**——这正是它从 03 拆出来的原因。

---

## 一、编号铁律

1. 编号是**永久身份**，只增不复用。职业被删除，其编号作废，不还给后来者。
2. 新职业编号 = 现有最大编号 + 1。
3. **三处必须一致**：本表、`util/give_kit.mcfunction`、`skill/dispatch.mcfunction`。

---

## 二、总表

| 编号 | 职业 | 分类 | 状态 |
|---|---|---|---|
| 0 | （未选） | — | — |
| 1 | 战士 | 经典（表） | 已实现 |
| 2 | 弓箭手 | 经典（表） | 已实现 |
| 3 | 坦克 | 经典（表） | 已实现 |
| 4 | 刺客 | 经典（表） | 已实现 |
| 5 | 纵火狂 | 经典（表） | 已实现（卡片待补录） |
| + | 后续顺延 | | |

> 分类配额见 `03-project-spec.md` §2.4。本表不重复配额数字。
> 状态取值：`已实现` / `部分` / `待实现`。

---

## 三、职业卡片

> 按编号顺序排列。标题格式：`<编号> · <职业名> · <分类>`。
> 字段含义与默认值见 `03-project-spec.md` 第三节。

### 1 · 战士 · 经典（表）

```yaml
职业名: 战士
分类: 经典（表）
简介: 铁甲冲锋的正面战士

装备:
  头盔: minecraft:iron_helmet
  胸甲: minecraft:iron_chestplate
  护腿: minecraft:iron_leggings
  靴子: minecraft:iron_boots
  主手: minecraft:iron_sword
  食物: minecraft:cooked_beef x 16
        minecraft:golden_apple x 2

属性:
  护甲: 15
  护甲韧性: 0

技能: -

命数: 3
```

### 2 · 弓箭手 · 经典（表）

```yaml
职业名: 弓箭手
分类: 经典（表）
简介: 远程消耗的射手

装备:
  头盔: minecraft:leather_helmet
  胸甲: minecraft:leather_chestplate
  护腿: minecraft:iron_leggings
  靴子: minecraft:iron_boots
  主手: minecraft:stone_sword
  副手: minecraft:bow
  食物: minecraft:cooked_beef x 16
  其他: minecraft:arrow x 12

属性:
  护甲: 9
  护甲韧性: 0

技能:
  名称: 换弹
  冷却: 无（拾取即重置）
  效果: |
    丢出自己的弓并捡起，箭数重置为 12。
    若弓被其他人捡起，进入 30 秒冷却，
    期间其他人无法获得此弓，30 秒后归还。

命数: 3
特殊: 只能识别自己起始获得的弓
```

### 3 · 坦克 · 经典（表）

```yaml
职业名: 坦克
分类: 经典（表）
简介: 高护甲低速的肉盾

装备:
  头盔: minecraft:diamond_helmet
  胸甲: minecraft:diamond_chestplate
  护腿: minecraft:diamond_leggings
  靴子: minecraft:diamond_boots
  主手: minecraft:wooden_sword
  食物: minecraft:cooked_beef x 16

属性:
  护甲: 20
  护甲韧性: 8
  永久效果:
    - minecraft:mining_fatigue 等级 I
    - minecraft:slowness 等级 I

技能:
  名称: 举盾
  冷却: 30 秒
  效果: 获得一个持续 15 秒、耐久 80 的盾

命数: 3
```

### 4 · 刺客 · 经典（表）

```yaml
职业名: 刺客
分类: 经典（表）
简介: 高速突进的暗杀者

装备:
  头盔: minecraft:leather_helmet（黑色）
  胸甲: minecraft:leather_chestplate（黑色）
  护腿: minecraft:leather_leggings（黑色）
  靴子: minecraft:leather_boots（黑色）
  主手: minecraft:diamond_sword{锋利 II}
  食物: minecraft:cooked_beef x 16

属性:
  护甲: 7
  护甲韧性: 0
  永久效果:
    - minecraft:speed 等级 I

技能:
  名称: 隐匿
  冷却: 30 秒
  效果: 获得 5 秒隐身 + 速度 III

命数: 3
```

### 5 · 纵火狂 · 经典（表）

```yaml
职业名: 纵火狂
分类: 经典（表）
简介: 待补录

技能:
  类型: 主动（投掷）+ 自动（补货）
  载体: minecraft:splash_potion{KitFireBomb:1b}
  冷却: 45 秒

命数: 3
```

> 本卡片尚未按 `03` 第三节的完整模板填写。补全时以 `kit/arsonist.mcfunction`
> 与 `skill/arsonist_*.mcfunction` 的实际实现为准。

---

## 四、职业私有命名

> 每个职业**自己独占**的命名（私有 NBT 标记的名称、函数前缀）在此登记，方便一眼看全。
> 全局账本（objective / tag / 物品标记的实际占用）在 `07-objectives-tags.md`，本节不重复。

| 编号 | 职业 | 私有 NBT 标记前缀 | 私有函数前缀 |
|---|---|---|---|
| 2 | 弓箭手 | `KitArcher*` | `archer_*` |
| 3 | 坦克 | `KitTankEgg` / `KitShield` | `tank_*` |
| 4 | 刺客 | `KitAssassin*` | `assassin_*` |
| 5 | 纵火狂 | `KitFireBomb` | `arsonist_*` |

> 标记的实际字符串与使用位置以 `skill/*` 代码为准。
````

---

src/07-objectives-tags.md

````markdown
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
````