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