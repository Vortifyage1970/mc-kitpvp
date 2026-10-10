# 职业注册表

> **收录**：有哪些职业、编号几号、归哪一类、做到哪一步、设计卡片。

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
