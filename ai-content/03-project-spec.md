# KitPvP 项目设计文档

> 本文档是 AI 理解项目需求的唯一依据。描述"玩家体验到什么"，不描述"代码怎么写"。
> 任何与本文档冲突的实现方案，以本文档为准。

---

## 一、项目概况

| 项 | 值 |
|---|---|
| 版本 | Minecraft Java Edition 1.20.1 |
| 类型 | 纯数据包，无模组、无插件 |
| 命名空间 | `kitpvp` |
| 人数 | 3-6 人小规模联机 |
| 形式 | 与自定义地图配套的职业战争 |
| 职业总数 | 79（不含混沌）；约 94-101（含混沌） |

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
│ 技能：每 40 秒获得 1 个金苹果（上限 1）
│ 技能冷却：40 秒
└──────────────────────────────
[ 确认选择 ]  [ 返回 ]
```

点击"确认选择"后 → 设 `kit` 分 → 发放装备 → 聊天栏提示"已选择战士"。

### 2.4 职业分类

| 分类 | 说明 |
|---|---|
| 经典（表） | 标准职业，平衡 |
| 经典（里） | 经典职业的黑暗强化版 |
| 经典（混沌） | 多职业杂糅，机制复杂 |
| 星象 | 基于星座/天象设计 |
| 职业职业 | 参考明日方舟，机制较复杂 |
| 抽象 | 梗向、搞笑向 |
| 历史 | 基于历史人物/事件 |

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
- 允许有限度放置/破坏方块（不破坏平衡为前提）
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

属性:
  最大生命: 20
  移动速度: 0.1
  攻击力: 1
  护甲: 15
  护甲韧性: 0
  永久效果: 无

被动: 无

技能:
  名称: 补给
  冷却: 40 秒
  效果: 获得 1 个金苹果
  上限: 同时最多持有 1 个

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

## 四、职业清单

### 4.1 经典（表）—— 22 个

- [x] 战士
- [x] 弓箭手
- [x] 坦克
- [x] 刺客
- [ ] 矿工
- [ ] 纵火狂
- [ ] 幽灵
- [ ] 海盗
- [ ] 驯兽师
- [ ] 史莱姆
- [ ] 末影人
- [ ] 附魔师
- [ ] 药剂师
- [ ] 文明小子
- [ ] 渔夫
- [ ] 炸弹兵
- [ ] 李朱俊泽
- [ ] 蜘蛛侠
- [ ] 僵尸
- [ ] 时间领主
- [ ] 农夫
- [ ] 狼人

### 4.2 经典（里）—— 22 个

所有表职业均有里版本，命名规则待定。

- [ ] 矿工·里
- [ ] 战士·里
- [ ] 弓箭手·里
- [ ] 坦克·里
- [ ] 刺客·里
- [ ] 纵火狂·里
- [ ] 幽灵·里
- [ ] 海盗·里
- [ ] 驯兽师·里
- [ ] 史莱姆·里
- [ ] 末影人·里
- [ ] 附魔师·里
- [ ] 药剂师·里
- [ ] 文明小子·里
- [ ] 渔夫·里
- [ ] 炸弹兵·里
- [ ] 李朱俊泽·里
- [ ] 蜘蛛侠·里
- [ ] 僵尸·里
- [ ] 时间领主·里
- [ ] 农夫·里
- [ ] 狼人·里

### 4.3 经典（混沌）—— 待补全

大部分表职业均有混沌版本，具体名单待定。

- [ ] 待补充

### 4.4 星象 —— 12 个

- [ ] 太阳
- [ ] 地球
- [ ] 哈雷彗星
- [ ] 月球
- [ ] 水星
- [ ] 金星
- [ ] 火星
- [ ] 木星
- [ ] 土星
- [ ] 天王星
- [ ] 海王星
- [ ] 冥王星

### 4.5 职业职业 —— 10 个

- [ ] 处决者（凋灵）
- [ ] 教官
- [ ] 陷阱师
- [ ] 中坚术师
- [ ] 武者
- [ ] 斗士
- [ ] 无畏者
- [ ] 冲锋者
- [ ] 傀儡师
- [ ] 驭法铁卫

### 4.6 抽象 —— 10 个

- [ ] 胖子（小卖部）
- [ ] 烛之武
- [ ] 真烦人
- [ ] 电棍otto
- [ ] 汉堡小子
- [ ] 爆裂魔法师（惠惠）
- [ ] 如意馄饨
- [ ] 如来
- [ ] 教练
- [ ] 排长

### 4.7 历史 —— 3 个

- [ ] 渔父
- [ ] 忽必烈
- [ ] 李将军

---

## 五、已完成的职业卡片

### 战士

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

属性:
  护甲: 15
  护甲韧性: 0

技能:
  名称: 补给
  冷却: 40 秒
  效果: 获得 1 个金苹果（上限 1）

命数: 3
```

### 弓箭手

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

### 坦克

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

### 刺客

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

---

## 六、计分板登记表

> 新增任何 objective，必须同步本表 + `load.mcfunction` + `util/clear_player.mcfunction`。
> dummy 类型用于编号/计数/快照；统计类型用于"使用事件"检测。

| 名称 | 类型 | 用途 | 初始化于 | 消费者 |
|---|---|---|---|---|
| `kitpvp.kit` | dummy | 职业 ID（0=未选） | load / clear_player | dispatch、tick 各检测行 |
| `kitpvp.cd` | dummy | 主技能冷却（刻） | load / clear_player | tick 递减、dispatch 闸门 |
| `kitpvp.cd2` | dummy | 第二技能冷却（刻，预留） | load / clear_player | tick 递减 |
| `kitpvp.alive` | dummy | 存活（1=活 0=旁观） | load / clear_player | tick 各检测行 |
| `kitpvp.lives` | dummy | 剩余命数 | load / clear_player | 死亡结算 |
| `kitpvp.kills` | dummy | 击杀数 | load / clear_player | 结算 |
| `kitpvp.deaths` | dummy | 死亡数 | load / clear_player | 结算 |
| `kitpvp.map` | dummy | 当前地图 ID（预留） | load | 地图选择 |
| `kitpvp.timer` | dummy | 全局倒计时（秒） | load | timer_tick |
| `kitpvp.inv` | dummy | 无敌剩余刻数 | tick 补零 / clear_player | 无敌结束判定 |
| `kitpvp.death_detect` | dummy | 死亡计数器（写入方未定，待补） | — | death_dispatch |
| `kitpvp.death_seen` | dummy | 死亡快照 | load / join / clear_player | death_dispatch |
| `kitpvp.game` | dummy | 游戏状态 | load | check_winner |
| `kitpvp.item` | dummy | 预留 | load / clear_player | — |
| `kitpvp.gapple_used` | `minecraft.used:minecraft.golden_apple` | 战士金苹果使用 | load | tick |
| `kitpvp.gapple_last` | dummy | 战士快照 | load / join / clear_player | tick |
| `kitpvp.tank_used` | `minecraft.used:minecraft.iron_golem_spawn_egg` | 坦克令牌使用 | load | tick |
| `kitpvp.tank_last` | dummy | 坦克快照 | load / join / clear_player | tick |
| `kitpvp.assassin_used` | `minecraft.used:minecraft.enderman_spawn_egg` | 刺客令牌使用 | load | tick |
| `kitpvp.assassin_last` | dummy | 刺客快照 | load / join / clear_player | tick |
| `kitpvp.ready_used` | `minecraft.used:minecraft.carrot_on_a_stick` | 大厅准备钓竿使用 | load | tick |
| `kitpvp.ready_last` | dummy | 准备快照 | load / lobby/enter / clear_player | tick |

假玩家：

| 名称 | 用途 |
|---|---|
| `#state kitpvp.game` | 游戏状态机（0=待机 1=进行中 2=结算中） |
| `#tick kitpvp.game` | 胜负轮询节流计数器 |
| `#test kitpvp.game` | 测试模式开关（1=自动判定胜利关闭） |

> 计分板名只允许小写字母、数字、点、下划线，不能有大写。


---

## 七、tag 登记表

> 新增任何 tag，必须同步本表 + `load.mcfunction` + `util/clear_player.mcfunction`。
> 最后一个字段写"clear_player 是否清"，是新增 tag 时必须回答的问题。

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

> tag 只用于"有/没有"的二值判断。编号、计数、冷却用计分板。

---

## 八、01-file-structure为每次更改后通过cmd读取文件目录得到的所有文件，如要参考目前有哪些函数可参考

---

## 九、设计决策记录，具体请参照已完成代码

---

## 九·五、kit 编号对照

> 必须与 `util/give_kit.mcfunction`、`skill/dispatch.mcfunction` 三处保持一致。

| 编号 | 职业 | 技能类型 | 令牌物品 |
|---|---|---|---|
| 0 | （未选） | — | — |
| 1 | 战士 | 自动 | 无（给金苹果本体） |
| 2 | 弓箭手 | 触发器驱动（advancement） | 无（给弓） |
| 3 | 坦克 | 主动 | `iron_golem_spawn_egg` |
| 4 | 刺客 | 主动 | `enderman_spawn_egg` |
| 5+ | 后续职业顺延 | | |

新增职业时，同步更新：本表 + `util/give_kit.mcfunction` + `skill/dispatch.mcfunction`。

---

## 十、待办清单

- [ ] 补全所有职业卡片（79 个，不含混沌）
- [ ] 确定混沌版本名单
- [ ] 确定地图清单和每张地图的特性
- [ ] 确定突然死亡的魂石清单
- [ ] 设计地图复原方案