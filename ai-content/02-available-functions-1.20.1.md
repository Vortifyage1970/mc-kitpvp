# 命令手册（1.20.1）

> 本文件写"能用的、易错的"，不重复 `00-version.md` 的禁止项。
> 禁止项以 `00-version.md` 为准。

---

## 一、玩家筛选

```mcfunction
execute as @a[tag=!kitpvp.joined] run function kitpvp:player/join
execute as @a[scores={kitpvp.kit=1,kitpvp.alive=1}] run ...
execute as @a[scores={kitpvp.cd=1..}] run scoreboard players remove @s kitpvp.cd 1
execute as @a[scores={kitpvp.cd=..300},tag=kitpvp.shield_held] run ...
```

- `scores={obj=1..}` 是"≥ 1"；`scores={obj=..300}` 是"≤ 300"；`scores={obj=0}` 是精确等于。
- **服务端可能跳刻**：到期判定一律用 `..N` 而不是 `=N`。
- 所有 tick 里的玩家筛选都要显式加 `tag=!kitpvp.spectator`。

---

## 二、补零、递增、递减、快照

```mcfunction
scoreboard players add @a kitpvp.inv 0
scoreboard players remove @s kitpvp.cd 1
scoreboard players set @s kitpvp.cd 800
scoreboard players operation @s kitpvp.tank_last = @s kitpvp.tank_used
```

- `add ... 0` 是补零惯用法：给没分数的玩家建一个 0，**不改动已有分数**。
- `set` 会归零已有分数，不能拿来补零。
- `operation A = B` 是复制 B 到 A，用于快照推进。

---

## 三、统计 objective

```mcfunction
scoreboard objectives add kitpvp.tank_used minecraft.used:minecraft.iron_golem_spawn_egg
scoreboard objectives add kitpvp.ender_used minecraft.used:minecraft.ender_pearl
scoreboard objectives add kitpvp.ready_used minecraft.used:minecraft.carrot_on_a_stick
```

- 检测方式：本刻 `used > last` → 刚使用过一次。
- **只覆盖原版物品，且不分来源**。
- 必须在 `load.mcfunction` 里统一创建。

---

## 四、NBT 与背包检测

```mcfunction
execute unless data entity @s Inventory[{tag:{KitTankEgg:1b}}] run ...
clear @s minecraft:shield{KitShield:1b}
give @s minecraft:iron_golem_spawn_egg{KitTankEgg:1b,display:{Name:'{"text":"举盾令牌","color":"aqua","bold":true}'}} 1
give @s minecraft:shield{KitShield:1b,Damage:256} 1
```

- 路径用点号分隔，数组用方括号：`Inventory[...]`、`SelectedItem.tag.xxx`。
- **1.20.1 是旧版 NBT**：`Enchantments:[{id,lvl}]`、`display:{Name}`、`Unbreakable:1b`、`Damage:256`。
- `clear <target> <item>{<nbt>}` 只清背包。

---

## 五、判定与伤害

```mcfunction
execute as @a[tag=kitpvp.selected,gamemode=!spectator] if entity @s[y=-1024,dy=950] run damage @s 1000 minecraft:out_of_world
kill @e[type=minecraft:arrow,nbt={inGround:1b}]
execute as @a[scores={kitpvp.kit=3}] at @s run kill @e[type=iron_golem,distance=..16,name="举盾令牌"]
```

- **虚空判死**：`y=-1024,dy=950` 覆盖 y ∈ [-1024, -74]。
  改阈值**只改 `dy`**（上界 = y + dy - 1），不要动 `y`。
- `damage ... minecraft:out_of_world` 绕过抗性，适合做"强制判死"。
- `distance=..16` 以执行点为圆心，半径 16 格。
- `name="..."` 匹配生物 CustomName 纯文本。
- **任何全局 `kill @e` 都要在注释里写明可能误杀什么**。

---

## 六、药水效果

```mcfunction
effect give @s minecraft:instant_health 1 5 true
effect give @s minecraft:invisibility 5 0 true
effect give @s minecraft:speed 5 2 true
effect give @s minecraft:slowness infinite 0 true
effect clear @s
```

- 参数顺序：`effect give <target> <effect> <持续秒> <amplifier> <隐藏粒子>`
- amplifier 0 = I 级，2 = III 级，5 = VI 级。
- **`infinite` 在 1.20.1 可用**：`effect give <target> <effect> infinite <amplifier> [hideParticles]` = 永久效果。
  （早期提示词里"1.20.1 无 infinite，要写 999999"的说法是错的，已改正；两者都可，`infinite` 更直白。）
- `instant_health` 治疗量 = 4 × 2^amp 点，amp 5 = 128 点，足够回满（1.20.1 没有 `/heal`）。
- **时长参数的单位看效果类型（源码 `EffectCommands` 实测）**：普通效果是**秒**（内部 ×20 转刻），
  而**瞬时型效果（`minecraft:saturation` / `instant_health` / `instant_damage`）是刻**，且瞬时型在持续期内**每刻生效一次**
  （`InstantenousMobEffect.isDurationEffectTick` = `duration >= 1`）：
  - `saturation 2` = 2 刻 = 生效 2 次 = **+2 饱食 +4 饱和**（`eat(放大器+1, 1.0F)`，饱食每次 +1、饱和每次 +2，并夹在饱食值以内）
  - `saturation 20` = 从零直接回满（饱食 20 + 饱和 20）；`saturation infinite` = 永久钉在 20
  - 省略时长时：瞬时型默认 **1 刻**（单次），普通效果默认 600 刻（30 秒）
  - 对照：`regeneration 2` 是普通效果，2 = **2 秒**（40 刻），再生 II 每 25 刻 1 次 → 只回 1 点血

---

## 七、文本组件

```mcfunction
title @s actionbar {"text":"补给进入冷却：40 秒","color":"gray"}
tellraw @a {"text":"[开始游戏]","color":"green","clickEvent":{"action":"run_command","value":"/function kitpvp:game/start"}}
```

- 用小驼峰 `clickEvent` / `hoverEvent`，不用 `click_event`。
- `run_command` 的 `value` **必须**以 `/` 开头。
- `hoverEvent` 字段是 `contents`，不是 `value`。
- 外层单引号包 JSON 时，**内部全部用双引号**。

### 7.1 字数：没有字符数上限，但 title / subtitle / actionbar 不换行

- **没有字符数上限**。字符串本身的理论上限是 262144，`title` / `tellraw` 都撞不到；
  写长了不报错、不截断字符串。
- **`title` / `subtitle` / `actionbar` 不换行**：宽度超过屏幕的部分在两侧被**裁掉**（1.20.1 不会自动缩小字号）。
  所以主标题要短——它是最容易被裁的那一个。
- **`tellraw`（聊天栏）会自动换行**，多长都不丢字。"一定要让玩家看全"的长文案放 tellraw。
- 估算可用字数：`窗口宽 ÷ GUI 缩放` 得到逻辑像素宽，默认字体下汉字约占 9 px、拉丁字母约 6 px。
  例：1920×1080 自动缩放（= 4）时逻辑宽 480 px ≈ 53 个汉字。
  稳妥取值：主标题 ≤ 16 字、副标题 ≤ 30 字，这样在更小窗口 / 更大缩放下也不会被裁。
- 演示范例：太阳的短波通信干扰（`skill/sun/noise/*`）每 10 刻换一条 title，就是靠"主标题短、长句走 tellraw"这条分工。

### 7.2 换行与 emoji：能写什么、会怎么坏

**换行**：

- `\n`（反斜杠 + n，两个字符）是**合法 JSON 转义** ✓。聊天栏 / 悬停提示会真的换行；
  `title` / `subtitle` / `actionbar` 是**单行绘制**，`\n` 不会变成两行（只多一个空档）。
  要"多行文案"，就把它放在 `tellraw` 里。
- **裸换行（真按回车）= 致命**：它会终止 JSON 字符串，整份 `.mcfunction` 在加载期被丢弃
  （症状见 `04` §十：聊天里毫无提示，调用处只报 `Unknown function`）。
  已实测过：太阳文案池里有 5 个文件就是这么坏的（一行标题被折成 2~3 行），修法是把裸换行换成 `\n`。

**emoji / 生僻符号**：

- **不会报错**。命令与 JSON 都按 UTF-8 文本处理，字形有没有是客户端的事。
- 能不能显示，取决于游戏默认字体里的 unifont：**本包所有已用到的字符我都查过，0 个缺字形**
  （含 🏋️ ☀️ ⌨️ 🦟 🥡 这些平面 1 的 emoji）。
- 查法（可复用，不需要开游戏）：`.minecraft/assets/indexes/<版本索引>.json` 里找
  `minecraft/font/unifont.zip` → 取出其中的 `unifont_*.hex` → 每行行首 `XXXX:` 就是有字形的码点。
  拿它跟文案里的码点做差集即可。
- 两个注意：emoji 走 unifont 是**单色**的（没有彩色 emoji 字体）；**ZWJ 组合序列**
  （如 👨‍👩‍👧）不会合成一个字形，会并排画出各个成员。

---

## 八、其它

```mcfunction
ride @s dismount
schedule function kitpvp:game/reset 200t replace
xp set @s 0 points
xp set @s 0 levels
attribute @s minecraft:generic.max_health base set 20
```

- `schedule ... replace` 的语义是"同 id 只保留最后一次"，适合全局唯一计时器。
- `attribute ... base set` 是修改基础值，`clear_player` 里复位属性时用。
- 1.20.1 无 `/heal`、无 `/extinguish`。
- **`execute at <selector>` 的选择器是在"外层位置"求值的**，不是它设置完以后的位置。
  从 `tick` 里 `execute as @a ... run function xxx` 进来的函数，**执行位置是世界出生点**（不是玩家脚下！），
  所以 `execute at @e[..., distance=..8]` 里的 `distance` 是拿出生点量的，永远选不到玩家身边的东西。
  正确写法是两段：`execute at @s at @e[..., distance=..8] run ...`（先定位到玩家，再按距离选目标）。
  教训来源：地球魂石第一版就是这么写坏的——`soul_earth_last` 推进了，但 `earth_apply` 一次都没跑。
- **读不到"某个实体属于哪个队"**：没有 `team get`，只能用 `@s[team=<队名>]` 逐队比对。
  要把"当前所在队"存下来，就得先压成一个编号（`skill/soul/earth_team_id` 用 1..6 幽灵 / 7..12 炮台 /
  13..18 里·驯兽师 / 19..24 地球），再按编号逐行 `team join` 回去。24 行是机械展开，加队槽时同步追加。
  同理也读不到"我这只召唤物属于谁的队"——所以召唤物身上必须自己记归属（分数 / tag）。
- **`music/` 的音符盒链可以从任意一个事件起步**：每个 `ev_XXXX` 末尾都会 `schedule` 下一个事件，
  而 `replace` 只作用在**同名函数**上，所以不同事件名的定时器互不覆盖。
  想要"只播某一段"就直接 `schedule function kitpvp:music/yu_ai/ev_0067 1t`——
  渔夫魂石要的"雨爱最后 20 秒"就是这么做的（`ev_0067` 在曲内第 758 刻，到收尾的 1162 刻正好剩 404 刻 ≈ 20.2 秒）。
  用 `# tick N` 注释挑入口，别手数事件号。

---

## 九、gamerule 与调试反馈

- 所有 gamerule 在 `load.mcfunction` 里设置（按需开启/关闭）。
- 建议设置 `gamerule sendCommandFeedback false`，但注意：**它会吞掉大量命令反馈**。
- 写调试函数时用 `tellraw` / `say` 显式输出，别靠默认反馈判断成败。

---

## 十、计数与取值（`execute store`）

`execute store` 是 1.13 就有的，**1.20.1 可用**（见 `00` 的可用清单；被禁的是 `execute if items`，与本条无关）。

```mcfunction
execute store result score @s kitpvp.ender_ammo run clear @s minecraft:ender_pearl{KitEnderPearl:1b} 0
execute as @a[scores={kitpvp.kit=9}] if data entity @s SelectedItem.tag.KitCrossbow store result score @s kitpvp.tmp run data get entity @s SelectedItem.tag.Charged
```

- `clear <目标> <物品>{<nbt>} <maxCount>` 的 `maxCount=0` 是**只计数、不清除**：
  结果是匹配到的物品**总数**（含堆叠数量），用来读"背包里现在真有几个"。
- `data get` 配合 `store result` 可以取出 NBT 的**值**（比 `execute if data` 只判路径强）。
  1b/0b 这类开关字段必须取值：射击后游戏写回 `Charged:0b`——**键还在、值为 0**，
  只判路径会永远为真。
- `store result` 存"结果值"（数量 / 读到的值），`store success` 存"成不成功"（0 / 1）。
- `store` 可以跟在 `as` / `at` / `if` 之后，位置随意，只有 `run` 必须在最后。
- **目标命令失败时 store 不写入**（例如 `data get` 路径不存在），
  所以取值前先 `scoreboard players set <目标> <objective> 0`，否则会留下上一刻的旧值。

---

## 十一、advancement 当"事件入口"用（已实测）

1.20.1 没有 `return`、函数不能带参，"玩家做了什么"这类事件只能靠 advancement 的触发器捕捉。

```json
{
  "criteria": { "hit": { "trigger": "minecraft:player_hurt_entity",
                         "conditions": { "entity": { "type": "minecraft:player" } } } },
  "rewards": { "function": "kitpvp:skill/werewolf/hit" }
}
```

- 常用触发器：`entity_hurt_player`（自己被打）、`player_hurt_entity`（自己打到实体）、
  `player_killed_entity`（自己杀死实体）、`thrown_item_picked_up_by_player`（捡起自己丢出的物品）、
  `item_used_on_block`（对着方块用物品）。
- `conditions.entity.type` 筛"被打 / 被杀的是谁"：要"玩家"就写 `"minecraft:player"`。
  **条件写错不报错**，只是 advancement 永不发放（与 §十 的静默失败同类）；
  所以条件越少越稳，能挪进函数的筛选就挪进函数（本项目惯例：函数里再判一次 `kitpvp.kit`）。
- `rewards.function` 只在"完成"那一刻执行一次，**函数首行必须 `advancement revoke @s only <进度>`**。
- 触发器是全局的：任何职业都会拿到同一个 advancement。
- **rewards 函数不保证执行位置**：凡用到 `~` 的（`playsound` / `particle` / `summon`）都要显式 `at @s`。
- "用什么打的"（主手物品）不能写进 conditions，只能在函数里判 `SelectedItem.tag.<标记>`。