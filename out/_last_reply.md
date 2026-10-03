大厅压力板职业介绍，需要新增 2 个函数 + 改 2 个已有文件。核心是「踩上打 tag、离开摘 tag」，靠 tag 的翻转让每个压力板在一轮站立中只弹一次。

## 1. 新增：src\data\kitpvp\functions\lobby\pad.mcfunction

```mcfunction
# ===== 主大厅：压力板职业介绍（每刻轮询） =====
# 由 tick.mcfunction 调用
#
# 行为：玩家踩上「轻质测重压力板」的瞬间，弹出对应职业的介绍卡片
#       （只会调 kitpvp:kit/info/* ，不会自动选职业；
#        玩家看完自己点卡片底部的 [确认选择] 才真正选职业）
#
# 防重复：靠 tag=kitpvp.on_pad 的翻转
#   踩上板 + 没有 tag  → 触发一次，并打上 tag
#   站在板上时        → 已有 tag，不会再触发（潜行、原地跳、转视角都不刷屏）
#   离开板            → 摘掉 tag，下次踩板重新触发
#
# ⚠ kitpvp.on_pad 是"位置状态"tag，与 kitpvp.in_lobby 同类：
#   刻意不在 util/clear_player 里清除。
#   否则玩家站在板上时被 clear_player → tag 被清 → 下一刻重新弹一次描述。

# 踩上板的瞬间：没有 on_pad → 触发
execute as @a[tag=kitpvp.in_lobby,tag=!kitpvp.spectator,tag=!kitpvp.on_pad] at @s if block ~ ~-1 ~ minecraft:light_weighted_pressure_plate run function kitpvp:lobby/pad_enter

# 离开板：摘 tag，允许下次踩板重新触发
execute as @a[tag=kitpvp.on_pad] at @s unless block ~ ~-1 ~ minecraft:light_weighted_pressure_plate run tag @s remove kitpvp.on_pad
```

## 2. 新增：src\data\kitpvp\functions\lobby\pad_enter.mcfunction

```mcfunction
# ===== 主大厅：压力板 → 职业介绍分流 =====
# 由 lobby/pad 调用，@s = 刚踩上板的玩家
#
# 新增一块职业压力板时：
#   1) 在大厅铺一块 minecraft:light_weighted_pressure_plate
#   2) 把该方块的 x/y/z 填进下面新增的选择器（dx/dy/dz 固定填 1）
#
# 选择器体积口径：
#   x/y/z 是压力板方块自身的坐标，dx=dy=dz=1 覆盖 1×1×1 的立方体。
#   玩家站在板上时脚部 Y = 方块 Y + 0.0625，落在 [y, y+1) 内，会被匹配。
#   若板下是方块、板上再叠高（多层板），需要相应加大 dy。
#
# ⚠ 下面的坐标全部是占位符，必须换成实际的大厅坐标；
#   若两块板填了相同坐标，会同时弹出多个职业描述。

tag @s add kitpvp.on_pad

# --- 战士 ---
execute if entity @s[x=100,y=64,z=100,dx=1,dy=1,dz=1] run function kitpvp:kit/info/warrior

# --- 弓箭手 ---
execute if entity @s[x=102,y=64,z=100,dx=1,dy=1,dz=1] run function kitpvp:kit/info/archer

# --- 坦克 ---
execute if entity @s[x=104,y=64,z=100,dx=1,dy=1,dz=1] run function kitpvp:kit/info/tank

# --- 刺客 ---
execute if entity @s[x=106,y=64,z=100,dx=1,dy=1,dz=1] run function kitpvp:kit/info/assassin

# …… 新增职业时按同格式追加
```

## 3. 修改：src\data\kitpvp\functions\tick.mcfunction

在「主大厅：准备 / 取消准备」那一段**之前**插入这一行（位置不敏感，只要在大厅那一段里）：

```mcfunction
# ===== 主大厅：踩压力板弹出职业介绍 =====
# 只动 tag=kitpvp.in_lobby 的玩家；防重复逻辑在 lobby/pad 内部
function kitpvp:lobby/pad
```

## 4. 修改：src\data\kitpvp\functions\load.mcfunction

在「四、标签清理」段落末尾追加一行（`tag @a remove kitpvp.soul_transit` 之后）：

```mcfunction
tag @a remove kitpvp.on_pad
```

---

### 同步提醒（未改动的文件，需你自己补）

- **`util/clear_player.mcfunction` 不要加 `kitpvp.on_pad`**。原因写在 `lobby/pad.mcfunction` 的注释里：玩家站在板上时被 `clear_player` 会清掉 tag，导致下一刻重新弹一次描述。这与 `kitpvp.in_lobby` 同理。
- **`03-project-spec.md` 第七节 tag 登记表**需要补一行：

  | tag | 用途 | add 于 | remove 于 | clear_player 清 |
  |---|---|---|---|---|
  | `kitpvp.on_pad` | 正站在职业压力板上 | lobby/pad_enter | lobby/pad（离开板时） | ❌ 刻意不清 |

- **`01-file-structure.md`** 需要补上 `lobby/pad.mcfunction` 与 `lobby/pad_enter.mcfunction` 两个新文件。

### 一个已有的不一致（顺带提一下，不在本次范围内）

`kit/info/archer`、`kit/info/tank` 的 [返回] 指向 `kitpvp:lobby/menu`，而 `kit/info/warrior`、`kit/info/assassin` 的 [返回] 指向 `kitpvp:kit/list/classic`。走压力板进入描述后再点 [返回]，会分叉到两个不同界面。要不要统一，取决于你想让压力板路径回到哪个层级。