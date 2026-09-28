# KitPvP 骨架缺口清单

> 状态图例：✅ 完成 ｜ 🔶 部分/占位 ｜ ❌ 空/缺失 ｜ ❓ 未读到（需实机确认）

---

## 〇、本版拍板决策

1. **`keepInventory=true`**：死亡不掉落、不重发装备。
2. **职业装备与特性只在主大厅发放一次**。死亡、重生、淘汰流程中**不重发**。
3. **`kitpvp.kit` 单一权威值**：既是"当前职业"，也是"刚选中的职业"。
   选职业入口是**具体职业函数**（如 `kitpvp:kit/warrior`），函数自己知道该写几号，
   不需要额外的"待选值"或 storage 传递。
4. **`util/clear_player` 清一切**（含 `kitpvp.kit`），仅保留两个会话性 tag：
   - `kitpvp.joined`（清了会让 tick 重复触发 `player/join`）
   - `kitpvp.in_lobby`（`on_death` 用它判定"大厅死亡不计"）
5. **复用关系**：
   - 选职业：`kit/<职业>` → `clear_player` → 写回 kit 分数 → 发装备
   - `game/reset` → `execute as @a run function kitpvp:util/clear_player`
   - 主大厅按钮 → `lobby/reset_self` → `clear_player`

---

## 一、文件总览

| 路径 | 状态 | 说明 |
|---|---|---|
| `functions/load.mcfunction` | ✅ | 已含 gamerule / 计分项 / tag 清理 / storage 清空 |
| `functions/tick.mcfunction` | ✅ | 逻辑完整；注释块顺序可优化（见 P2-1） |
| `functions/util/clear_player.mcfunction` | 🔶 | 本轮已给重写版；**待落盘** |
| `functions/util/give_kit.mcfunction` | 🔶 | 与"只在大厅发装备"冲突，建议废弃或改为只被职业入口调用 |
| `functions/util/say.mcfunction` | ❌ | 仅注释 |
| `functions/util/title.mcfunction` | ❌ | 仅注释 |
| `functions/kit/warrior.mcfunction` | 🔶 | 旧版；需按新流程改为"先 clear_player 再写 kit" |
| `functions/kit/select.mcfunction` | ❌ | 空；建议改成调试用分发器（见 P2-3） |
| `functions/kit/<其他 78 职业>` | ❌ | 未建 |
| `functions/lobby/enter.mcfunction` | 🔶 | 只打 `in_lobby` tag；传送、清背包、切模式全部注释中 |
| `functions/lobby/exit.mcfunction` | ✅ | 只摘 tag，符合职责 |
| `functions/lobby/build.mcfunction` | ❌ | 空；`destroy` 有内容但 `build` 无，拆了造不回来 |
| `functions/lobby/destroy.mcfunction` | 🔶 | 只有注释头，无实际 fill 命令 |
| `functions/lobby/spawn.mcfunction` | ❌ | 空 |
| `functions/lobby/reset_self.mcfunction` | ❌ | 未建；`[初始化我]` 按钮需要它（本轮已给建议版） |
| `functions/lobby/menu.mcfunction` | ❌ | 未建；主大厅菜单入口 |
| `functions/map/distribute.mcfunction` | 🔶 | 仅 TODO 注释 |
| `functions/map/random.mcfunction` | 🔶 | 占位，固定写 0 |
| `functions/map/restore.mcfunction` | ❌ | 空；方案未定 |
| `functions/game/start.mcfunction` | 🔶 | 只有 2 行；不传送、不切模式、不设 spawnpoint、不启动倒计时 |
| `functions/game/end.mcfunction` | ❓ | 未读到；04-hazards 已提及其结构 |
| `functions/game/check_winner.mcfunction` | ❓ | 未读到；被 `eliminate` 与 `tick` 轮询调用 |
| `functions/game/reset.mcfunction` | 🔶 | 旧版全注释；本轮已给重写版，**待落盘** |
| `functions/player/join.mcfunction` | ✅ | 逐项写分数；可考虑改为直接调 `clear_player`（可选优化） |
| `functions/player/on_death.mcfunction` | ✅ | 与 keepInventory 路线一致 |
| `functions/player/after_death.mcfunction` | ✅ | 只给无敌 + 提示，不重发装备，与拍板一致 |
| `functions/player/death_dispatch.mcfunction` | ✅ | 死亡检测消费器 |
| `functions/player/eliminate.mcfunction` | ✅ | 逻辑完整；跨文件调 `game/check_winner`（见 ❓） |
| `functions/player/invincible.mcfunction` | ✅ | 给 5 秒抗性 V |
| `functions/player/end_invincible.mcfunction` | ✅ | 摘 tag、清 `inv`、清抗性 |
| `functions/player/on_kill.mcfunction` | ❌ | 未建；**导致 `kitpvp.kills` 永远是 0** |
| `functions/debug/death_check.mcfunction` | ❓ | 未读到；目录树里有，内容未知 |
| `functions/debug/test/on.mcfunction` | ❌ | 未建；04-hazards 反复引用，但文件不存在 |
| `functions/debug/test/off.mcfunction` | ❌ | 未建 |
| `functions/debug/test/status.mcfunction` | 🔶 | 04-hazards 提到内容；本次未读到源码 |
| `functions/debug/test/play.mcfunction` | 🔶 | 同上，未读到源码 |
| `functions/debug/test/solo_start.mcfunction` | 🔶 | 同上，未读到源码 |
| `functions/debug/test/force_end.mcfunction` | ❌ | 未建 |
| `functions/debug/test/force_reset.mcfunction` | ❌ | 未建 |
| `functions/skill/*` | ❌ | 目录不存在；技能机制无落点 |
| `tags/functions/load.json` | ❓ | 未读到源码；应指向 `kitpvp:load` |
| `tags/functions/tick.json` | ❓ | 未读到源码；应指向 `kitpvp:tick` |
| `pack.mcmeta` | ❓ | 未读到；pack_format 应为 15 |
| `predicates/*` | ❌ | 空目录 |
| `loot_tables/*` | ❌ | 空目录 |
| `item_modifiers/*` | ❌ | 空目录 |
| `advancements/player/*` | ❌ | 空目录；1.20.1 触发器需逐一实机确认 |

---

## 二、P0 阻塞（不解决跑不起来）

### P0-1. `game/start.mcfunction` 仅 2 行

急缺：传送、`spawnpoint`、切生存、开局无敌、倒计时启动。
按 2.6 补齐。若打包时坐标未定，可用 `<x> <y> <z>` 占位并加 `# TODO`。

### P0-2. `lobby/build` 空、`lobby/spawn` 空

`enter` 里"传送、清背包、切模式"三行也全被注释。
现状：**玩家进服后不会被传送、不会被初始化**。
`build` 与 `destroy` 必须成对落地，否则拆了造不回来。

### P0-3. `debug/test/on`、`off`、`force_end`、`force_reset` 缺失

04-hazards 文档让玩家执行 `/function kitpvp:debug/test/on` 之类的命令，但文件不存在，
文档里的操作步骤全部失效。要么补文件，要么从文档里删掉这些操作步骤。

### P0-4. `player/on_kill.mcfunction` 缺失

`kitpvp.kills` 建成后从未被 +1，永远为 0。
待决策：用 advancement 触发器（`minecraft:player_killed_entity`）还是放弃该计分项。
1.20.1 有 `player_killed_entity`，但需要 advancement 循环 revoke 才能反复触发，
**格式与判定条件必须先实机验证再写**。

### P0-5. `game/end` / `game/check_winner` 未读到

`eliminate` 与 `tick` 都调用 `check_winner`，若两者都不存在，命数归 0 时会报错。
需要确认这两个文件已经落盘。

---

## 三、P1 高优（影响完整流程）

### P1-1. `kit/warrior` 旧版仍会刷命数

旧版第一行是 `scoreboard players set @s kitpvp.alive 1` 之前先设 `lives 3`，
若被误用在重生流程中会刷回 3。需按新顺序重写：
先 `clear_player` → 再写 `kit`、`selected` → 最后 `lives` 和装备。

### P1-2. `select` 与 `give_kit` 的定位空悬

- 选职业现在直接点具体职业函数，`select` 主流程不再需要。
- `give_kit` 若继续存在，容易被错误接入死亡/重生。

建议：
- `select` 保留为**调试用分发器**（`execute if score @s kitpvp.kit matches 1 run ...`）。
- `give_kit` 直接**删除或清空加废弃注释**。

### P1-3. `lobby/menu` 未建

职业列表、随机、确认、返回等按钮入口无落点。
需要新建一份 `tellraw` 按钮清单。
注意 `clickEvent.run_command` 的 `value` 必须以 `/` 开头，
`hoverEvent` 用 `contents` 不是 `value`。

### P1-4. `kit/archer` 等其余 78 个职业未建

建议先固化"头三行 + 属性 + 装备 + 提示"模板，再批量复制。
每个职业函数开头的三行应完全一致，只改 `kit` 编号：

