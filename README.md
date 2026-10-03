# MC 职业战争

和几个同学一起做、一起玩的 Minecraft 职业战争数据包。

## 这是什么

纯数据包实现的职业 PVP。玩家在大厅选职业、选地图，进入地图后各自为战，
每人若干条命，打到只剩一人。

- 版本：Minecraft Java Edition **1.20.1**（pack_format 15）
- 形式：纯数据包，无模组、无插件
- 人数：3～6 人小规模联机
- 目标职业数：100+，目前持续开发中

## 已完成

| 内容 | 状态 |
|---|---|
| 主大厅（选职业 / 选地图 / 准备 / 开始） | 基本可用 |
| 结算与重置链路 | 基本可用 |
| 死亡、命数、重生、无敌 | 基本可用 |
| 突然死亡（8 分钟后发魂石） | 已实现四种魂石 |
| 职业：战士 / 弓箭手 / 坦克 / 刺客 | 完成 |
| 其余职业、混沌版本、地图复原 | 开发中 |

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
   │  ├─ advancements/   触发式技能（如弓箭手拾取）
   │  ├─ functions/      所有逻辑
   │  │  ├─ load / tick  加载与每刻钩子
   │  │  ├─ lobby/       主大厅
   │  │  ├─ kit/         职业定义
   │  │  ├─ skill/       职业技能
   │  │  ├─ game/        开局 / 结算 / 重置
   │  │  ├─ player/      接入 / 死亡 / 重生
   │  │  ├─ map/         地图与出生点
   │  │  ├─ util/        通用工具
   │  │  └─ debug/       调试命令
   │  ├─ predicates/     随机判定
   │  └─ tags/
   └─ minecraft/tags/functions/   load.json / tick.json
```

## 给队友的说明

- 命名空间固定为 `kitpvp`，只允许小写字母、数字、下划线
- 物品 NBT 用 1.20.1 的旧版格式（`display.Name`、`Enchantments:[{id,lvl}]`、`Unbreakable:1b`）
- 不要使用 1.20.2+ 的语法（`return`、宏、函数参数、`execute if items` 等）
- 加了新函数记得同步更新 `game/start`、`game/reset`、`util/clear_player` 等牵连处

## 说明

本项目仅供朋友之间自娱自乐，不保证平衡性与兼容性。
