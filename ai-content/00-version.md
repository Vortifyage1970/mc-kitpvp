# 版本红线

## 目标

- Minecraft Java Edition **1.20.1**
- 纯数据包（datapack），无模组、无插件，实现职业战争
- 命名空间：`kitpvp`
- pack_format：**15**
- 输出内容需要便于直接复制粘贴至 `.json` 文件内，故不要以 markdown 格式输出，将可直接复制粘贴的代码清晰输出，与注释说明清晰分开

## 绝对禁止的语法（1.20.2+ 才有，出现即报错）

AI 容易凭训练数据本能写出这些，必须主动避免。

### 命令

| 禁止 | 引入版本 | 1.20.1 替代 |
|---|---|---|
| `return` / `return run` | 1.20.2 | 用 `execute if ... run` 控制流程 |
| `tick` 命令 | 1.20.2 | 用 `schedule function xxx 1t` 循环 |
| `random` 命令 | 1.20.2 | 用 predicate `random_chance` |
| `execute if items` | 1.20.5 | 用 `execute if data entity @s Inventory[...]` 或 predicate |
| `dialog` 命令 | 1.21.6 | 用 tellraw + `clickEvent` |
| `waypoint` 命令 | 1.21.6 | 无 |
| `function xxx with {...}` | 1.20.2 | 不支持，用 storage + `data modify` |
| `function #tag` 调用函数标签 | 1.20.2 | 不支持，只能调用单个函数 |

### 函数

| 禁止 | 说明 |
|---|---|
| 宏 `$()` | 1.20.2+ 才有 |
| 函数带参 | 1.20.1 不支持，用 storage 或计分板变通 |

### 物品 NBT

1.20.1 用**旧版 NBT 格式**，1.20.5+ 才改成组件（components）格式。

| 禁止（1.20.5+） | 1.20.1 正确写法 |
|---|---|
| `{enchantments:{sharpness:5}}` | `{Enchantments:[{id:"minecraft:sharpness",lvl:5}]}` |
| `{custom_name:'...'}` | `{display:{Name:'...'}}` |
| `{unbreakable:{}}` | `{Unbreakable:1b}` |
| `{damage:100}` | `{Damage:100}` |
| `{components:{...}}` | 不存在，直接写顶层 |
| `{attribute_modifiers:[...]}`（新格式） | `{AttributeModifiers:[...]}`（旧格式，字段名不同） |

### 文本组件

| 禁止（1.21.5+） | 1.20.1 正确写法 |
|---|---|
| `"click_event"` | `"clickEvent"`（小驼峰） |
| `"hover_event"` | `"hoverEvent"`（小驼峰） |
| `"action":"show_text","value":"..."` | `"action":"show_text","contents":"..."` |

#### 强制规则：`clickEvent` 的 `run_command` 必须带斜杠

`clickEvent` 使用 `"action":"run_command"` 时，`value` **必须**是一条以 `/` 开头的完整命令。漏掉开头的斜杠是高频错误，会导致点击后命令无法执行。

正确写法（带斜杠）：

```json
{"text":"[开始游戏]","color":"green","clickEvent":{"action":"run_command","value":"/function kitpvp:game/start"}}
```

错误写法（缺前导斜杠，点击无效）：

```json
{"text":"[开始游戏]","color":"green","clickEvent":{"action":"run_command","value":"function kitpvp:game/start"}}
```

配套注意：

- `"action":"suggest_command"` 的 `value` 决定填进聊天输入框的内容，同样建议带 `/`。
- `"action":"copy_to_clipboard"` 的 `value` 是纯文本，带不带 `/` 按意图决定；若希望玩家复制后可直接粘贴执行，就要带 `/`。
- `hoverEvent` 的字段名是 `contents`，不是 `value`；`show_text`、`show_item`、`show_entity` 三种 action 均如此。
- `show_item` 的 `contents` 里若要带 NBT，字段名是 `tag`，且**必须是 SNBT 字符串**（`"tag":"{Enchantments:[{id:\"minecraft:sharpness\",lvl:1}]}"`，内层双引号要转义）。**写成 JSON 对象会让整个数据包加载失败**，所有函数报"未知函数"。
- `show_item` 的物品只做预览，不经过物品默认修饰符：不给 `tag` 时显示原版默认属性，一旦给了 `tag` 就不会自动补上默认的 `AttributeModifiers`；要让悬停显示改过的攻击力/攻速/护甲，必须在 `tag` 里把 `AttributeModifiers` 写全（与 `kit/<职业>.mcfunction` 逐字一致）。

参照实现：`kit/info/*.mcfunction`（工具：`tools/gen_cards.py`）。

## 1.20.1 可用的核心能力

### 命令

- `execute` 全套子命令
- `scoreboard objectives / players`
- `tag` / `team`
- `data get / modify / merge / remove`
- `item replace / modify`
- `advancement grant / revoke`
- `schedule function`
- `damage`
- `attribute`
- `worldborder` / `forceload`
- `particle` / `playsound` / `effect` / `xp` / `gamemode`
- `tellraw` / `title` / `bossbar`
- `scoreboard players add <target> <obj> 0` —— 补零惯用法，给没分数的玩家初始化，不改变已有分数
- `clear <target> <item>{<nbt>}` —— 带 NBT 条件清物品（1.20.1 旧格式直接挂物品 id 后）
- `kill @e[type=<type>,nbt={<nbt>}]` / `kill @e[type=<type>,name="<字符串>"]`
- `damage <target> <amount> minecraft:out_of_world` —— 绕过抗性判死，用于虚空兜底
- `ride <target> dismount` —— 下坐骑
- `effect give <target> <effect> <秒> <amplifier> true` —— amplifier 0 是 I 级，5 是 VI 级
## 统计类 objective（1.20.1 可用）

- `scoreboard objectives add <name> minecraft.used:minecraft.<item>` —— 该物品被"使用"一次即 +1
- 可用于检测：吃食物、右键刷怪蛋、右键钓竿、投掷物、放置方块等原版行为
- **只覆盖原版物品，且不分来源**：地图上野生刷出的同种物品、其它职业发的同种物品，
  都会算进同一个统计。用之前必须确认该物品在本服只有一个来源
- 配合快照变量 `*_last` 使用：`if score @s <obj>_used > @s <obj>_last`

### 函数机制

- `function kitpvp:xxx` 直接调用
- `execute` 与函数组合
- `schedule function` 延时 / 循环
- `storage` 数据存储（`kitpvp:main` 这种命名空间）
- **不支持**函数参数、宏、`return`

### 数据包文件类型

- `functions/*.mcfunction`
- `predicates/*.json`
- `advancements/*.json`
- `loot_tables/*.json`
- `item_modifiers/*.json`
- `tags/functions/*.json`

### 文本组件

- 类型：`text` / `translate` / `keybind` / `score` / `selector` / `nbt`
- 样式：`color` / `bold` / `italic` / `underlined` / `strikethrough` / `obfuscated`
- `clickEvent`：`run_command` / `suggest_command` / `open_url` / `copy_to_clipboard` / `change_page`
- `hoverEvent`：`show_text` / `show_item` / `show_entity`，字段名是 `contents`

## 常见混淆点（务必记住）

- 文件夹名是 `functions`（复数），不是 `function`
- 加载钩子在 `data/minecraft/tags/functions/load.json`
- 每刻钩子在 `data/minecraft/tags/functions/tick.json`
- `.mcfunction` 每行一条命令，行尾无分号，`#` 开头是注释
- 命名空间只允许小写字母、数字、下划线：`kitpvp` ✅，`KitPvP` ❌，`kit-pvp` ❌
- `data get` / `data modify` 的路径用点号分隔（`SelectedItem.tag.xxx`），数组用方括号（`Inventory[0]`）

## 物品耐久只能反推（1.20.1）

- 1.20.1 没有 MaxDurability 字段，每个物品的最大耐久是固定的
- 盾牌最大耐久 = 336，要"剩余耐久 80"就写 Damage:256（336 - 80 = 256）
- 要"剩余耐久 N"就写 Damage:(最大耐久 - N)
- 不要给这种"一次性耐久物品"加 `Unbreakable:1b`，否则永远用不完

## advancement 使用红线

- 1.20.1 的 advancement 自由度中等，用之前先确认触发器与字段名是否存在，不要照抄高版本写法。
- 本项目在用的 advancement：`kitpvp:player/archer_pickup`、`kitpvp:player/tainted_bow_pickup`、`kitpvp:player/sun_bow_pickup`、`kitpvp:player/pirate_pickup`（拾取物品）、
  `kitpvp:player/ghost_hurt`（受击）、`kitpvp:player/werewolf_hit`（打到玩家）、`kitpvp:player/werewolf_kill`（杀死玩家）、
  `kitpvp:player/lectern_teleport_1` / `lectern_teleport_2`（右键讲台，各管一个坐标区）。
- advancement 的 `rewards` 只在"完成"那一刻执行一次，函数首行必须 `advancement revoke @s only <进度>`，否则只生效一次。

## 注释红线（写任何代码前必读）

**默认不写注释。** 只在"看代码看不懂、且光看代码无法还原原因"时才写，一句话说清即可。

**该写的（核心要点）：**

- 1.20.1 与其它版本不同、凭直觉会写错的地方（`effect ... infinite` 的写法、无 `/heal`、旧版 NBT、无 `return` 等）；
- 经实测才确认的机制（刷怪蛋 `display.Name` 会变成生成生物的 CustomName；高级效果到期后自动回落低级）；
- 反直觉的时序与闸门（`*_last` 必须先推进；到期判定用 `..N` 而非 `=N`；投掷类必须用 `hold_*_prev` 分流）；
- 有意为之的取舍与副作用（`kill @e` 的误杀范围、`clear` 只清背包不清地面）。

**不该写的：**

- 函数用途、调用方、参数说明 —— 看函数名与调用点即可；
- "第 1 步 / 第 2 步"式的流水账；
- 与代码重复的描述、设计过程、历史演变；
- 装饰性横幅（`# ===== xxx =====`）、行号、分隔线。

**写法与去向：**

- 以上被排除的内容属于 `ai-content/`：坑位进 `04`、技能模板进 `05`、职业实例进 `06`、命名进 `07`，不要写进 `.mcfunction`。
- 一段一注，能一行不两行；同一件事不要在多处重复注释。
- 被删掉的实现不要留注释尸体；临时禁用的命令可以保留，但必须带 `TODO:` 说明为何禁用。