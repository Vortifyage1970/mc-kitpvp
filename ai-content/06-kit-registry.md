# 职业注册表

> **收录**：有哪些职业、编号几号、归哪一类、做到哪一步、设计卡片。

---

## 一、编号铁律

1. 编号是**永久身份**，只增不复用。职业被删除，其编号作废，不还给后来者。
2. 编号按**分类分块**：块内顺延，跨分类不插队，空号不回填。

   | 分类 | 号段 |
   |---|---|
   | 经典（表） | 1–22 |
   | 经典（里） | 23–44 |
   | 经典（混沌） | 45–64（配额待定，暂按 20 划段） |
   | 星象 | 65–76 |
   | 职业职业 | 77–86 |
   | 抽象 | 87–96 |
   | 历史 | 97–99 |

   块内新职业编号 = 该块已用最大编号 + 1。块用尽时**不自动溢出**，先在本表重新划段。
3. **七处同步**：本表、`util/give_kit.mcfunction`（分派）、`kit/random.mcfunction`（全职业池：`#pool_size` 与一行序号映射）、
   `kit/random_classic.mcfunction`（经典（表）池）、`kit/random_tainted.mcfunction`（经典（里）池）、
   `kit/random_astral.mcfunction`（星象池）、
   `skill/dispatch.mcfunction`（无自动技能的职业只进注释清单；补货走 `tick` 补货段的 24 / 65 / 68 另列一行注释，不要写进 dispatch）。
   新增职业还要在 `kit/list/<分类>.mcfunction` 加一行菜单项（分类列表按编号顺序排）。
4. **补货型令牌的冷却口径**（默认，规则见 `03` §2.13）：`cd` 只用来限制补货（持有上限 + 补货间隔），
   **使用侧与补货侧都要写**——用掉一个就进计时（满仓用掉一个也不能当场补），补货成功也重新计满。
   使用侧那一行必须带 `cd<=0` 守卫，否则连续出手会把补货越推越远。
   当前实例：纵火狂燃烧瓶、末影人末影之珠、里·弓箭手炮台令牌、狼人嗅闻令牌、驯兽师狼蛋。
5. **里职业一律用 `tainted_<表职业英文名>` 命名**：`tainted_warrior` / `tainted_archer` / `tainted_tank` / `tainted_arsonist`，
   覆盖职业函数、信息卡、`skill/` 目录、advancement 名与物品标记（`KitTainted*`），对应的 objective 用 `kitpvp.tainted_*`。
   分类名（`classic_tainted`）与随机池（`random_tainted`）保持原样——它们描述的是分类，不是职业。
6. **选择提示统一一行**：每个 `kit/<职业>.mcfunction` 的末尾（音效之前）写同一格式，
   职业名与配色**取自 `kit/info/<职业>` 卡片**，不要各自发挥：
   `tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"<职业名>","color":"<卡片色>","bold":true}]`

---

## 二、总表

| 编号 | 职业 | 分类 | 状态 |
|---|---|---|---|
| 0 | （未选） | — | — |
| 1 | 战士 | 经典（表） | 已实现（技能已删除） |
| 2 | 弓箭手 | 经典（表） | 已实现 |
| 3 | 坦克 | 经典（表） | 已实现 |
| 4 | 刺客 | 经典（表） | 已实现 |
| 5 | 纵火狂 | 经典（表） | 已实现 |
| 6 | 幽灵 | 经典（表） | 已实现 |
| 7 | 渔夫 | 经典（表） | 已实现 |
| 8 | 末影人 | 经典（表） | 已实现 |
| 9 | 海盗 | 经典（表） | 已实现 |
| 10 | 史莱姆 | 经典（表） | 已实现 |
| 11 | 驯兽师 | 经典（表） | 已实现 |
| 12 | 药剂师 | 经典（表） | 已实现 |
| 13 | 农夫 | 经典（表） | 已实现 |
| 14 | 僵尸 | 经典（表） | 已实现 |
| 18 | 狼人 | 经典（表） | 已实现 |
| 19 | 炸弹兵 | 经典（表） | 已实现 |
| 23 | 里·战士 | 经典（里） | 已实现 |
| 24 | 里·弓箭手 | 经典（里） | 已实现 |
| 25 | 里·坦克 | 经典（里） | 已实现 |
| 27 | 里·纵火狂 | 经典（里） | 已实现 |
| 28 | 里·幽灵 | 经典（里） | 已实现 |
| 29 | 里·渔夫 | 经典（里） | 已实现 |
| 30 | 里·驯兽师 | 经典（里） | 已实现 |
| 31 | 里·史莱姆 | 经典（里） | 已实现 |
| 32 | 里·炸弹兵 | 经典（里） | 已实现 |
| 33 | 里·末影人 | 经典（里） | 已实现 |
| 34 | 里·农夫 | 经典（里） | 已实现 |
| 45 | 混沌战士 | 经典（混沌） | 已实现（21 把耗材武器，扩池子改 tools/gen_chaos.py） |
| 46 | 混沌弓箭手 | 经典（混沌） | 已实现 |
| 65 | 太阳 | 星象 | 已实现 |
| 66 | 水星 | 星象 | 已实现 |
| 67 | 金星 | 星象 | 已实现 |
| 68 | 地球 | 星象 | 已实现 |
| 69 | 哈雷彗星 | 星象 | 已实现 |
| 70 | 火星 | 星象 | 已实现 |
| 71 | 冥王星 | 星象 | 已实现 |
| 87 | 文明小子 | 抽象 | 已实现 |
| 88 | 李朱俊泽 | 抽象 | 已实现 |
| 89 | 汉堡小子 | 抽象 | 已实现 |
| 77 | 陷阱师 | 职业职业 | 已实现 |
| 97 | 烛之武 | 历史 | 已实现 |
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
  食物: minecraft:cooked_beef x 24
        minecraft:golden_apple x 1

属性:
  护甲: 15
  护甲韧性: 0

被动: 开局携带 1 个金苹果

技能: 无（原"补给"技能已删除）

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
  弓: minecraft:bow{KitBow:1b}（give 进背包，玩家自选槽位）
  食物: minecraft:cooked_beef x 24
  其他: minecraft:arrow x 14

属性:
  护甲: 11
  护甲韧性: 0

技能:
  名称: 换弹
  冷却: 无（拾取即重置）
  效果: |
    丢出自己的弓并捡起，箭数重置为 14。
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
  食物: minecraft:cooked_beef x 24

属性:
  护甲: 20
  护甲韧性: 0（2026-11-05 起清零：四件钻石甲各写一条 `generic.armor` 的 AttributeModifiers，
          覆盖掉钻石自带的每件 +2 韧性，见 `04-hazards-reminder.md` §九）
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
  主手: minecraft:diamond_sword{锋利 I}
  食物: minecraft:cooked_beef x 24

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
简介: 把战场烧成灰烬的纵火者

装备:
  头盔: minecraft:leather_helmet（红色，火焰保护 III）
  胸甲: minecraft:leather_chestplate（红色，火焰保护 III）
  护腿: minecraft:iron_leggings（护甲 4，火焰保护 III）
  靴子: minecraft:iron_boots（火焰保护 III）
  主手: minecraft:stone_sword{火焰附加 II}
  其他: minecraft:flint_and_steel x 1
  食物: minecraft:cooked_beef x 24

属性:
  护甲: 10
  护甲韧性: 0

技能:
  名称: 燃烧瓶
  类型: 投掷（主动）+ 自动补货
  载体: minecraft:splash_potion{KitFireBomb:1b}
  冷却: 45 秒补 1 瓶（开局 2 瓶，上限 2 瓶；投出即开始计时，计时中再投不重置）
  效果: |
    投出燃烧瓶，落地铺设 4x4 火焰，5 秒内无法手动扑灭。
    补货判据是背包真实数量（不是计数器）。

命数: 3
```

> 投掷入口按 `05-skill-patterns.md` §12 用 `hold_fb_prev` 分流，
> 实现见 `kit/arsonist.mcfunction` 与 `skill/arsonist/cast` / `skill/arsonist/fire`。

### 6 · 幽灵 · 经典（表）

```yaml
职业名: 幽灵
分类: 经典（表）
简介: 只有一次生命，靠速度与隐身周旋的潜行者

装备:
  头盔: minecraft:player_head（保护 V）
  胸甲: minecraft:golden_chestplate
  主手: minecraft:golden_axe{无附魔，实际伤害 8 / 攻速 1.0，靠 AttributeModifiers}
  食物: minecraft:cooked_beef x 24

属性:
  护甲: 5
  护甲韧性: 0
  永久效果:
    - minecraft:speed 等级 I
    - minecraft:invisibility 等级 I

被动: 受到伤害时发光 1 秒（advancement kitpvp:player/ghost_hurt）

技能: 无

命数: 1
```

### 7 · 渔夫 · 经典（表）

```yaml
职业名: 渔夫
分类: 经典（表）
简介: 以三叉戟与水流作战的猎手

装备:
  头盔: minecraft:leather_helmet（护甲 2）
  胸甲: minecraft:elytra（保护 IV，无护甲值）
  护腿: minecraft:leather_leggings（护甲 4）
  靴子: minecraft:leather_boots（护甲 2，深海探索者 III）
  主手: minecraft:trident{KitFisherTrident:1b,忠诚 II，伤害 7，攻速 1.0}
  其他: minecraft:fishing_rod{击退 I} x 1、minecraft:water_bucket x 1
  食物: minecraft:cooked_beef x 24

属性:
  护甲: 8
  护甲韧性: 0

技能:
  名称: 寻回三叉戟
  类型: 主动（令牌 minecraft:drowned_spawn_egg{KitFisherEgg:1b}）
  冷却: 30 秒
  效果: |
    找回丢失 / 掷出的三叉戟。
    背包里无戟需持续 8 秒（160 刻）才允许补发，防止"投出即补"刷两把。

命数: 3
```

### 8 · 末影人 · 经典（表）

```yaml
职业名: 末影人
分类: 经典（表）
简介: 瞬移作战的远程刺客

装备:
  头盔: minecraft:leather_helmet（紫罗兰 0x8932B8）
  胸甲: minecraft:leather_chestplate（紫罗兰 0x8932B8）
  护腿: minecraft:iron_leggings
  靴子: minecraft:iron_boots（摔落保护 III）
  主手: minecraft:iron_sword
  食物: minecraft:cooked_beef x 16
  其他: minecraft:chorus_fruit x 16、minecraft:ender_pearl x 3{KitEnderPearl:1b}

属性:
  护甲: 11
  护甲韧性: 0

技能:
  名称: 末影之珠补货
  类型: 自动（进 `skill/dispatch`）+ 投掷入口分流
  冷却: 25 秒补 1 颗（上限 3 颗；投出即开始计时，计时中再投不重置）
  效果: |
    补货上限 3 颗，缺则每 25 秒补 1 颗（判据是背包真实数量，不是计数器）。

命数: 3
```

### 9 · 海盗 · 经典（表）

```yaml
职业名: 海盗
分类: 经典（表）
简介: 依托斧头与手炮的强夺者

装备:
  头盔: minecraft:leather_helmet（深蓝 0x23238E）
  胸甲: minecraft:leather_chestplate（深蓝 0x23238E）
  护腿: minecraft:iron_leggings
  靴子: minecraft:iron_boots
  主手: minecraft:diamond_axe{KitPirateAxe:1b，伤害 8，攻速 1.0}
  副手: minecraft:crossbow{KitCrossbow:1b}（手炮）
  食物: minecraft:cooked_beef x 24
  其他: minecraft:firework_rocket{KitPirateRocket:1b，爆炸色 0x003366} x 1

属性:
  护甲: 11
  护甲韧性: 0

技能:
  名称: 换弹
  类型: 触发器驱动（advancement kitpvp:player/pirate_pickup）
  冷却: 30 秒（600 刻），从"射出一发火箭"起算
  效果: |
    丢出手炮并捡回，炮弹重置为 1 发（3 颗烟火之星）。
    已装填在弩里的那发算作已有弹药，换弹不再补发，避免攒成 2 发。
    被他人捡走则没收，30 秒后归还

命数: 3
```

### 10 · 史莱姆 · 经典（表）

```yaml
职业名: 史莱姆
分类: 经典（表）
简介: 灵活跳跃的杂耍者

装备:
  头盔: minecraft:iron_helmet
  胸甲: minecraft:leather_chestplate（绿色 0x99CC32）
  护腿: minecraft:iron_leggings
  靴子: minecraft:diamond_boots（摔落保护 III）
  主手: minecraft:stone_sword
  食物: minecraft:cooked_beef x 24

属性:
  护甲: 13
  护甲韧性: 0

被动:
  - minecraft:jump_boost 等级 III
  - minecraft:speed 等级 I

技能: 无

命数: 3
```

### 11 · 驯兽师 · 经典（表）

```yaml
职业名: 驯兽师
分类: 经典（表）
简介: 围绕动物的角色

装备:
  头盔: minecraft:chainmail_helmet（护甲 1：显式写 AttributeModifiers，锁链盔默认 2）
  胸甲: minecraft:chainmail_chestplate
  护腿: minecraft:chainmail_leggings
  靴子: minecraft:chainmail_boots
  主手: minecraft:stone_sword
  食物: minecraft:pumpkin_pie x 24
  其他: minecraft:bone x 64、minecraft:apple x 32、minecraft:saddle x 1
        minecraft:wolf_spawn_egg{KitTamerEgg:1b,EntityTag:{Tags:["kitpvp.tamer_wolf"]}}（狼蛋；刻意不带 display.Name）x 3
        马 / 鹦鹉 / 海豚 / 狐狸 / 青蛙 / 海龟 / 山羊 / 鲑鱼 刷怪蛋 各 x 32（蝌蚪蛋已于 2026-11-26 移除）

属性:
  护甲: 11
  护甲韧性: 0

被动: 无

技能:
  名称: 唤狼
  类型: 主动（使用侧只做"进冷却"一件事）+ 自动补货（进 `skill/dispatch`）
  冷却: 30 秒补 1 个（上限 3 个；放一个即开始计时，计时中再放不重置）
  效果: |
    每 30 秒获得 1 个狼蛋（判据是背包真实数量，只数带 KitTamerEgg 标记的那份）。
    放出一个就进补货计时：满仓放一个也要等满 30 秒才补回来（skill/tamer/cast → fire）。
    狼蛋是普通刷怪蛋：右键放野狼，骨头驯服后随行，苹果喂马 / 繁殖都用得上。
    放出的动物**不当场清**——它们是本技能的产品；由 game/reset 按类型统一清场
    （必须带 tag=!kitpvp.displayitem，见 04 §五）。

命数: 3
```

> 狼蛋与狼人的嗅闻令牌共用 `minecraft:wolf_spawn_egg`：物品靠 `KitTamerEgg:1b` 区分，
> 刷出来的狼靠蛋的 `EntityTag` 打 `kitpvp.tamer_wolf`（狼人那只打 `kitpvp.werewolf_token`），两边按 `kit` 分闸门，互不触发。
> 蛋**刻意不带 `display.Name`**——刷怪蛋的名字会变成生成生物的 `CustomName`，否则每只狼都叫"狼蛋"。

### 12 · 药剂师 · 经典（表）

```yaml
职业名: 药剂师
分类: 经典（表）
简介: 用多种药水强化肉体的调配家

装备:
  头盔: minecraft:leather_helmet（绿色 0x2E7D32，无法破坏）
  胸甲: minecraft:iron_chestplate（无法破坏）
  护腿: minecraft:leather_leggings（绿色 0x2E7D32，无法破坏）
  靴子: minecraft:leather_boots（绿色 0x2E7D32，无法破坏）
  主手: minecraft:stone_sword（无法破坏）
  食物: minecraft:cooked_beef x 24

属性:
  护甲: 10
  护甲韧性: 0

被动: 无

技能:
  名称: 药剂投掷
  类型: 投掷（喷溅药水，技能组 1）
  载体: minecraft:splash_potion{KitAlchemistPotion:1b}
  冷却: 50 秒（投出任意一瓶即收走整套并开始计时；冷却走完、背包与地上都没有时补满一套）
  效果: |
    四瓶喷溅药剂，右键投出任选一瓶：
      迅捷药剂 → 速度 III 16 秒
      再生药剂 → 生命恢复 II 16 秒
      跳跃药剂 → 跳跃提升 X 10 秒
      隐匿药剂 → 隐身 I 16 秒
    效果由命令施加；瓶子本体是 Potion:"minecraft:awkward" + CustomPotionColor，落地只溅水花。

技能:
  名称: 本命秘药
  类型: 饮用（药水，技能组 2）
  载体: minecraft:potion{KitAlchemistElixir:1b}
  冷却: 每条命一次（不占 cd；喝下任意一瓶即锁到死亡，重生后由 player/after_death 解锁并补满）
  效果: |
    四瓶饮用式秘药，右键饮出任选一瓶：
      抗火药水 → 抗火 3 分钟
      力量药水 → 力量 I 40 秒（800 刻）
      缓降药水 → 缓降 90 秒
      神龟药水 → 缓慢 IV + 抗性 III 40 秒
    用过任意一瓶后其余三瓶一并收走，本命内不能再喝任何一瓶。

命数: 3
```

> 两种载体都靠原版 `minecraft.used` 统计触发（`splash_potion` / `potion` 都是全服合并统计），
> 所以 tick 用"上一刻手持哪一种"的 tag + 分数快照分流，`last` 无条件推进（见 `05-skill-patterns.md` §12）。
> 四条秘药的"每条命一次"用 tag `kitpvp.alchemist_elixir_used` 表达，**不占 `cd`**，与技能组 1 完全独立。

### 13 · 农夫 · 经典（表）

```yaml
职业名: 农夫
分类: 经典（表）
简介: 收获耕种果实的劳作者

装备:
  主手: minecraft:iron_hoe{KitFarmerHoe:1b,Unbreakable:1b}（实际伤害 5.5 / 攻速 2.0，靠 AttributeModifiers）
  头盔: minecraft:leather_helmet（无法破坏）
  胸甲: minecraft:iron_chestplate（无法破坏）
  护腿: minecraft:leather_leggings（无法破坏）
  靴子: minecraft:iron_boots（无法破坏）
  食物: minecraft:cooked_beef x12
  其他: minecraft:crafting_table x2

属性:
  护甲: 11
  护甲韧性: 0

被动:
  ① 耕地 / 锄头命中实体：速度 II + 急迫 I（各 1 秒），并得 1 个麦种
  ② 种下麦种：50% 得 1 个小麦（0 或 1）
  ③ 吃下面包：生命恢复 II 5 秒 + 抗性提升 II 5 秒

技能: 无

命数: 3
```

> **三个入口都只是"统计"**：`minecraft.used:iron_hoe` 同时覆盖"耕地"与"平A 命中"两种用法（**空挥不计**），
> 所以不需要额外挂 advancement —— 曾经加过一条 `player_hurt_entity`，实测每次命中会出两个麦种（stat 与 advancement 各发一次），已删除。
> 播种与吃面包各一个 `minecraft.used`。快照 `farm_last` / `plant_last` / `bread_last` 在 `load` / `player/join` / `util/clear_player` 三处初始化。
> **播种只给 0 或 1 个小麦**（`1in2` 一次判定，2026-11-15 削弱；原来 1~3 个的取模常量 `#farmer_roll` 已随之废弃）。
> **面包是自己合的**：麦种 → 小麦 → 3 小麦合 1 面包 → 吃面包拿再生，`crafting_table x5` 就是给这条链准备的。
> 装备口径来自 1.12.2 原图（铁锄攻速 -2.0 / 伤害 +4.5 与你给的值一致；原图是面包 x24，现改成牛排 x12）。

### 14 · 僵尸 · 经典（表）

```yaml
职业名: 僵尸
分类: 经典（表）
简介: 多一条血条的血牛

装备:
  头盔: minecraft:zombie_head（原版无护甲值，刻意不补：护甲 8 → 7）
  胸甲: minecraft:leather_chestplate（墨绿 3033902，无法破坏）
  护腿: minecraft:leather_leggings（墨绿 3033902，无法破坏）
  靴子: minecraft:iron_boots（无法破坏）
  主手: minecraft:stone_sword（无法破坏；原版数值 5 / 1.6）
  食物: minecraft:cooked_beef x 24

属性:
  最大生命: 40（原版 20 + 20）
  护甲: 7
  护甲韧性: 0

被动: 多一条血条：最大生命 40；选择时与每次复活获得 5 秒生命恢复 V，把多出来的那条补满

技能: 无

命数: 3
```

> **为什么需要再生 V**：`attribute ... max_health base set 40` 只把血条拉长，当前血量不跟着涨（刚选职时是 20/40）；
> 重生又会清空药水效果（见 04 §六）。所以选职由 `kit/zombie` 调、重生由 `player/after_death` 重挂，两个入口共用 `skill/zombie/passive`：
> 设上限 + 给 5 秒再生 V。再生 V 约 3 秒就能补满 20 点，5 秒留了余量。
> **护甲 8 的构成**：僵尸头 1（靠修饰符）+ 皮革胸甲 3 + 皮革护腿 2 + 铁靴子 2。
> 全身皮革除了靴子，和"血牛但不硬"的定位一致：血条长、减伤一般。
> 僵尸头用的是 `minecraft:zombie_head` 物品（不是玩家头颅），不需要 `SkullOwner`。

### 18 · 狼人 · 经典（表）

```yaml
职业名: 狼人
分类: 经典（表）
简介: 永不满足的嗜血追猎者

装备:
  头盔: minecraft:leather_helmet（灰色 0x808080）
  胸甲: minecraft:chainmail_chestplate
  护腿: minecraft:leather_leggings（灰色 0x808080）
  靴子: minecraft:iron_boots
  主手: minecraft:stone_axe「嗜血狼牙」{KitWerewolfAxe:1b}（实际伤害 5.5 / 攻速 1.4，靠 AttributeModifiers）
  食物: minecraft:mutton x 8
  其他: minecraft:wolf_spawn_egg{KitWerewolfEgg:1b}（嗅闻令牌）x 2

属性:
  护甲: 11
  护甲韧性: 0

被动:
  命中: 主武器击中玩家 → 饱和 I 2 刻（+2 饱食 +4 饱和），内置冷却 18 刻（0.9 秒）
        触发器 advancement kitpvp:player/werewolf_hit（限定 `entity.type=player`，打召唤物 / 怪物不回）；
        要求主手拿着嗜血狼牙
  击杀: 杀死玩家 → 饱和 I 5 刻（+5 饱食 +10 饱和）+ 力量 I 10 秒，无冷却
        触发器 advancement kitpvp:player/werewolf_kill

技能:
  名称: 嗅闻
  类型: 主动（令牌 minecraft:wolf_spawn_egg{KitWerewolfEgg:1b}，开局 2 个、持有上限 2）
  冷却: 40 秒补 1 个（上限 2 个；用掉即开始计时，计时中再用不重置）
  效果: |
    自身获得 5 秒速度 I；其他玩家（除自己、旁观者外）发光 5 秒。
    令牌刷出的那只狼由 skill/werewolf/cast 当场清掉（game/reset 另有一行兜底）。

命数: 3
```

> 命中与击杀被动都是全局 advancement，函数里再用 `kitpvp.kit=18`（命中还要求主手 `KitWerewolfAxe`）筛掉其它职业。
> **饱和 I 的 `2` / `5` 是"刻"不是"秒"**——瞬时型效果（饱和 / 瞬间治疗 / 瞬间伤害）的时长参数单位是刻，
> 且每刻生效一次，所以 2 刻 = 生效 2 次 = +2 饱食 +4 饱和（详见 `02` §六与 `04`）。

### 19 · 炸弹兵 · 经典（表）

```yaml
职业名: 炸弹兵
分类: 经典（表）
简介: 以巧妙爆炸致命打击的破坏者

装备:
  头盔: minecraft:iron_helmet
  胸甲: minecraft:leather_chestplate（鲜红 0xFF0000）
  护腿: minecraft:leather_leggings（鲜红 0xFF0000）
  靴子: minecraft:iron_boots（爆炸保护 V）
  主手: minecraft:wooden_sword
  食物: minecraft:cooked_beef x 24

属性:
  护甲: 9
  护甲韧性: 0

被动: 无

技能:
  ① 小炸弹
    类型: 主动（令牌 minecraft:mooshroom_spawn_egg{KitBombSmall:1b}，开局 3 个、上限 3）
    冷却: 10 秒补 1（用掉即计时，计时中再用不重置）
    效果: 在落点召唤 Fuse:0s、ExplosionRadius:1b 的瞬爆苦力怕
  ② 大炸弹 / 假核弹（各自补货）
    类型: 两枚令牌（大炸弹上限 2、假核弹上限 1）
    冷却: 各自的补货计时——大炸弹 20 秒、假核弹 40 秒（使用侧 cd<=0 才设，计时中再用不重置），
          到点各补 1（大炸弹上限 2、假核弹上限 1）
    效果: |
      大炸弹 → Fuse:10s、ExplosionRadius:2b
      假核弹 → 外观 / 名字 / 血量 / 引信 / 黄字提示与核弹完全一致，只有 ExplosionRadius:0b
  ③ 跟踪炸弹
    类型: 主动（令牌，开局 1 个、上限 1）
    冷却: 40 秒补 1
    效果: 同地球召唤物的跟踪炸弹：隐形小僵尸骑着已点燃的苦力怕（Fuse:120s、半径 3、移速 0.40），
          与召唤者同队（`bomb_1..6`），不会回头攻击召唤者
  ④ 核弹
    类型: 主动（令牌，开局 4 个，一次性不补货）
    效果: |
      在落点召唤 5 秒后爆炸的核弹：ExplosionRadius:63b、40 血、名字「核弹」。
      全体玩家聊天栏黄字提示「核弹将在5秒后爆炸」。
      半径 63 仍不破坏方块（mobGriefing 已关），但会清掉没有 Invulnerable 的装饰实体（见 04 §十七）。

命数: 3
```

> 五套令牌**共用蘑菇牛蛋**；蛋刷出的生物由 `EntityTag` 定型为**隐形 / 静音 / 无 AI / 无掉落**，只当"落点标记"。
> 五套共用一个 `minecraft.used` 计数（`kitpvp.bomb_used`），由 `skill/bomber/dispatch` 按载体的 tag 分流
> （同 `skill/soul/dispatch_warrior`）：推进快照 → 认载体 → 在它的位置召唤真正的苦力怕 → 清掉载体。
> 补货口径同 `03` §2.13 / 纵火狂：使用侧 `cd<=0` 才起计，补货侧用 `clear ... 0` 数背包真实数量。
> 每个令牌**各算各的计时**（剩余时间会存着、互不清零），用掉一枚不会动另一枚的计时。
> 2026-11-11 调参：小炸弹 10 秒（上限 3）、大炸弹 20 秒（上限 2）、假核弹 40 秒（上限 1）、跟踪炸弹 40 秒（上限 1）。
> 2026-11-26：假核弹 25 → 40 秒。

### 23 · 里·战士 · 经典（里）

```yaml
职业名: 里·战士
分类: 经典（里）
简介: 签订恶魔契约的狂暴战士

装备:
  头盔: minecraft:golden_helmet（耐久 III）
  胸甲: minecraft:iron_chestplate（耐久 III）
  护腿: minecraft:golden_leggings（耐久 III）
  靴子: minecraft:golden_boots（耐久 III）
  主手: minecraft:golden_sword{锋利 III，无法破坏}
  食物: minecraft:cooked_beef x 12
  其他: minecraft:potion{狂战士药水 x 3}（力量 II，15 秒）

属性:
  护甲: 12
  护甲韧性: 0

技能: 无

命数: 3
```

### 24 · 里·弓箭手 · 经典（里）

```yaml
职业名: 里·弓箭手
分类: 经典（里）
简介: 建立炮台摧毁敌人的射手工程师

装备:
  头盔: minecraft:leather_helmet（暗红 0xAA0000，保护 II）
  胸甲: minecraft:leather_chestplate（暗红 0xAA0000，保护 II）
  护腿: minecraft:leather_leggings（暗红 0xAA0000，保护 I）
  靴子: minecraft:leather_boots（暗红 0xAA0000，保护 I）
  主手: minecraft:stone_axe{KitTaintedAxe:1b，"小锤40"，伤害 4.4，攻速 1.3}
  其他: minecraft:bow{KitTaintedBow:1b}（与表弓箭手同机制，换弹上限 4）
        minecraft:arrow x 4
        minecraft:stray_spawn_egg{KitTaintedTurretEgg:1b}（炮台令牌）x 1
        minecraft:magma_cube_spawn_egg{KitTaintedCoreEgg:1b}（熔火核心）x 1
  食物: minecraft:cooked_beef x 24

属性:
  护甲: 7
  护甲韧性: 0

技能:
  ① 放置炮台
     类型: 主动（令牌 minecraft:stray_spawn_egg{KitTaintedTurretEgg:1b}，开局给 3 个、持有上限 3）
     冷却: 60 秒补 1 个令牌（上限 3 个；部署即开始计时，计时中再部署不重置）
     效果: |
       在刷怪蛋的落点召唤炮台：骷髅，铁块头 + 铁甲，力量 I 冲击 I 弓，20 血，
       移动速度 0（不会移动但仍会射箭），击退抗性 100%（免击退），对召唤者友好。
       头顶槽非空即免疫白天自燃（`Mob#aiStep`），铁块又不可损坏，所以不需要抗火。
       炮台存在上限 3：召出第 4 个时杀掉最早召唤的那个。
      被动: |
       用主武器石斧击打自家炮台可以给它回血，每次 4 点（2 颗心），1 秒冷却
       （`instant_damage` 对亡灵是回血，放大器 0 时为 `4 << 0` 点；规格写的生命恢复对亡灵无效）。
       冷却走独立目标 `kitpvp.turret_heal_cd`（20 刻），不占用技能的 `cd` / `cd2`。
  ② 熔火核心
     类型: 主动（令牌 minecraft:blaze_spawn_egg{KitTaintedCoreEgg:1b}，持有上限 1）
     冷却: 120 秒（从使用时计，走第二技能槽 `kitpvp.cd2`，不与炮台互相顶掉）
     效果: |
       令牌是 `blaze_spawn_egg`（与战士魂石共用同一种蛋）：两侧各有一个 dispatch 按生成生物的名字分流
       ——`skill/tainted_archer/dispatch` 认「熔火核心」、`skill/soul/dispatch_warrior` 认「战士魂石」，
       两个 dispatch 都会**无条件**推进自己的快照。右键会刷出一只烈焰人，同一函数里就地清掉
       （烈焰人不分裂，不需要压尺寸）。
       施放瞬间把 7 格内自己的炮台变成熔火形态——岩浆块头、金甲（耐久 III）、抗性提升 IV（30 秒）、
       弓改为力量 II 冲击 I 火矢 II；每只炮台各自计时 30 秒后复原，期间**不会**再更新附近炮台，
       新放下的炮台也不会变。
       （规格里的"攻速 ×2.5"不可实现：怪物射速由难度写死，与 attack_speed 属性无关，
       故按车主指定的备选方案把弓提到力量 II。）

命数: 3
```

### 25 · 里·坦克 · 经典（里）

```yaml
职业名: 里·坦克
分类: 经典（里）
简介: 用荆棘反弹伤害的致命肉盾

装备:
  头盔: minecraft:diamond_helmet{荆棘 V，无法破坏}
  胸甲: minecraft:diamond_chestplate{荆棘 V，无法破坏}
  护腿: minecraft:diamond_leggings{荆棘 V，无法破坏}
  靴子: minecraft:diamond_boots{荆棘 V，无法破坏}
  主手: minecraft:wooden_sword{耐久 III，无法破坏}
  食物: minecraft:cooked_beef x 14

属性:
  护甲: 20
  护甲韧性: 0（同坦克：AttributeModifiers 覆盖掉钻石自带的韧性）
  最大生命: 10（常规 20 的一半，写在 `skill/tainted_tank/passive` 里——重生会重建玩家属性，
          只写在 `kit/tainted_tank` 里的话第二条命起就回到 20）
  永久效果:
    - minecraft:slowness 等级 I
    - minecraft:mining_fatigue 等级 I

被动: 永久缓慢 I、挖掘疲劳 I（同坦克）

技能: 无

命数: 3（2026-11-05 起从"只有一条命"改成 3 条：血量砍半换命数）
```

> 荆棘 V 超原版上限（III），见 `04-hazards-reminder.md` §五；
> 被动与装备数值以 `kit/tainted_tank.mcfunction` 为准。

### 27 · 里·纵火狂 · 经典（里）

```yaml
职业名: 里·纵火狂
分类: 经典（里）
简介: 将敌人无情点燃的消耗狂徒

装备:
  头盔: minecraft:leather_helmet（红色，火焰保护 III）
  胸甲: minecraft:leather_chestplate（红色，火焰保护 III）
  护腿: minecraft:leather_leggings（红色，火焰保护 III）
  靴子: minecraft:leather_boots（红色，火焰保护 III）
  主手: minecraft:wooden_sword{击退 II，火焰附加 IV，无法破坏}
  食物: minecraft:cooked_beef x 16
  其他: minecraft:flint_and_steel{无法破坏} x 1

属性:
  护甲: 7
  护甲韧性: 0
  永久效果: 无

被动: 无

技能: 无

命数: 3
```

> 编号 = 表纵火狂 5 + 22（里职业段的换算规律，26 空号）；皮革颜色 `11546150`（= 0xB02E26）与表纵火狂同色。
> 火焰附加 IV 超原版上限（II），击退 II 为原版上限，两者都是刻意超模的"里"版本强度。
> 专属的私有 NBT 标记一个都没有——没有技能，就不需要认物品（同里·战士）。

### 28 · 里·幽灵 · 经典（里）

```yaml
职业名: 里·幽灵
分类: 经典（里）
简介: 失明但强大的怨念化身

装备:
  头盔: minecraft:player_head{保护 X，绑定诅咒}（直接穿戴）
  胸甲: minecraft:diamond_chestplate{保护 V，绑定诅咒，无法破坏}（直接穿戴）
  主手: minecraft:golden_axe{锋利 VIII，无法破坏}
  食物: minecraft:cooked_beef x 10

属性:
  护甲: 8
  护甲韧性: 2
  永久效果:
    - minecraft:blindness 等级 I
    - minecraft:invisibility 等级 I
    - minecraft:speed 等级 I

被动: 永久失明 I、隐身 I、速度 I（skill/tainted_ghost/passive，重生由 player/after_death 重挂）

技能: 无

命数: 1
```

> 编号 = 表幽灵 6 + 22；26 仍是空号（留给里·刺客）。
> 金斧基础 7 伤害 / 攻速 1.0，锋利 VIII 再加 `0.5 × 8 + 0.5 = 4.5`，故单次伤害 11.5。
> 护甲两件**直接写进 armor 槽**（不是发到背包），并带 `binding_curse`：本包 `keepInventory` 已开，
> 死亡不掉落，绑定诅咒的作用只是让玩家无法手动脱下换装。
> 失明会阻止疾跑，是"强大"换来的代价。

### 29 · 里·渔夫 · 经典（里）

```yaml
职业名: 里·渔夫
分类: 经典（里）
简介: 用术式和领域掌控全场的水中猎手

装备:
  头盔: 无
  胸甲: minecraft:elytra（保护 V，护甲 3）
  护腿: 无
  靴子: minecraft:leather_boots（护甲 2，深海探索者 X）
  主手: minecraft:trident{激流 I，实际伤害 5 / 攻速 1.0，靠 AttributeModifiers}
  食物: minecraft:cooked_cod x 24
  其他: minecraft:fishing_rod（击退 I）x 1

属性:
  护甲: 7
  护甲韧性: 0

被动: 处于水中时获得力量 I
      （逐点采样脚 / 脚下一格 / 胸 / 头 + 气泡柱，见 `skill/tainted_fisher/water_passive`；每刻重挂 1 秒效果）

技能:
  名称: 术式顺转·「苍」
  类型: 主动（令牌 minecraft:glow_squid_spawn_egg{KitTaintedFisherBlue:1b}，上限 1）
  冷却: 45 秒
  效果: |
    1.5 秒前摇，全场播报四句：位相 → 黄昏 → 智慧之瞳 → 术式顺转·「苍」（前三句黄色系）。
    落点 = 10 格内最近的玩家（不含自己），无人则取自己；生成半径 1 的水球（7 格，只 replace air）。
    水球留到本局结束，由地图复原清掉；落地给自己与球心 8 格内的玩家播一发重音效。

技能:
  名称: 领域展开
  类型: 主动（令牌 minecraft:squid_spawn_egg{KitTaintedFisherDomain:1b}，上限 1）
  冷却: 240 秒
  效果: |
    1 秒前摇；起手报「领域展开」并转雨，1 秒后报「无量空渔」！并起雨爱（约 58 秒）。
    60 秒内持续力量 I（逐刻重挂）；结束时停雨、自身虚弱 I + 缓慢 II 60 秒。激流在雨里全图可用。

命数: 3
```

> **两把锁互锁**：放苍 → `cd` / `cd2` 同时置 900；放领域展开 → 同时置 4800。
> 前摇期间先占 30 / 20 刻当占位，释放时改写成真冷却，所以连按两次不会叠第二发。
> **手上只有一个令牌**：放技能时把另一个 `clear` 掉，整把锁走完由 `handout` 一次性发回；
> 窗口只由"刚放过技能"打开（`blue_cast` / `domain_cast`），不用"背包里没有就补"（04 §四）。
> 编号 = 表渔夫 7 + 22；不穿头盔与护腿，护甲来自鞘翅与靴子各 2 点。

### 30 · 里·驯兽师 · 经典（里）

```yaml
职业名: 里·驯兽师
分类: 经典（里）
简介: 驱使亡灵与魔物作战的召唤者

装备:
  头盔: minecraft:chainmail_helmet{耐久 III，无法破坏，护甲 1（默认 2，显式覆盖）}
  胸甲: minecraft:chainmail_chestplate{耐久 III，无法破坏}
  护腿: minecraft:chainmail_leggings{耐久 III，无法破坏}
  靴子: minecraft:chainmail_boots{耐久 III，无法破坏}
  主手: minecraft:stone_sword{无法破坏}
  食物: minecraft:cooked_beef x 20

属性:
  护甲: 11
  护甲韧性: 0

被动: 无

技能:
  名称: 亡者召唤
  类型: 主动（三枚刷怪蛋，技能组 1）
  冷却: 35 秒（700 刻；整套共享：任意一枚用掉，其余两枚同时收走；冷却走完整套补满）
  效果: |
    僵尸 → 铁头盔 + 铁剑（头顶槽非空，白天不烧）
    骷髅 → 铁头盔 + 弓
    苦力怕 → mobGriefing 已关，只伤人不破坏地形

技能:
  名称: 魔物召唤
  类型: 主动（四枚刷怪蛋，技能组 2）
  冷却: 60 秒（整套共享，规则同上）
  效果: |
    卫道士，生命 15（原版 24）
    女巫，生命 20（原版 26）
    恼鬼，生命 20（原版 14）
    烈焰人，生命 30（原版 20）
    召唤物与召唤者同队，不会攻击所有者；本局内不会自行消失，由 game/reset 统一清理。

命数: 3
```

> 编号 = 经典（里）段已用最大编号 29 + 1（不是表驯兽师 11 + 22 的 33）。
> 骷髅 / 恼鬼 / 烈焰人蛋与魂石共用同一份 `minecraft.used` 统计：每枚蛋另打 `EntityTag`，
> tick 里七枚蛋各配一对 `used` / `last`（last 无条件推进），`skill/tainted_tamer/spawn_*`
> 再用「附近有带 `kitpvp.tt_spawn_*` 的生物」确认这次真的是本职业的蛋（见 `04-hazards-reminder.md` §五）。
> 召唤物与主人的友好靠**双方都 `team join`**（队槽 `kitpvp.ttamer_tid` → `ttamer_1..6`），
> 不用 `friendlyFire false`。召唤物不设置自定义名称，种类按原版生物外观 / 装备区分。
> 召唤指令全部归档在 `summon/tainted_tamer_*.mcfunction`。

### 31 · 里·史莱姆 · 经典（里）

```yaml
职业名: 里·史莱姆
分类: 经典（里）
简介: 把跳跃蓄成一发火箭的弹跳者

装备:
  头盔: minecraft:iron_helmet{耐久 III，无法破坏}
  胸甲: minecraft:leather_chestplate{绿色 0x99CC32，耐久 III，无法破坏}
  护腿: minecraft:iron_leggings{耐久 III，无法破坏}
  靴子: minecraft:diamond_boots{摔落保护 III、耐久 III，无法破坏}
  主手: minecraft:stone_sword{耐久 III，无法破坏}
  食物: minecraft:cooked_beef x 15

属性:
  护甲: 13
  护甲韧性: 0

被动: |
  不在空中时按住 Shift 蓄力：跳跃提升每 2.5 刻升一级（I→XV），满 3 秒（60 刻）为 XV。
  起跳或松手立即归零；0.75 秒一声轻响，满蓄力换一声更明显的提示音。

技能: 无

命数: 3
```

> 编号 = 经典（里）段已用最大编号 30 + 1（26 是空号，不回填）。
> 装备与表史莱姆完全同款（连 `Unbreakable` 都照留），只多耐久 III、牛排 24 → 15。
> **没有表史莱姆的常驻跳跃提升 III / 速度 I**：表与里各占一半，史莱姆魂石才是两者叠加（见 §五 第 14 号）。
> 蓄力判定 = `predicate kitpvp:sneaking`（`entity_properties.flags.is_sneaking`）＋ 玩家 NBT `OnGround:1b`；
> 蓄力值 `kitpvp.rocket_charge` 0..60，每 4 刻一档，`effect give jump_boost 4 <档位> true` 每刻重挂
> （4 秒是为了覆盖满蓄力那一跳约 2.4 秒的滞空，让落地摔落减伤吃满，见 `04` §十六）。
> 跳跃提升是一个效果槽：蓄力每刻按档位重挂 4 秒；魂石的 III 只在挂上时发一次（20 秒），不每刻补（见 `04` §十六）。
> 蓄力值归零靠 `OnGround:0b`（起跳时仍按着 Shift）；满蓄力音效靠 `kitpvp.rocket_full` 只响一次。
> 落地后第一刻由 `skill/tainted_slime/land` 清掉跳跃提升：摔落伤害在上一 tick 的实体阶段已按效果结算，
> 清掉就没有"落地还能白跳"的尾巴；表史莱姆的无限 III 由 land 补回、魂石的 III 由 tick 的缺效果补发维持（`04` §十六）。
> tick 里的蓄力调用**不限局内**：选完职业在大厅就能直接试蓄力。
> 能不能蓄力的总开关是 tag `kitpvp.rocket_jump`（里·史莱姆与魂石共用；魂石到期时 kit=31 不摘）。
> 实现：`skill/tainted_slime/passive`（挂 tag）+ `skill/tainted_slime/charge`（tick 每刻调）。

### 32 · 里·炸弹兵 · 经典（里）

```yaml
职业名: 里·炸弹兵
分类: 经典（里）
简介: 狂轰滥炸敌人的疯狂者

装备:
  头盔: 无
  胸甲: minecraft:leather_chestplate（鲜红 0xFF0000，爆炸保护 V）
  护腿: minecraft:leather_leggings（纯黑 0x000000，爆炸保护 V）
  靴子: 无
  主手: 无（空手）
  食物: minecraft:cooked_beef x 12

属性:
  护甲: 5
  护甲韧性: 0

被动: 无

技能组 1: 大炸弹 / 跟踪炸弹各算各的补货计时（用掉哪一枚只起哪一枚的计时）
  ① 大炸弹
    类型: 主动（蘑菇牛蛋令牌，开局 4 个、上限 4）
    冷却: 20 秒补 1
    效果: 在落点召唤 Fuse:10s、ExplosionRadius:2b 的苦力怕
  ② 跟踪炸弹
    类型: 主动（蘑菇牛蛋令牌，开局 2 个、上限 2）
    冷却: 20 秒补 1
    效果: 同地球召唤物的跟踪炸弹：隐形小僵尸骑着已点燃的苦力怕（Fuse:120s、半径 3），与召唤者同队

技能组 2:
  ③ 核弹
    类型: 主动（蘑菇牛蛋令牌，开局 5 个、上限 5）
    冷却: 15 秒补 1
    效果: 在落点召唤 5 秒后爆炸的核弹（ExplosionRadius:63b、40 血），全体聊天栏黄字提示

命数: 3
```

> 编号 = 经典（里）段已用最大编号 31 + 1（26 是空号，不回填）。
> 严格按设计：**无头盔 / 靴子 / 主武器**，只有鲜红胸甲 + 纯黑护腿（各爆炸保护 V）。
> **里·炸弹兵不发小炸弹**（2026-11-11 削弱）：可用令牌只有大炸弹 / 跟踪炸弹 / 核弹。
> 核弹在里这里变成可补货令牌（15 秒 1 枚、上限 5），与表的"一次性 4 枚"不同。
> 令牌与落点载体机制同表炸弹兵（见 19 号卡片下的说明）：五套令牌共用蘑菇牛蛋 + dispatch 分流。
> 技能组 1 的两枚各算各的计时（大炸弹 20 秒、跟踪炸弹 20 秒，上限 4 / 2），用掉一枚不影响另一枚；
> 核弹（技能组 2）单独 15 秒补 1、上限 5。

### 34 · 里·农夫 · 经典（里）

```yaml
职业名: 里·农夫
分类: 经典（里）
简介: 让耕作化作暴动的起义者

装备:
  主手: minecraft:iron_shovel{KitTaintedFarmerShovel:1b,Unbreakable:1b}（锋利 I；实际 5.5 / 1.0）
  副手: minecraft:iron_hoe{KitTaintedFarmerHoe:1b}（无法破坏，击退 II）
  头盔: minecraft:leather_helmet（无法破坏，耐久 III）
  胸甲: minecraft:iron_chestplate（无法破坏，耐久 III）
  护腿: minecraft:leather_leggings（无法破坏，耐久 III）
  靴子: minecraft:iron_boots（无法破坏，耐久 III）
  食物: minecraft:baked_potato x12
  其他: minecraft:crafting_table x2
        minecraft:mooshroom_spawn_egg{KitTaintedRise:1b}（「开始一场起义」，一次性）
        minecraft:husk_spawn_egg{KitTaintedRally:1b}（「召集农民」，上限 1 / 45 秒冷却）

属性:
  护甲: 11
  护甲韧性: 0

被动: 与表农夫共用三个统计入口（farm_used / plant_used / bread_used）：
      耕地或锄头命中 → 速度 II + 急迫 I（1 秒）+ 麦种 x1；播种 → 50% 得 1 个小麦；吃面包 → 再生 II + 抗性 II 各 5 秒

技能:
  ① 开始一场起义（一次性，1 个蛋）
     召出「农民起义领袖」：100 血僵尸、玩家头颅 + 钻胸甲 + 钻石锄，常驻力量 II / 速度 I
     每 12 秒召一只 20 血石锄农民（上限 8）
     另一路每 12 秒：随机一只石锄农民召一只 20 血木锄农民（上限 12），两条波次错开 6 秒
  ② 召集农民（上限 1 / 45 秒冷却）
     随机把最多 10 只「农民」传送到落点；地球召唤的同名农民也计入

命数: 3
```

> **两种蛋都是"借来的"**：蘑菇牛蛋同时是炸弹兵 5 种令牌的载体，尸壳蛋同时是僵尸魂石。
> 两边各写一个 dispatch（`rise_dispatch` / `rally_dispatch`），**首行无条件推进快照**，再按生成生物的**名字**分流（04 §17.4）。
> **领袖生在蛋的落点**（载体位置），载体消失才退回玩家脚下。
> **农民不显示名字**（`CustomNameVisible:0b`，只有脖子上的名牌都省了，减少屏幕噪音）。
> **队槽**：`farmer_1..6` 六支队伍在 `load` 里建好（曾经漏建 → `team join` 静默失败 → 领袖把自己人当敌人），
> `kitpvp.tfid`（玩家）+ `kitpvp.tf_owner`（召唤物身上）；开局 `team leave @a` 后清零，
> 选职与每次召唤都跑 `skill/tainted_farmer/team_slot`（清空之后必须能在使用时重新分配，见 04 §15.1）。
> **上限 8 / 12 是本包加的**（原图无限滚雪球）；要调就改 `wave_stone` / `wave_wood` 里的 `matches`。

### 65 · 太阳 · 星象

```yaml
职业名: 太阳
分类: 星象
简介: 免疫一切状态效果的恒星化身

装备:
  头盔: minecraft:golden_helmet（护甲 1：显式写 AttributeModifiers，金盔默认 2）
  胸甲: minecraft:golden_chestplate
  护腿: minecraft:golden_leggings
  靴子: minecraft:golden_boots
  主手: minecraft:golden_sword（火焰附加 I，实际伤害 4 / 攻速 1.6）
  弓: minecraft:bow{KitSunBow:1b，火矢 I}
  食物: minecraft:cooked_chicken x 24
  其他: minecraft:arrow x 3
        minecraft:bee_spawn_egg{KitSunFlareEgg:1b}（太阳耀斑令牌）
        minecraft:bat_spawn_egg{KitSunspotEgg:1b}（太阳黑子令牌）

属性:
  护甲: 10
  护甲韧性: 0

被动: 免疫一切状态效果——`skill/sun/passive` 每刻 `effect clear @s`（连自己的增益也一起清）。
      只在游戏进行中清（`#state=1`），免得清掉结算期封锁的抗性 V 与大厅的饱和；
      无敌期的抗性 V 被清掉后按剩余无敌刻数补回 1 秒（见 `04-hazards-reminder.md` §十二）。

技能:
  名称: 日冕物质抛射
  类型: 触发器驱动（advancement kitpvp:player/sun_bow_pickup，照抄弓箭手的换弹）
  冷却: 10 秒（拾取即重置；冷却中捡回弓不换弹，只提示"换弹冷却中"）
  效果: |
    丢出自己的弓并捡起，箭数重置为 3（10 秒一次）。若弓被其他人捡起，进入 30 秒冷却，
    期间其他人无法获得此弓，30 秒后归还。
  特殊: 只能识别自己起始获得的弓（KitSunBow:1b）；与弓箭手 / 里·弓箭手的弓互不干扰（各自一把、各一个 advancement）
      换弹冷却走专用变量 kitpvp.sun_reload（200 刻 = 10 秒），因为 cd / cd2 已被两个令牌占掉

技能:
  名称: 太阳耀斑
  类型: 主动（令牌 minecraft:bee_spawn_egg{KitSunFlareEgg:1b}，上限 1）
  冷却: 15 秒（独立冷却：走 kitpvp.cd，与太阳黑子互不影响）
  效果: |
    11 格内的其他玩家（不含自己）进入 5 秒"短波通信干扰"：每 10 刻（0.5 秒）刷一帧，5 秒共 10 帧。
    一帧 = title + subtitle + actionbar + tellraw 各一条 + 一个音效（master 频道，音量 1.6 = 明显偏大，盖过正常音效）。
    文案池 = skill/sun/noise/1..128，**一份文件就是一帧**（四行文字 + 最后一行 playsound）：
    1..54 由车主手写，55..128 按同风格补齐；128 帧的音效从 173 个滑稽的原版事件里随机分配、各不相同。
    要改某一帧就只改那一个文件；**整池内容不必读**（见 `04` §十三）。池子容量与分派表在 skill/sun/noise_pick。

技能:
  名称: 太阳黑子
  类型: 主动（令牌 minecraft:bat_spawn_egg{KitSunspotEgg:1b}，上限 1）
  冷却: 40 秒，从使用时开始计（独立冷却：走 kitpvp.cd2）
  效果: 9 格内的其他玩家（不含自己）失明 10 秒

命数: 3
```

> **两个技能各自独立冷却**：耀斑走 `cd`（300 刻 = 15 秒），黑子走 `cd2`（800 刻 = 40 秒），互不锁对方，也不再互相收走令牌。
> **令牌自愈式补货**：`cd` / `cd2` 走完 **且** 手上没有 **且** 16 格内地上也没有同类令牌 → 补一颗，
> 走普通 `give`（回到刚空出来的那一格），补上才播"已就绪"行动栏 + 拾取音效（提示写在 `refill_give_*` 里，不能放 `refill_*`）。
> 判据**不绑"刚放过技能"**：丢地上 / 被偷 / 背包满掉在地上都能自愈（窗口模型在这几种情况下会让令牌永远回不来，见 04 §4.2）。
> 只在 `#state=1` 时补，不然在大厅坐着也会发牌。
> 作用范围在**施放瞬间**结算（被打上 `kitpvp.sun_flare` 就固定 5 秒），走进走出不改变结果。
> 免疫一切效果的两个已知副作用：**突然死亡的"全体发光"照不到太阳**（他们不会发光），
> 且**任何给太阳的增益立即失效**（里·战士的狂战士药水、魂石类效果等同理）。

### 66 · 水星 · 星象

```yaml
职业名: 水星
分类: 星象
简介: 以极速与水流行动的青色行星化身

装备:
  头盔: minecraft:leather_helmet（青色 0x169C9C，无法破坏）
  胸甲: minecraft:leather_chestplate（青色 0x169C9C，无法破坏）
  护腿: minecraft:leather_leggings（青色 0x169C9C，无法破坏）
  靴子: minecraft:leather_boots（青色 0x169C9C，无法破坏；保护 III，深海探索者 X）
  主手: minecraft:stone_sword{无法破坏，实际伤害 5 / 攻速 2.4}
  食物: minecraft:cooked_cod x 16
  其他: minecraft:water_bucket x 1（发放前先 `clear`，重跑本函数也不会变两个）

属性:
  护甲: 7
  护甲韧性: 0
  最大生命: 13（常态 -7，与是否持剑无关）
  永久效果:
    - 移动速度 +0.2（属性修饰符，基础 0.1 → 0.3；不是 Speed 效果）

被动: 常态移动速度 +0.2（`skill/mercury/passive`，玩家属性修饰符 `kitpvp.mercury_speed`）
      换职业时由 `util/clear_player` 摘掉，不会带到别的职业

技能: 无

命数: 3
```

> 石剑写死了三个 `AttributeModifiers`：攻击力 +4（基础 1 → 5）、攻速 -1.4（基础 4 → 2.6）、
> 最大生命 -7 **不写在剑上**，改成常态（`skill/mercury/passive` 里 `attribute ... max_health base set 13`，`clear_player` 复位 20）。写 `AttributeModifiers` 会**整体取代**默认修饰符，
> 所以攻速必须显式写（见 `04-hazards-reminder.md` §九）。
> 深海探索者 X 超过原版上限 III；附魔等级在 NBT 里没有上限（同荆棘 V、火焰附加 IV）。
> 水桶会留下会流动的水：地图复原只覆盖模板体积，流出去的水靠 `map/restore` 的 `place template` 兜底，
> 与里·渔夫水球同一取舍。

### 67 · 金星 · 星象

```yaml
职业名: 金星
分类: 星象
简介: 带着舔狗作战的灼热行星化身

装备:
  头盔: minecraft:iron_helmet（无法破坏）
  胸甲: minecraft:golden_chestplate（无法破坏）
  护腿: minecraft:golden_leggings（无法破坏）
  靴子: minecraft:iron_boots（无法破坏）
  主手: minecraft:iron_shovel{无法破坏}（原版数值：伤害 2.5 / 攻速 1.0）
  食物: minecraft:cooked_porkchop x 16

属性:
  护甲: 12
  护甲韧性: 0

被动: 开局获得一只自动驯服的舔狗（狼）：
      常驻 速度 I + 抗性提升 V（100% 减伤），随死亡保留，由 game/reset 清理

技能:
  名称: 制冷模块
  类型: 主动（令牌 minecraft:polar_bear_spawn_egg{KitVenusChill:1b}，上限 1）
  冷却: 30 秒（走 kitpvp.cd）
  效果: |
    舔狗开启 10 秒冷气：周围 10 格的敌人（不含主人）每刻 +1 冷度；
    冷度 20 / 40 / 60 / 80 / 100（= 1~5 秒）分别对应 缓慢 I ~ V。
    离开范围后每刻 -1，缓慢逐级回落。冷度写在全局 objective kitpvp.coldness，其它职业与地图可复用。

技能:
  名称: 武装模块
  类型: 主动（令牌 minecraft:evoker_spawn_egg{KitVenusArm:1b}，上限 1）
  冷却: 60 秒（走 kitpvp.cd2）
  效果: |
    舔狗获得 速度 II、力量 II、跳跃提升 V，持续 20 秒；到期后自动回落到自带的速度 I。

技能:
  名称: 自爆模块
  类型: 主动（令牌 minecraft:silverfish_spawn_egg{KitVenusBomb:1b}，上限 1）
  冷却: 30 秒（走 kitpvp.venus_cd3，同时是舔狗复活倒计时）
  效果: |
    在舔狗脚下生成一只 Fuse 0 + ignited 的苦力怕，下一 tick 原地爆炸（正常苦力怕当量、无前摇）。
    舔狗带抗性 V，爆炸伤不到它，所以随后显式 kill；30 秒后在金星身边重建。

命数: 3
```

> **三个技能三套冷却**：`cd` / `cd2` / `venus_cd3`（第三套按 05 §一 的约定开专用变量）。
> **舔狗归属**：`kitpvp.vtid` 与狗身上的 `kitpvp.dog_owner` 配对，
> 用来「找到自己的狗」和「在冷气里排除主人」——选择器比不了 UUID，只能用分数。
> 编号**每选一次金星就领一个新号**（`#vtid` 只增不复用）：原先 1..6 循环复用，换号后旧狗还在，
> 且第七名玩家会绕回 1 与第一名同号，两人互相认错狗。换号前先按旧号清掉那只（首次选职时 `kit` 还不是 67，`util/clear_player` 那段不替我们清）。
> **只允许一只**：`tick` 每刻把 12 格外的狗拉回主人身边（`dog_follow`），`player/after_death` 重生后再补拉一次，
> `summon_dog` 生成前按同号清掉可见残留——三条一起，才不会出现「区块卸载看不见 → 误判丢了 → 又召一只」的两只狗（见 04 §十四）。
> 没做成「一次性技能」：开局直发解决不了「死了之后 30 秒复活」，病根是跟随断了而不是发放方式。
> **冷度**：全局 objective `kitpvp.coldness`，tick 先统一 -1、再由生效中的制冷模块 +1；
> 上限 100（5 秒）。判定为 `20..39 / 40..59 / 60..79 / 80..99 / 100..` → 缓慢 I~V。
> **自爆会炸到主人自己**：舔狗跟着主人走，苦力怕就在脚下爆——这是刻意保留的风险。
> 舔狗被非自爆方式弄丢（如掉进虚空）时，`dog_alive_check` 会补开 30 秒复活计时。

### 68 · 地球 · 星象

```yaml
职业名: 地球
分类: 星象
简介: 围绕地球的职业

装备:
  头盔: minecraft:iron_helmet（无法破坏）
  胸甲: minecraft:leather_chestplate（高饱和蓝 0x0066FF，荆棘 II，无法破坏）
  护腿: minecraft:diamond_leggings（无法破坏）
  靴子: minecraft:iron_boots（无法破坏）
  主手: minecraft:crafting_table{锋利 III}（方块没有攻击修饰符：基础 1 + 锋利 2 = 3，攻速沿用 4.0）
  食物: minecraft:cooked_porkchop x 24

属性:
  护甲: 13
  护甲韧性: 2

被动: 无

技能:
  名称: 召唤生灵
  类型: 主动（令牌 minecraft:goat_spawn_egg{KitEarthEgg:1b}）
  冷却: 上限 3 个，每 15 秒（300 刻）补 1 个；冷却只限制补货，不限制已有召唤蛋的使用
  效果: |
    随机召来一种对召唤者友好的生灵（序号 0..32 全部参与随机）：

    0  阴兵              隐身 + 抗性提升（各 20 秒，到期自动解除）的锁链头骷髅
    1  炮台              原地不动的弓骷髅（力量 I 冲击 I）
    2  iLsacuL           20 血的猪；参与李朱俊泽的 12 秒循环，复制体保留地球召唤队伍
    3  Sheepass          普通羊；每 10 秒给 20 格内玩家 20 秒反胃
    4  板砖哥            砖块头 + 击退 X 板砖的骷髅
    5  板砖哥            砖块头 + 火焰附加 II 板砖的骷髅
    6  斧头哥            南瓜头 + 金斧，生命上限 25
    7  护林员            树叶头 + 木锄
    8  宇航员            白色染色玻璃头，跳跃提升 X + 缓降
    9  大炸弹            0.5 秒后爆炸，半径 2
    10 跟踪炸弹          隐形小僵尸骑着已点燃 6 秒的苦力怕，移速 0.40
    11 MC石头            石头头 + 石头，缓慢 IV + 抗性提升 III
    12 发射器            发射器头 + 弓
    13 农民              皮革头盔 + 皮革胸甲 + 木锄
    14 超凡升天          玻璃头 + 两手玻璃；3 秒后漂浮 V 15 秒，再 15 秒后清除
    15 水星              青色皮革甲 + 石剑，移速 +0.2，本体 10 血
    16 扰动者            侦测器头 + 红火把；每 3 秒对 11 格内玩家施加 3 秒反胃，并随机播一条噪音（128 选 1）
    17 渔夫              溺尸骑海豚（三叉戟 + 海晶灯头），本体 15 血
    18 渔夫              溺尸骑海龟（三叉戟 + 海晶砖块头），本体 15 血
    19 船夫              湿海绵头 + 木铲的僵尸，坐竹筏；坐在筏上时抗性提升 V
    20 黑客              玩家头颅 + 纯黑皮革全身 + 活塞；死掉时全场播报
    21 随从              管珊瑚块头的小僵尸（25 血）骑悦灵（10 血），小僵尸一死悦灵跟着消失
    22 可疑草丛          树叶片头、隐身、移速 -30%、20 血；被打到或敌人贴脸即爆成两只 8 血小僵尸
    23 秦始皇            金块头 + 金甲 + 金剑、本体 10 血，骑 15 血北极熊
    24 靶子              双手各持一把弓、头戴标靶的僵尸（活靶）
    25 Dominion          黑皮僵尸 + 红树根头颅；**只在出场时放一次**黑色烟花（原来是每 2 秒一次）
    26 召集者            南瓜头僵尸 + 山羊角；出场吹号，把 50 格内自己的召唤物拉到身边；本体 25 血
    27 佩（补水兵）      法国旗头颅僵尸，深蓝 / 白 / 红皮革；死亡时脚下灌一格水并喊「补水啦」；常驻速度 II
    28 井盖              埋在地底 2 格的隐形骷髅（无敌、无 AI）；有人踩进 2.5 格就顶出来
    29 矿车              隐形无敌蠹虫驮着橡木船，移速 +100%（属性修饰符）、虚弱 X；40 秒后连船带蠹虫自毁
    30 泄密者            每 15 秒随机点名一名泄密者当「事故责任人」（还有活着的才播报）
    31 门槛哥            死后在原地立一扇深色橡木门（上下半截一起放）
    32 滑冰者            蓝冰头 + 冰霜行者靴，脚下持续铺细雪（5 刻一格），常驻缓慢 I

> 同名变体通过手持物品、头盔和坐骑区分；显示名不追加数字。

命数: 3
```

> **补货节流**：第一次成功召唤启动 15 秒（300 刻）计时；计时中已有的召唤蛋仍可使用，后续召唤不会重置计时。
> 冷却归零只补一枚，补货后重新计时 15 秒；不会在使用后立即补回。
> **召唤位置**：以使用刷怪蛋生成的带标签山羊为位置锚点，生灵在放蛋位置生成后清除山羊载体。
> **随机池**：`#pool_size = 33`，与映射行数（0..32）一一对应；新增生灵时同时加一行、把数加一。
> 2026-11-10 最终拍板：删掉「超凡升天 2」「船夫 2」，其余编号顺次前移；并从「测试」分支并入 8 只（25..32）。
> **三种"骑乘"型召唤物**（船夫 / 随从 / 秦始皇）都是**坐骑在外层、本体内层**（`Passengers` 只放本体）：
> 写反了就是本体驮着船，NBT 能过、游戏里立刻露馅。
> - 船的实体在 1.20.1 还是 `minecraft:boat` + `Type` 字段（`"bamboo"` / `"cherry"`；按木质拆成独立实体 id 是 1.21.2 之后的事）。
> - 船位被占、队友在半路，也找得到自己的船」（`kitpvp.earth_boat1`）。湿海绵那位坐在筏上时抗性提升 V；
>   干海绵那只（「船夫 2」）已于 2026-11-10 删除。
> **可疑草丛**不靠原版死亡触发：它有 20 血，`tick` 每刻 `data get entity @s Health` 读一次血量，低于 20 就判定"被打到"；
> 贴身判定是**半径 1 格**（`distance=..1`，基本得踩到它身上），而且**主人不算**：`skill/earth/link` 在认领时把主人的 `etid`
> 写进召唤物的 `kitpvp.earth_owner`，`skill/earth/grass_probe` 按玩家逐个比这个分数，主人怎么踩都不炸、敌人进来才炸。
> 落地先给 40 刻迟钝（`earth_grass_arm`），否则刚召出来就在召唤者脚下自爆。
> 爆开的两个小僵尸会按草丛所在队伍逐队 `team join`（队伍只能从草丛身上读，选择器比不了变量），不会回头打召唤者。
> **黑客**的死亡播报用"本刻存活数 `#hacker_count` 比上一刻 `#hacker_prev` 少"来判定，只在本局内（`#state=1`）生效，
> 所以重置清场不会误播报；代价是区块卸载也会误报（召唤物一直跟着玩家，实际碰不到）。
> **召唤物与召唤者友好**靠"双方都 `team join`"（`kitpvp.etid` → `earth_1..6`），与阴兵 / 炮台 / 驯兽师三套队分开。
> **队槽每局重建**：`game/start_impl` 先让所有玩家退出 `earth_*` 并把 `kitpvp.etid` 清零，
> 召唤时再由 `skill/earth/link` 取 1..6 里第一个没人占的槽位——两名地球玩家因此不会落进同一队，
> 召唤物之间也不会跨局残留"同队不攻击"的状态。第 7 名及以上地球玩家会复用槽位（只有 6 队）。
> **计时器都在实体身上**：`earth_cd_a`（Sheepass 的 200 刻、扰动者的 60 刻）、
> `earth_lev`（超凡升天：60 刻后开始漂浮、300 刻后离场）、`earth_life`（跟踪炸弹的小僵尸 120 刻）。
> **跟踪炸弹**用 `Passengers` 把小僵尸和苦力怕绑在一起：苦力怕的引信 `Fuse:120s` 与被骑无关、照常倒计时，
> 小僵尸自己会朝玩家走，所以整组会追人；6 秒到点时小僵尸被清掉，苦力怕也正好引爆。
> **工作台的锋利附魔**：方块没有 `attack_damage` 修饰符，原版仍会结算主手物品上的锋利加成，
> 所以实际伤害是 1 + 2 = 3（这一点建议实机用 `/data get entity @s SelectedItem` 与打怪伤害复核）。

### 71 · 冥王星 · 星象

```yaml
职业名: 冥王星
分类: 星象
简介: 体积微小的遗弃行星化身

装备:
  护腿: minecraft:leather_leggings（无法破坏）
  主手: minecraft:stone_sword（无法破坏；原版数值 5 / 1.6）
  食物: minecraft:cooked_beef x 24
  其他: 无（头盔 / 胸甲 / 靴子都不发）

属性:
  最大生命: 20
  护甲: 2
  护甲韧性: 0

被动: 永久隐身 + 抗性提升 V；召唤一只无 AI 的鹦鹉分身「冥王星」（30 血）
      鹦鹉一死，本体立刻强制死亡；重生后在头顶补一只新鹦鹉，直到命数耗尽

技能: 无

命数: 3
```

> **编号**：**71**（星象块 65–76 里 65–71 已用，72–76 还空着 5 格；星象再出新职业直接从 72 往后顺延，见 06 §一）。
> **鹦鹉分身的四个要点**（机制参照金星的舔狗）：
> - **归属**：`kitpvp.ptid`（玩家，每选一次领一个新号）↔ 鹦鹉身上的 `kitpvp.parrot_owner`。命令里比不了 UUID，只能比分数。
> - **跟随：骑在本体身上**（`ride @s mount`，`skill/pluto/mount`，由 `follow` 每刻兜底调用）。
>   **不要用"每刻 `tp` 到头顶"**：2026-11-26 实机 —— 本体自己看得见鸟跟着，**其他玩家完全看不见**（连名字都没有），
>   NBT 里没有任何 `Invisible`。玩家回忆的旧解法是"杀一次再复活就好"，正是"让实体重新注册一次"。
>   乘客随载具移动、所有客户端都会渲染，所以改成骑乘；`follow` 末尾仍保留"骑不上就退回每刻 tp"的兜底。
> - **鹦鹉一死 ⇒ 本体死**：`skill/pluto/check` 找不到属于自己的鹦鹉就判死（`skill/pluto/die` → `damage @s 1000 minecraft:out_of_world`——抗性 V 会吃掉普通伤害，只有 `out_of_world` 能保证必死）。
>   **但必须给 6 刻宽限**（`kitpvp.parrot_miss`）：跨区传送 / 区块刚卸载的那几刻 `@e` 也选不到鹦鹉，原来立刻判死，实测表现就是「传送到地图先白死一条命」。
> - **新鹦鹉在重生后补**（`player/after_death` → `skill/pluto/respawn`），不在死亡当刻补：死亡点可能很快被卸载，鹦鹉留在那里就找不回来，会把玩家卡进"鹦鹉丢了→判死→再丢"的死循环。
> - **跟进入图**：`game/start_impl` 在 `map/distribute` 之后调 `skill/pluto/enter_map`——先确认鹦鹉在身边（不在就地补一只）、
>   **把血回满 30**、再 tp 到头顶。跨区块传送必须当刻拉一把，和金星舔狗同一个理由（`04 §十四`）。
>   回满血**只发生在进图这一处**：局内挨打该掉血就掉血、死了照常判死，不做每命免费回血。
> - 命数耗尽变旁观时 `player/eliminate` 顺手清掉鹦鹉；开局 / 结算的兜底在 `game/reset`（按 tag）。

### 87 · 文明小子 · 抽象

```yaml
职业名: 文明小子
分类: 抽象
简介: 惩奸除恶的板砖美猴王

装备:
  头盔: minecraft:leather_helmet（高饱和绿 0x00FF00，无法破坏）
  胸甲: minecraft:iron_chestplate（无法破坏）
  护腿: minecraft:chainmail_leggings（无法破坏）
  靴子: minecraft:diamond_boots（无法破坏）
  主手: minecraft:stick{锋利 V}（实际伤害 1 + 3 = 4，攻速沿用基础 4.0）
  其他: minecraft:brick{击退 II}
  食物: minecraft:cooked_beef x 24

属性:
  护甲: 14
  护甲韧性: -1（胸甲上写 `armor_toughness` -1；写修饰符后护甲 6 必须一起写）

被动: 无

技能:
  名称: 口水
  类型: 投掷（喷溅药水，补货型）
  载体: minecraft:splash_potion{KitCivilSpit:1b}
  冷却: 上限 3 瓶，每 4 秒（80 刻）补 1 瓶（投出即开始计时，计时中再投不重置）
  效果: |
    落地时 4 格内的玩家（含投掷者）获得反胃 II 20 秒。
    药水本体是 Potion:"minecraft:awkward" + CustomPotionColor，效果由命令在落点结算。

技能:
  名称: 恶魔形态
  类型: 主动（令牌 minecraft:strider_spawn_egg{KitCivilDemon:1b}）
  冷却: 180 秒（3600 刻），持续 60 秒（1200 刻）
  效果: |
    口水整套换成恶魔口水（按当前瓶数原样换）：反胃 II 20 秒 + 力量 7.5 秒，
    同样作用于 4 格内的玩家（含投掷者）。
    主武器换成烈焰棒（锋利 V + 火焰附加 I），红砖换成恶魔板砖（击退 III）。
    永久失去锁链护腿：技能结束后也不恢复（只有整局重置 / 重选职业才会重新给）。
    结束时武器与板砖换回原样，恶魔口水换回普通口水。

命数: 3
```

> **口水与纵火狂 / 药剂师共用 `minecraft.used:splash_potion`**：tick 用「上一刻手持的是不是自己的口水」（`hold_cb_prev`）分流，
> `last` 无条件推进（05 §12）；补货走 `skill/dispatch → civil/auto`，数量用 `clear ... 0` 读背包真值。
> **7.5 秒力量**：`effect give` 的秒数只收整数，写不出 7.5 秒；所以两种口水的效果都写进药水本身的
> `CustomPotionEffects`（反胃 Id 9 / 力量 Id 5，Duration 400 / 150），由原版喷溅逻辑按距离结算，
> 命令侧只负责落地音效与虚空清理。
> **恶魔形态换装用 `clear` + `give`，不用 `item replace weapon.mainhand`**：后者会把玩家手上正在拿的东西直接吞掉。
> **锁链护腿只删不补**：`demon_start` 里 `item replace ... armor.legs with air`，`demon_end` 不恢复。

### 88 · 李朱俊泽 · 抽象

```yaml
职业名: 李朱俊泽
分类: 抽象
简介: 围绕李朱俊泽的职业

装备:
  头盔: minecraft:player_head{爆炸保护 10，护甲 4}
        （头颅本身没有护甲，四点护甲全靠 head 槽上的 AttributeModifiers；2026-11-10 起去掉韧性 4）
  主手: minecraft:iron_sword{亡灵杀手 V，节肢杀手 V，无法破坏}（实际伤害 6 / 攻速 1.6）
  食物: minecraft:cooked_beef x 24

属性:
  护甲: 4
  护甲韧性: 0（已去掉）

被动: 无

技能:
  名称: 召唤 iLsacuL
  类型: 主动（令牌 minecraft:pig_spawn_egg{KitLiPig:1b}）
  冷却: 上限 3 个，每 10 秒（200 刻）补 1 个（放出即开始计时，计时中再放不重置）
  效果: |
    放出一只名为 iLsacuL 的猪（20 血、不消失）。
    蛋的 display.Name 写成 iLsacuL：刷怪蛋的名字会变成生成生物的 CustomName，所以与 EntityTag 里的 CustomName 保持一致
        （以前完全不给名字，物品栏显示"生成 猪"）。

技能:
  名称: iLsacuL 循环
  类型: 内联循环计时器（tick 里的 #litimer；李朱俊泽在局内或地球召出的 iLsacuL 存在时运行）
  冷却: 每 12 秒（240 刻）一圈
  效果: |
    第 3 秒：场上每只 iLsacuL 原地生出一只相同的复制体，血量 200。
    第 6 秒：每只 iLsacuL 处生成一只名为「李朱俊泽」的苦力怕（ExplosionRadius 5、Fuse 0、无前摇）。
    第 9 秒：什么都不做。
    第 12 秒：数场上 iLsacuL，若 ≥14 只，则开启「每刻半径 8 自爆」直到一只不剩。

命数: 3
```

> **计时器是全局的**（`#litimer` 挂在 `kitpvp.game`），不按玩家区分；**只要场上还有任何一只 iLsacuL 就在跑**
> （李朱俊泽在局内 / 地球 iLsacuL / 魂石计时 / 魂石到期后剩下的 200 血复制体都算），一只都不剩时归零，
> 所以新开一局总是从第 0 刻开始。2026-11-10 之前的门是「kit=88 玩家 or earth_ilsacul or 魂石计时」，
> 漏了复制体本身 —— 魂石 20 秒一到、复制体还站着，循环就冻住，这就是「过一个循环就停」的根因。地球的 iLsacuL 使用相同循环，复制体仍属于原地球召唤队伍。
> **魂石（`skill/soul/li_apply`）**：召一只**常驻**（没有时限）的、带**抗性提升 V** 的种子 iLsacuL。
> 种子照常参与复制和第 6 秒引爆（抗性 V = 100% 减伤，炸不死），只有「每刻自爆」和 ≥14 的计数把它排除——
> 它活着，下一圈才有的可复制，这就是魂石能连着跑的根据。种子被玩家打死就没了，循环靠剩下的复制体继续跑到自爆清场。
> 2026-11-10 之前这里挂着一个 20 秒的 `#li_soul` 计时（到期 `li_expire` 杀掉种子），已被移除：需求就是"一只猪，没有时限"。
> **自爆不显式 kill**：苦力怕就起在猪脚下，20 血的普通体会被炸死，200 血的复制体挨一发约 71 点、
> 还能活到第 12 秒的判定——这正是 ≥14 只才触发末日的基础。半径 8 一发约 113 点，能把残血复制体清干净。
> **头颅的爆炸保护 10 受原版 EPF 上限约束**（总上限 20），实际约 50% 爆炸减伤；写成 100 也只是被截到 20，没有意义。

---

## 四、职业私有命名

> 每个职业**自己独占**的命名（私有 NBT 标记的名称、函数前缀）在此登记，方便一眼看全。
> 全局账本（objective / tag / 物品标记的实际占用）在 `07-objective-tags.md`，本节不重复。

| 编号 | 职业 | 私有 NBT 标记前缀 | 私有函数前缀 |
|---|---|---|---|
| 2 | 弓箭手 | `KitBow` | `archer_*` |
| 3 | 坦克 | `KitTankEgg` / `KitShield` | `tank_*` |
| 4 | 刺客 | `KitAssassinEgg` | `assassin_*` |
| 5 | 纵火狂 | `KitFireBomb` | `arsonist_*` |
| 6 | 幽灵 | —（阴兵用 tag `kitpvp.ghost_minion*`） | `ghost_*` / `summon/ghost_minion*` |
| 7 | 渔夫 | `KitFisherEgg` / `KitFisherTrident` | `fisher_*` |
| 8 | 末影人 | `KitEnderPearl` | `enderman_*` |
| 9 | 海盗 | `KitPirateAxe` / `KitCrossbow` / `KitPirateRocket` | `pirate_*` |
| 11 | 驯兽师 | `KitTamerEgg` | `tamer_*` |
| 13 | 农夫 | `KitFarmerHoe` | `farmer_*` |
| 34 | 里·农夫 | `KitTaintedFarmerShovel` / `KitTaintedFarmerHoe` / `KitTaintedRise` / `KitTaintedRally` | `tainted_farmer_*`（召唤物在 `summon/tainted_farmer_*`） |
| 18 | 狼人 | `KitWerewolfAxe` / `KitWerewolfEgg` | `werewolf_*` |
| 23 | 里·战士 | —（无私有标记） | `tainted_warrior`（无技能函数） |
| 24 | 里·弓箭手 | `KitTaintedAxe` / `KitTaintedBow` / `KitTaintedTurretEgg` / `KitTaintedCoreEgg` | `tainted_archer_*` |
| 25 | 里·坦克 | —（只用原版附魔，无私有标记） | `skill/tainted_tank/`（仅 `passive`，无技能） |
| 27 | 里·纵火狂 | —（无私有标记） | —（无技能函数） |
| 28 | 里·幽灵 | —（护甲靠绑定诅咒锁死，无需标记） | `skill/tainted_ghost/`（仅 `passive`，无技能） |
| 29 | 里·渔夫 | `KitTaintedFisherBlue` / `KitTaintedFisherDomain` | `tainted_fisher_*` |
| 30 | 里·驯兽师 | `KitTtGroup1` / `KitTtGroup2` + 七枚蛋各自一枚（`KitTtZombie` … `KitTtBlaze`） | `ttamer_*`（技能函数在 `skill/tainted_tamer/`，召唤物在 `summon/tainted_tamer_*`） |
| 33 | 里·末影人 | `KitPortalGun`（魂石版是蛋上的 tag `soul_ep_token`） | `enderman_*` 里的传送门那批（`portal_*` / `ent_through_*`） |
| 45 | 混沌战士 | `ChaosBlade` / `ChaosId` / `ChaosUses` / `ChaosMelee` / `ChaosBow` / `ChaosXbow` / `ChaosTri` / `ChaosToken` / `ChaosCurse`（全部由 `tools/gen_chaos.py` 生成） | `chaos_*`（`chaos_give_1..20` / `chaos_use` / `chaos_hit` / `chaos_wipe`） |
| 46 | 混沌弓箭手 | `ChaosBow`（与混沌武器池的弓共用标记，靠 `kit=46` 与 `ChaosId` 分流） | `kit/chaos_arrow_check` / `chaos_arrow_spent` / `chaos_shot_bow`、`skill/chaos_archer/` |
| 65 | 太阳 | `KitSunBow` / `KitSunFlareEgg` / `KitSunspotEgg` | `sun_*` |
| 66 | 水星 | —（无私有标记；常驻移速用玩家属性修饰符 `kitpvp.mercury_speed`） | `skill/mercury/`（仅 `passive`，无技能） |
| 67 | 金星 | `KitVenusChill` / `KitVenusArm` / `KitVenusBomb` | `venus_*`（召唤物在 `summon/venus_dog`、`summon/venus_bomb`） |
| 68 | 地球 | `KitEarthEgg` / `KitEarthTable` | `earth_*`（33 种召唤物全在 `summon/earth_*`） |
| 69 | 哈雷彗星 | `KitHalleyEgg` | `skill/halley/`（`auto` / `burn` / `cast` / `give_egg` / `heat` / `heat_warn` / `near`） |
| 70 | 火星 | `KitMarsSword` / `KitMarsEgg`；诅咒剑用 `KitMarsSword`（`ChaosCurse` 是混沌池那把） | `skill/mars/`（`dispatch` / `target` / `curse` / `curse_hit` / `domain_cast` / `music_on` / `giant_*` / `wild_*`） |
| 71 | 冥王星 | —（无私有标记；归属靠分数 `kitpvp.ptid` ↔ 实体 `kitpvp.parrot_owner`） | `skill/pluto/`（`spawn` / `follow` / `check` / `die` / `respawn` / `despawn` / `enter_map`） |
| 87 | 文明小子 | `KitCivilStick` / `KitCivilBrick` / `KitCivilRod` / `KitCivilDemonBrick` / `KitCivilSpit` / `KitCivilDemonSpit` / `KitCivilDemon` | `civil_*` |
| 88 | 李朱俊泽 | `KitLiPig` | `li_*`（召唤物在 `summon/li_pig_copy`） |
| 89 | 汉堡小子 | —（无令牌，靠蓄力） | `kit/burger`、`skill/burger/*`、`summon/burger_beast` |
| 77 | 陷阱师 | `KitTrap` + `KitTrapHook/Float/Worm/Poison/Boom` + `KitTrapOwner`（物品 NBT；无刷怪蛋） | `skill/zhanshishi/`（`assign_slot` / `give_*` / `refill_*`（上限只算背包）/ `drop_*`（丢出即起冷却）/ `pick_*` / `check_*` / `trigger_*` / `scan_fallback` / `team_maintain`）；`summon/trap_worm` |
| 97 | 烛之武 | `KitCizhi`（sniffer 蛋） | `skill/zhuzhiwu/`（`dispatch` / `cizhi_cast` / `cizhi_apply` / `cizhi_remove` / `buff_tick` / `give_token` / `refill` / `hit` / `hit_roll` / `pull`）；advancement `player/zhuzhiwu_hit` |

> 标记的实际字符串与使用位置以 `skill/*` 代码为准。
> **命名规则的既有例外**：混沌系列（45 / 46 共用武器池）的物品标记是 `Chaos*` 而不是 `Kit*`，由 `tools/gen_chaos.py` 统一生成——改标记名要同时改生成器并重跑。

---

## 五、魂石（18 种）

魂石是突然死亡阶段发给所有人的一次性主动道具（`skill/soul/give` 随机发一枚，`#soul_count = 18`）。
触发方式统一是"spawn egg 的 `minecraft.used` 计数 > `*_last` 快照"（见 `07-objective-tags.md`），
`use_*` 里**首行无条件推进快照**，再用"`at @s at @e[名字]`"定位落点、立刻 `kill` 掉那只载体蛋生物。

| # | 魂石 | 蛋 | 效果（2026-11-10 后的口径） |
|---|---|---|---|
| 0 | 战士 | blaze | 短暂力量爆发（`use_warrior` / `dispatch_warrior`） |
| 1 | 弓箭手 | skeleton | 发一把特殊弓（`use_archer`，`bow_expire` 收回） |
| 2 | 坦克 | iron_golem | 高耐久护盾（`use_tank`） |
| 3 | 刺客 | enderman | 潜行突袭装（`use_assassin`） |
| 4 | 幽灵 | vex | 隐身 + 阴兵（`ghost_apply` / `ghost_expire`） |
| 5 | 海盗 | pillager | 手炮（`use_pirate` / `pirate_expire`） |
| 6 | 渔夫 | cod | 打开「无量空渔」（`fisher_open` / `fisher_tick`） |
| 7 | 僵尸 | husk | 20 秒 +20 生命上限（`zombie_apply` / `zombie_expire`） |
| 8 | 地球 | villager | 落点 marker 每 0.5 秒召一只生灵，共 4 只（`earth_apply` / `earth_step`） |
| 9 | 李朱俊泽 | pig | 召一只常驻的抗性 V 种子 iLsacuL，驱动 12 秒循环（`li_apply`） |
| 10 | **驯兽师** | cat | 落点 marker 20 秒，每 5 秒一波：1 只已驯服的狗（速度 I + 生命恢复 I）+ 4 只随机动物（狗以外，9 选 1），共 4 狗 + 16 兽（`tamer_apply` / `tamer_wave` / `tamer_animal`） |
| 11 | **太阳** | allay（载体带 `soul_sun_token`） | 一次性「魂石·日蚀」：**施放瞬间**锁定落点 10 格内**除使用者以外**的参战玩家，每人一次性 **20 秒失明**；标记落在人身上，此后 20 秒里**即使跑出范围也持续**每 2 秒收到一条「短波通信干扰」噪音（128 选 1）。`soul/sun_apply`（施放）/ `sun_mark`（逐人上标记）/ `sun_hit`（逐人走倒计时） |
| 12 | **水星** | dolphin | 20 秒速度 +200%（速度等级 X，`effect give speed 20 9`）；一次性 buff，没有后续计时 |
| 13 | **金星** | ocelot | 召一只 20 秒的舔狗：全程带武装模块（速度 II / 力量 II / 跳跃提升 V）与制冷模块（10 格内非主人玩家缓慢 I），到点原地自爆并死亡（`venus_apply` / `venus_tick` / `venus_buff` / `venus_end`） |
| 14 | 史莱姆 | slime | 20 秒：常驻跳跃提升 III + 速度 I，同时开放里·史莱姆的蓄力火箭跳（`slime_apply` / `slime_expire`）。蛋带 `EntityTag`：`Size:0`（最小号史莱姆，击杀不分裂）+ `Tags:["kitpvp.soul_slime_token"]`，按 tag 认载体 |
| 15 | **末影人** | endermite（载体带 `soul_ep_token`） | 一次性获得「魂石·传送枪」**20 秒**：右键红门、潜行右键紫门，冷却 **0.2 秒**、门活 20 秒；里·末影人不会抽到这枚魂石；与里·末影人的橙/蓝门**互不冲突**（两条通道各有一对门）。多人同时拿到魂石时，同色的门按「后来者覆盖前者」共享一对（`soul/use_ep` / `soul_ep_expire`） |
| 16 | **火星** | ravager（载体带 `soul_mars_token`，`NoAI` 静音） | 落点（使用者脚下 +8 格）召唤与火星「地鸣」**同副身躯、同表现**的巨人：1000 血 Giant + 800 血 controller 僵尸，**每 24 刻在巨人处刷一只地球生灵**（同 `wild_tick`），**持续 20 秒**；同一刻**歌曲 `rumbling` 从最后 20 秒进场、歌词从第 18 句接上**（见下）；巨人被提前打死也会立即收场（`soul/mars_spawn` / `use_mars` / `mars_tick` / `mars_wild_tick` / `mars_wild_spawn` / `mars_expire`） |
| 17 | **农夫** | zombie_villager（载体带 `soul_farm_token`，`NoAI` 静音） | 落点召一只 **20 血**的「农民起义领袖」，**与使用者同队**、**没有时限**（不会自动消失），并带上里农夫的全部兵源特性：常驻力量 II / 速度 I、每 12 秒召一只石锄农民、另一路每 12 秒随机一只石锄农民召一只木锄农民（`soul/use_farm` / `summon/soul_farm_leader`） |

> 新增魂石的固定流程：`load` 加 `soul_X_used`（选一个没被占用的 spawn egg）与 `soul_X_last`；`skill/soul/give` 末尾加一行 `matches N`；
> `#soul_count` 加一；写 `use_X`（首行推进快照 + 定位落点 + kill 载体）；`tick` 里加分发；`game/reset` 加清理；最后同步本表与 `07`。
> **火星魂石（16）的"歌从最后 20 秒进"不靠改音符库**：`rumbling` 引擎是逐玩家分数驱动（每刻 +154，每个音 80 分，叶子守卫 `nbs_rumbling_t=..T-1`），
> 所以 `play` 之后把分数推到 `277760-400×154 = 216160`（第 2702 个音）、快照推到 `2701` 即可；全曲最后一个音是 3472，正好再放 400 刻（20 秒）就自停。
> 歌词链是 `schedule` 串联的**绝对时间轴**，中间开播不能从头起：最后 20 秒对应第 18 句（`ev_018` 落在曲内第 1401 刻 ≈ 70.05 秒），
> 所以直接 `schedule function kitpvp:music/rumbling_lyric/ev_018 1t`，收场时用 `rumbling_lyric/stop` 把整条链清掉。
