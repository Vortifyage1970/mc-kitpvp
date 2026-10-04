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
| 主大厅 | 基本可用 |
| 游戏进行逻辑 | 基本可用 |
| 其余职业、地图复原 | 开发中 |

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

## 说明

本项目仅供朋友之间自娱自乐，不保证平衡性与兼容性。
