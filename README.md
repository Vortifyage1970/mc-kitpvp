# MC 职业战争

和几个同学一起做、一起玩的 Minecraft 职业战争数据包。

## 这是什么

纯数据包实现的职业 PVP。玩家在大厅选职业、选地图，进入地图后各自为战，
每人若干条命，打到只剩一人。

- 版本：Minecraft Java Edition **1.20.1**（pack_format 15）
- 形式：纯数据包，无模组、无插件
- 人数：3～6 人小规模联机
- 目标职业数：**79**（不含混沌）+ 混沌若干，当前 **13 个**（战士 / 弓箭手 / 坦克 / 刺客 / 纵火狂 / 幽灵 / 渔夫 / 末影人 / 海盗 / 史莱姆 / 里·战士 / 里·弓箭手 / 里·坦克）

## 玩法

1. 进大厅 → 选职业（也可随机）、选地图（沙漠 / 竞技场 / 地球 / 西安）
2. 右键钓竿准备，全员就绪后开局
3. 每人 3 条命（个别职业特殊），传送到地图出生点各自为战
4. 开局 8 分钟后进入**突然死亡**：每 30 秒给存活玩家发一颗一次性"魂石"
5. 只剩 1 人获胜；幸存者归零且场上还有旁观者时判平局（最后两人同刻互杀就是这种情况），全员掉线不结算

## 已完成

| 内容 | 状态 |
|---|---|
| 主大厅（选职业 / 选地图 / 准备 / 讲台传送） | 可用 |
| 开局 / 结算 / 重置 | 可用 |
| 突然死亡 + 魂石（6 种：战士 / 弓箭手 / 坦克 / 刺客 / 幽灵 / 海盗） | 可用 |
| 职业技能：主动 / 自动 / 触发器 / 投掷类 | 可用 |
| 职业 13 / 地图 4 | 开发中 |
| 地图复原 | 可用（4 张地图各用 `place template` 回滚） |

## 安装

1. 打开数据包所对应的地图
2. 把本仓库 `src/` 下的 `data/` 文件夹和 `pack.mcmeta` 一起放进
   `saves/<你的世界>/datapacks/kitpvp/`
3. 目录长这样：

```
saves/<世界>/datapacks/kitpvp/
├─ pack.mcmeta
└─ data/
   ├─ kitpvp/
   └─ minecraft/
```

4. 进游戏执行 `/reload`

## 目录结构

```
src/
├─ pack.mcmeta
└─ data/
   ├─ kitpvp/
   │  ├─ advancements/   触发器（拾取 / 受击 / 讲台）
   │  ├─ functions/      所有逻辑
   │  │  ├─ load / tick  加载与每刻钩子
   │  │  ├─ lobby/       主大厅
   │  │  ├─ kit/         职业定义（info 卡片 / list 列表）
   │  │  ├─ skill/       职业技能（soul/ 魂石）
   │  │  ├─ game/        开局 / 结算 / 重置 / 倒计时 / 突然死亡
   │  │  ├─ player/      接入 / 死亡 / 重生 / 无敌
   │  │  ├─ map/         地图与出生点
   │  │  ├─ summon/      召唤物
   │  │  ├─ music/       音符盒演奏（yu_ai，手动触发）
   │  │  ├─ util/        通用工具
   │  │  └─ debug/       调试命令
   │  ├─ predicates/     随机判定
   │  └─ tags/
   └─ minecraft/tags/functions/   load.json / tick.json
```

## 开发

本项目自带一套给 AI 与开发者用的约束文档，放在 **`ai-content/`**（本地资产，已加入 `.gitignore`，不随仓库分发）：

| 文件 | 作用 |
|---|---|
| `00-version.md` | 1.20.1 版本红线、注释红线 |
| `01-file-structure.md` | 函数 / 文件清单（可自动生成） |
| `02-available-functions-1.20.1.md` | 命令手册与经验 |
| `03-project-spec.md` | 设计规则（唯一依据） |
| `04-hazards-reminder.md` | 已知坑位与约定 |
| `05-skill-patterns.md` | 技能实现模板 |
| `06-kit-registry.md` | 职业编号 / 分类 / 卡片 |
| `07-objective-tags.md` | objective / tag / 物品标记账本 |

维护契约见 `03-project-spec.md` §6：**规则在 03，实例在 06，账本在 07；代码是事实。**
"做到哪一步"看 `06-kit-registry.md` 总表的**状态**列，本 README 只给概览。

`tools/` 下的脚本（同样本地、不入库）：

| 脚本 | 作用 |
|---|---|
| `ai.py` | 读取 `ai-content/` 当上下文的 AI 助手 CLI |
| `check.py` | 体检：函数引用断链 + JSON 合法性 + 模板引用 + 单实体选择器 + 注释统计 |
| `gen_structure.py` | 重新扫描 `src/`，刷新 `01-file-structure.md` 的目录树 |
| `gen_cards.py` | 生成 `kit/info/*.mcfunction` 职业卡片（改数值改脚本再重跑，别手改） |
| `scan_logs.py` | 读世界日志，定位"function 静默不加载"的加载期报错 |
| `scaffold.py` | 生成新建数据包的标准骨架（已存在则不覆盖） |

改完代码建议跑一次：

```
python tools/check.py
python tools/gen_structure.py
```

改了职业数值 / 装备，卡片要重新生成：

```
python tools/gen_cards.py
```

## 说明

本项目仅供朋友之间自娱自乐，不保证平衡性与兼容性。
