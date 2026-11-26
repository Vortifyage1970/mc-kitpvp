# 代码审查总纲（REVIEW）

> 本文回答一个问题：**1010 个文件、9000 多行的数据包，一个人怎么审得完？**
> 答案不是"读完所有行"，而是：**审"不变量"，不审"行"**。把"必须永远成立的事"写成清单 + 自动检查，代码对不对就变成机器的事，你只需要读"高危文件"和"每个子系统挑一个代表"。

---

## 0. 先跑一次体检

```powershell
.\.venv\Scripts\python.exe tools\check.py       # 全部：断链 + JSON + 不变量 lint
.\.venv\Scripts\python.exe tools\invariants.py  # 只跑不变量 lint（8 类）
```
退出码非 0 = 有硬伤。**每次改完、每次 commit 前必须跑。**

本地验证环境：测试服 `D:\mc-test-server`（vanilla 1.20.1，RCON `25578` / `testpw`），`out\rcon.py` 可脚本化发命令；数据包目录 `world\datapacks\kitpvp` 是 `src` 的拷贝，改完同步 + `reload`。

---

## 1. 架构地图

`src/data/kitpvp/functions/`（1010 个 `.mcfunction`，约 9100 行）：

| 目录 | 文件 | 行数 | 作用 |
|---|---:|---:|---|
| `kit/` | 128 | 1825 | 职业定义 + `info/` 卡片 + `list/` 菜单 + `random*` 随机池 |
| `skill/` | 512 | 3312 | 各职业技能；`soul/` 是魂石（35 个子系统） |
| `map/` | 126 | 1030 | 9 张地图的复原 / 出生点 / 装饰 |
| `music/` | 116 | 475 | 雨爱 / 音乐引擎（rumbling 歌包在存档里，不在 src） |
| `summon/` | 64 | 283 | 召唤实体 NBT |
| `tick/` | 13 | 438 | 每刻入口 + 车道（`slow2` 每 2 刻 / `slow4` 每 4 刻） |
| `game/` | 13 | 443 | 开局 / 结算 / `reset` / `reset_entities` |
| `player/` | 8 | 185 | join / death / respawn |
| `lobby/` | 22 | 232 | 大厅 |
| `util/` | 5 | 307 | `clear_player` / `give_kit` / `team_index` / `team_join` |
| `debug/` | 14 | 128 | 调试入口 |
| 顶层 | 2 | — | `load.mcfunction`（509 行，初值/objective/bossbar/team）+ `tick.mcfunction`（入口） |

**数据流**：`load`（建 objective / team / bossbar 初值）→ 大厅选职业 `kit/*` → `game/start_impl` → 每刻 `tick` → 各技能 → `game/reset`（清场复原）。

---

## 2. 不变量清单

### 2.1 已自动化（`tools/invariants.py`，共 8 类，`check.py` 会一起跑）

| # | 不变量 | 历史事故 / 说明 |
|---|---|---|
| ① | **快照首行**：任何 `if score @s kitpvp.<X>_used > @s kitpvp.<X>_last run function F`，触发所在函数或 F（2 层内）必须出现 `kitpvp.<X>_last` 的推进 | 漏写 → 每刻连发 / 永不触发 |
| ② | **kit 闸门号一致**：`scores={kitpvp.kit=N}` 触发的函数，若内部有 `kitpvp.kit matches M`，则必须有 M==N | `tainted_archer` 闸门写 29（实为 24）→ 里·弓箭手炮台/熔火核心从不触发 |
| ③ | **慢拍车道只放幂等判定**：`tick/slow2|slow4` 不得含 `_prev`、`scoreboard players remove`、`_timer`、`item` 清理、投掷类 cast | 搬错 → 冷却翻倍 / 每刻逻辑失效 |
| ④ | **七处同步**：每个 kit 编号在 `kit/info/`、`kit/list/`、`util/give_kit`、`kit/random` 映射都对得上；`#pool_size` == 映射条数 | 新增职业漏接 |
| ⑤ | **team join 的队必须 load 里 `team add`** | `farmer_1..6` 从未创建 → 里农夫领袖敌对主人 |
| ⑥ | **按玩家显示的 bossbar 必须 reset/clear 清 `players`** | 跨局残留显示 |
| ⑦ | **引用的 objective 必须在 load 建过** | 拼错名 → 静默失效 |
| ⑧ | **`matches` 不写逗号列表** | 会让整份函数不加载 |

`invariants.py` 还会输出一组**非致命提示**：同一颗刷怪蛋被多个 objective 共用（当前 7 组）。它不判错，只提醒你"确认这组是走了 dispatch 分流的"。

### 2.2 人工判据（无法机检，记在心里）

- **共用刷怪蛋必须 dispatch 分流**：同一颗蛋被"职业令牌 + 魂石 + 别的技能"共用时，入口行**不能卡 kit**，要按载体 `tag`（首选）/名字分流，且 dispatch 首行无条件推快照。职业令牌只在 dispatch 内部用 `if score @s kitpvp.kit matches N` 分流。
- **魂石 / 道具召唤的友方绝不改主人自己的队**：先用 `util/team_index` 查主人当前队，有队就沿用，没队才开新槽。
- **清场**：任何新 `summon` 的 tag 要被 `gen_cleanup.py` 采集到（它从 `summon` 的 `Tags` / 蛋的 `EntityTag` / 运行期 `tag @e add` 反推），否则跨局残骸。改完跑一次 `tools/gen_cleanup.py`。
- **`load` 静默失败**：`load` 里任何一行加载期报错 → 整份 `load` 被丢弃 → 全包不初始化。排查第一步永远是读 `logs/latest.log` 的 `Failed to load function kitpvp:load` + `Whilst parsing command on line N`。
- **选择提示统一一行**：每个 `kit/<职业>` 末尾、音效之前，格式取自 `kit/info` 卡片。
- **1.20.1 红线**：无 `return` / `tick` / `random` 命令、无宏、无函数参数、旧式 NBT、`clickEvent.value` 带前导 `/`、`hoverEvent` 用 `contents`。

---

## 3. 审查工作流

### 3.1 按风险排序的必读文件（读这 ~20 个 ≈ 覆盖 80% 风险）

| 优先级 | 文件 | 为什么 |
|---|---|---|
| ★★★ | `util/team_index` / `util/team_join` | 所有召唤物的友好性都靠这里 |
| ★★★ | `util/clear_player` / `game/reset` / `game/reset_entities` | 跨局状态与残骸 |
| ★★★ | `load.mcfunction` | 一切初值 / objective / bossbar / team；静默失败源 |
| ★★★ | `tick.mcfunction` + `tick/slow2` + `tick/slow4` | 车道与顺序 |
| ★★☆ | `skill/soul/*`（`dispatch_*`、`use_*`） | 魂石，共用蛋重灾区 |
| ★★☆ | `kit/random*.mcfunction` | 池大小 / 映射错 → 随机到错职业 |
| ★★☆ | `skill/mars/*` | 地鸣 / 诅咒 / dispatch / 音乐，最杂 |
| ★★☆ | `skill/tainted_farmer/*` | 起义军 + 队槽 |
| ★★☆ | `util/give_kit` | 分派 |
| ★☆☆ | `summon/*` | 实体 NBT |
| ★☆☆ | 抽样 3 个职业：`kit/warrior`、`kit/tainted_archer`、`kit/burger` | 分别代表表 / 里 / 抽象三类写法 |

### 3.2 怎么审 274 个提交

- **永远 review `git diff`，不按目录顺序读全文。**
- 先看动了"高危区"的提交：
  `git log --oneline -- src/data/kitpvp/functions/util src/data/kitpvp/functions/game src/data/kitpvp/functions/tick src/data/kitpvp/functions/skill/soul`
- 职业新增类提交，用"七处同步 + 卡片口径"扫一眼即可（自动④已帮你查其中 4 处）。
- 默认"一个主题一个 commit"是好事：一次只看一个主题。

### 3.3 文档一致性清单（代码是真相，账本可以滞后但不能矛盾）

| 检查 | 自动? |
|---|---|
| README "职业 N" == 实际职业数（`kit/*.mcfunction` 去掉 `random*` 的数量） | 人工 |
| `06-kit-registry.md` 每个 kit 一行、编号 / 分类 / 状态对得上 | 人工 |
| `07-objective-tags.md` 每个 objective / tag 都登记、且 load 里真建了 | 自动⑦ + 人工 |
| `kit/random` `#pool_size` == 映射条数 | 自动④ |
| `kit/info` 文件数 == 职业数 | 自动④ |

---

## 4. 新增职业 / 魂石 / 技能的 checklist

**新增职业**（七处同步，自动④帮你查）：
`kit/<名>.mcfunction`、`kit/info/<名>`、`kit/list/<分类>`、`util/give_kit`、`kit/random`（`#pool_size` + 映射）、`load`（objective / team / bossbar）、`tick` 钩子；再补 `06` 行 + README 计数。

**新增魂石 / 共用蛋技能**：
1. `load` 加 objective（`minecraft.used:minecraft.<egg>_spawn_egg`，**单冒号**）。
2. `slow2` 加"不带 kit 闸门"的入口，调 `skill/.../dispatch`。
3. dispatch 首行无条件推快照，再按载体 **tag** 分流；职业令牌分支内 `if score @s kitpvp.kit matches N`。
4. 蛋的 `EntityTag` 里打好 tag；`reset` 兜底清。
5. 跑一次 `tools/gen_cleanup.py` 让它收录。
6. `06` 魂石表 + `07` objective/tag 登记。

**新增 bossbar（按玩家显示）**：`load` add + max + style；`tick` 每刻 `players @s` + `execute store result bossbar ... value`；`reset` / `clear_player` 清 players。

---

## 5. 一句话总结

> **不要试图读完全部代码。把"必须成立的事"写成不变量（第 2 节 + `tools/invariants.py`），让机器替你查；人只审"高危文件 + 每个子系统 1 个代表 + 文档一致性"。**
