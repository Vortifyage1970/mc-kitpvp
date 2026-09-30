我先说清楚前提：**`load.mcfunction` 没有贴出来**，所以下面关于 `kitpvp.death_detect` 的性质是**推断**（从 `on_death` 里只有 `add deaths`、没有 `add death_detect` 这一点倒推，它极可能是 `minecraft.custom:minecraft.deaths` 统计类 objective）。如果实际不是统计类，请看我在第 1 条里的标注。

下面按严重程度排序。

---

## 一、严重 bug

### Bug 1：`death_detect` 被当成普通分归零，会触发假死亡

**位置：** `util/clear_player.mcfunction` 与 `player/join.mcfunction`，都有这两行：

```
scoreboard players set @s kitpvp.death_detect 0
scoreboard players set @s kitpvp.death_seen 0
```

**为什么是 bug：**

`tick.mcfunction` 的死亡检测是 `if score @s kitpvp.death_detect > @s kitpvp.death_seen`。这套写法要求 `death_detect` 是**统计类 objective**（`minecraft.custom:minecraft.deaths`），因为 `on_death` 里并没有 `add death_detect`，全靠原版在玩家死时 +1。

统计类 objective 的分数**每刻会被原版刷回真实值**，`scoreboard players set` 是改不掉的。所以：

1. `clear_player` 把 `death_detect` 写 0，本刻看确实是 0；
2. 下一刻原版把它刷回玩家真实的死亡数（例如 2）；
3. 此时 `death_detect(2) > death_seen(0)` 成立 → 触发 `death_dispatch` → `on_death` → **扣 1 条命**。

**触发场景（都很常见）：**
- 玩家在大厅死过几次（自杀、掉虚空），再去选职业 → 每个职业函数第一行都会调 `clear_player` → 进局第一刻就被白扣一条命。
- 主大厅 `[初始化我]` → `lobby/reset_self` → `clear_player`，同样中招。
- 管理员重载数据包（`load` 会清 `kitpvp.joined`），`join` 重跑，同样中招。
- 一局结束后 `game/reset` 里对所有玩家跑 `clear_player`，下一局开局时集中爆假死亡。

**对照参考：** `gapple_last` 在 `join` 和 `clear_player` 里用的是 `scoreboard players operation @s kitpvp.gapple_last = @s kitpvp.gapple_used`，而不是 `set 0`。`death_seen` 应该照抄这套写法。

**修复：** 把两处的那两行删掉，换成下面一行：

```mcfunction
scoreboard players operation @s kitpvp.death_seen = @s kitpvp.death_detect
```

> 如果 `death_detect` 其实是 dummy 而不是统计 objective（那就是另一套 bug，见第五节），这一行的写法也依然正确，可以放心替换。

---

### Bug 2：无敌状态下的玩家掉虚空杀不死

**位置：** `tick.mcfunction`

```
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator] if entity @s[y=-1024,dy=950] run damage @s 1000 minecraft:generic
```

**为什么是 bug：**

`player/invincible.mcfunction` 给的是 `resistance 5 4 true`，即抗性提升 V = **100% 减伤**。`minecraft:generic` 不带 `bypasses_resistance`，伤害会被算成 `1000 × 0 = 0`，玩家**在虚空里站着不掉血**。

也就是说：复活无敌 5 秒内的玩家如果直接跳进虚空，这 5 秒里兜底机制是失效的，玩家会悬浮在 y<-74 的位置。等 5 秒后无敌结束才会死。虽然只有 5 秒，但如果有人能在这 5 秒里反复利用（例如配合位移技能反复进出），会变成"卡虚空"。

**修复（二选一）：**

方案 A（最稳，推荐）：

```mcfunction
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator] if entity @s[y=-1024,dy=950] run kill @s
```

`kill` 无视抗性、无视护甲，直达死亡链路，`death_detect` 照样 +1，下游完全不用改。

方案 B（保留"掉出世界"这个死因）：

```mcfunction
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator] if entity @s[y=-1024,dy=950] run damage @s 1000 minecraft:out_of_world
```

**⚠ 我不确定 `minecraft:out_of_world` 在 1.20.1 里是否带 `bypasses_resistance`**，这条请在游戏里实测（给玩家 `effect give @s minecraft:resistance 100 4 true` 后手动跑一次）确认能掉血再上线。无法确认就退回方案 A。

---

### Bug 3：`after_death` 设置了 title times，但没有任何 title 文本

**位置：** `player/after_death.mcfunction`

```
title @s times 5 30 10
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.2
```

`/title times` 只是设置淡入/停留/淡出的时长，**不显示任何东西**。单独用等于什么都没发生。设计文档 2.7 要求"重生提示"，这里显然漏了 `title` / `subtitle` / `actionbar` 的实际文本。

**修复：** `title @s times ...` 之后、`playsound` 之前补上：

```mcfunction
title @s subtitle {"text":"准备战斗","color":"yellow"}
title @s title {"text":"重生","color":"red","bold":true}
```

（文本内容按你自己的口味改。）

---

## 二、中等 bug

### Bug 4：`kill @e[type=minecraft:arrow,nbt={inGround:1b}]` 每刻都在跑

**位置：** `tick.mcfunction`

每 tick 全服扫一遍所有箭实体，代价高、且会误清**所有来源**的落地的箭（骷髅射的、地图上本来就有的）。两边都被你写在注释里承认了，但作为正式版本每刻跑一次代价太大。

**建议：**
- 挪到一个 `schedule function ... 5t replace` 的循环里，改成每 5 刻一次；
- 或者写 predicate 精确匹配（`nbt` 匹配本身就慢，predicate 不一定更快，所以更推荐降频）。

这条不是功能错误，是性能与副作用问题。

---

### Bug 5：淘汰后 `kitpvp.selected` 没清

**位置：** `player/eliminate.mcfunction`

`eliminate` 会摘掉 `invincible`、`respawn_pending`，也会打上 `spectator`，但**没有摘掉 `kitpvp.selected`**。而 `map/distribute.mcfunction` 第一行就是：

```
tag @a[tag=kitpvp.selected] remove kitpvp.spawn_assigned
```

下一局 `game/start` → `map/distribute` 时，上一局被淘汰的旁观者如果还在服里、还带着 `kitpvp.selected`，就会被算进"参战玩家"里一起重置 `spawn_assigned`，然后被 `@a[tag=kitpvp.selected]` 之类的地方算存活/算参战。

**建议修复：** 在 `eliminate.mcfunction` 末尾补一行：

```mcfunction
tag @s remove kitpvp.selected
```

---

### Bug 6：大厅死亡后没有任何复位

**位置：** `player/on_death.mcfunction`

只有在 `tag=!kitpvp.in_lobby` 时才做死亡处理；大厅死亡时全部跳过，**也不打 `respawn_pending`、也不补无敌、也不重新传送回大厅**。

如果大厅是安全屋不会死人，这条无所谓。但只要大厅里出现过任何死因（其它玩家的攻击、管理员 `/kill`、地图设计里的陷阱、掉出大厅边缘），玩家就会原地重生（`spawnpoint` 未必落在安全位置），还可能被反复打死。

**建议：** `on_death` 里的 in_lobby 分支补一个兜底：

```mcfunction
execute if entity @s[tag=kitpvp.in_lobby] run function kitpvp:lobby/enter
```

（`lobby/enter` 会重新 add `kitpvp.in_lobby` 并做传送，具体看你 `lobby/enter.mcfunction` 的正文；思路是"大厅死 → 直接重进大厅"。）

---

## 三、需要你自己确认的点

### 3.1 `load.mcfunction` 没贴，以下无法验证

- `kitpvp.death_detect` 到底是不是 `minecraft.custom:minecraft.deaths`；
- 全部 objective 是否都建过（尤其 `kitpvp.item`）；
- `#global` / `#tick` / `#state` 的初始值；
- `doImmediateRespawn`、`keepInventory`、`sendCommandFeedback` 等 gamerule 有没有按设计文档 2.1 设好。

Bug 1 的修复建议是按"它是统计类"给的，请对照 `load.mcfunction` 里 `scoreboard objectives add kitpvp.death_detect ...` 的 criterion 确认一次。

### 3.2 弓的 NBT 必须两处一致

`skill/archer_give_bow.mcfunction` 用的是：

```
give @s minecraft:bow{KitBow:1b,Unbreakable:1b} 1
```

而 `skill/dispatch.mcfunction` 的注释里写着"如果 `kit/archer` 里只写了 `{KitBow:1b}`"。请把 `kit/archer.mcfunction` 里那把弓的 NBT **逐字对齐**（要么两边都带 `Unbreakable:1b`，要么都不带），否则 `advancement` 的 `thrown_item_picked_up_by_player` 条件可能匹配不到，弓箭手的换弹就永远不触发。

同理，`archer_steal.mcfunction` 里的 `clear @s minecraft:bow{KitBow:1b}`、`archer_return.mcfunction` 里的 `clear @s minecraft:bow{KitBow:1b}`，都要和发弓时的 NBT **完全一致**。

### 3.3 `git / 格式`（无关功能，但会干扰 review）

- `map/random.mcfunction` 最后一行 `scoreboard players set #global kitpvp.map 1  ` 后面有两个尾随空格。
- 多个文件（`player/join`、`skill/dispatch`、`skill/warrior*`、`tick` 等）每行前面有一堆 `#` 前的缩进空格，写 `.mcfunction` 时没影响，但如果以后要 grep 或者 diff 会很难看。

---

## 四、顺带肯定一下的几处

既然你要挑 bug，我把已经做对的也点一下，免得你误改成错的方向：

- `warrior_consume` 第一行 `operation @s kitpvp.gapple_last = @s kitpvp.gapple_used` —— 正确，不要动。
- `tick.mcfunction` 里"先 `cd--`、再判 `used > last`"的顺序 —— 正确，不要改。
- `gapple_last` 在 `join` 与 `clear_player` 两处都做了 `operation =` 快照 —— 正确，`death_seen` 应按这个模板一起修。
- `archer_steal` 里 `schedule function kitpvp:skill/archer_return 600t replace` 用 `replace` —— 正确，防叠加弓。

---

## 五、`death_detect` 的另一种可能（如果你看完 load 发现它不是 statistical）

如果 `death_detect` 其实是 dummy，那问题就反过来了：**没有任何地方 `add death_detect 1`**（`on_death` 里只 add `deaths`），`tick.mcfunction` 的死亡检测永远不会触发，整套死亡链路走不通。所以要做的不是改两行 set，而是在 `on_death.mcfunction` 里补一行：

```mcfunction
scoreboard players add @s kitpvp.death_detect 1
```

请先确认 criterion，再决定走哪条修法。