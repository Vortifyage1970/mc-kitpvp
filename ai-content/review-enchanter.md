# 附魔师（kit 98）代码评审意见

> 评审对象：`测试` 分支上的 `kit/enchanter` + `skill/enchanter/`（122 个文件）
> 评审日期：2026-11-26
> 结论：**设计值得要，实现需要重做一版再合**。下面按"必须改 / 建议改 / 一致性"三档列，每条都给了具体位置和改法。

---

## 一、先说好的部分

| 点 | 说明 |
|---|---|
| 定位清晰 | 纯被动成长、没有主动技能，正好补「经典（表）」里缺的"越打越强"位置 |
| 节奏可预期 | 15 秒起手，之后每 46.5 秒一发，最后一发在 8:00；卡片把 11 个时刻全列出来，玩家能算 |
| 有保底 | 连续 3 发没出锋利就强制出一次（`ench_pity`），避免脸黑玩家永远吃不到伤害成长 |
| 护甲节奏讲究 | 前 7 发四件全升，后 4 发两两轮转（头胸 / 腿靴 / 头腿 / 胸靴），不会出现"只堆一件" |
| HUD 到位 | 借用 `汉堡小子` 的逐玩家 bossbar 方案，8 条槽 + 进度条 + 满级变黄，信息量比多数职业都足 |
| 工程习惯对 | 用了本项目的 `clear_player` / `kitpvp.selected` / 蛋带 tag / `unbreakable` 金套，和现有职业风格一致 |

---

## 二、必须改（会丢东西 / 会残留 / 会抢 HUD）

### 1. 不要为了"剑不在手上"去搬玩家的物品

`sw_in_1..37` + `sw_out_1..37`（74 个文件）做的事是：把玩家主手的东西寄存到盔甲架 → 把背包第 N 格的金剑换进主手 → 附魔 → 再换回去。

问题：

- **每 46.5 秒动一次玩家的手**。玩家正在吃东西、拉弓、举盾时被换掉，动作直接被打断。
- 中途死亡 / 掉线 / `/reload`，东西就留在 `kitpvp.sw_bench` 那个盔甲架上——而这个 tag **没有进 `reset_entities`**（我查过生成文件，里面没有 `kitpvp.sw_bench`，也没有 `kitpvp.ench_bench`），于是盔甲架连同玩家的物品一起跨局残留。

**改法**：不搬。剑开局在 `hotbar.0`，直接对那个格子做 NBT 手术：

```mcfunction
# 附魔手术：直接改 hotbar.0，不碰主手
execute at @s run summon minecraft:armor_stand ~ ~ ~ {Tags:["kitpvp.ench_bench"],Invisible:1b,NoGravity:1b,Invulnerable:1b}
item replace entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] armor.head from entity @s hotbar.0
# ……改 ArmorItems[3].tag.Enchantments……
item replace entity @s hotbar.0 from entity @e[tag=kitpvp.ench_bench,distance=..2,limit=1,sort=nearest] armor.head
kill @e[tag=kitpvp.ench_bench]
```

代价只有"剑被挪到别处时这一发跳过"，比打断动作 / 丢东西划算得多。**74 个文件直接删掉，总文件数从 122 降到约 48。**

### 2. `reset_entities` 漏了两个台子 tag

`kitpvp.ench_bench`（附魔手术台）和 `kitpvp.sw_bench`（搬剑台）都没有兜底清理。

本项目有生成器，跑一次就行：

```
python tools/gen_cleanup.py
```

它会把所有 `summon` 里的 `Tags`、刷怪蛋的 `EntityTag`、运行期 `tag @e add` 全部反推成清场白名单。**以后新增任何召唤物/台子，记得跑这一步**，否则就是"平时没事、崩一次就留一地隐形盔甲架"。

### 3. HUD 每刻无条件跑 40 条命令

```mcfunction
# tick/earth.mcfunction:231
function kitpvp:skill/enchanter/hud
```

`hud` 里有 8 条 `bossbar set ... players`（清空绑定）+ 8 条绑定 + 8 条写进度 + 16 条改颜色 ≈ **40 条命令，每刻都跑，跟场上有没有附魔师无关**。

本项目对每刻车道（`tick/kits_*`）很敏感，2 核服务器上这 40 条 = 800 条/秒纯浪费。

**改法**：加闸门，或者整体降到 `tick/slow2`（每 2 刻）——进度条不需要 20Hz 刷新。

```mcfunction
execute if entity @a[scores={kitpvp.kit=98}] run function kitpvp:skill/enchanter/hud
```

### 4. bossbar 槽位会撞

```mcfunction
# skill/enchanter/assign_slot.mcfunction
scoreboard players operation @s kitpvp.ench_slot = @s kitpvp.etid
scoreboard players operation @s kitpvp.ench_slot %= #ench_eight kitpvp.game
```

注释写"etid 每人唯一，所以两名附魔师不会抢同一条"——**取模 8 之后就不唯一了**：etid 5 和 etid 13 都会落到槽 5。一局两名附魔师就会互相把对方从 bossbar 里踢掉。

**改法**：照抄本项目其它职业的"占用判定 + 找空槽"（`skill/zhanshiishi/assign_slot` 就是现成模板），或者干脆给每名玩家一个 `etid` 内的独立 bossbar 命名空间（做不到），所以还是找空槽最稳。

---

## 三、建议改（不影响正确性，但能省一半代码）

### 5. `name_refresh` 96 行 → 8 行

现在是 8 槽 × 12 级的全组合铺开。bossbar 名字支持分数组件，直接显示分数即可：

```mcfunction
execute if score @s kitpvp.ench_slot matches 1 run bossbar set kitpvp:ench_hud_1 name {"text":"附魔等级：","extra":[{"score":{"name":"@s","objective":"kitpvp.ench_roll"}}]}
```

8 行替代 96 行；以后改上限（比如 11 → 15 级）也不用再全表重铺。

### 6. 死代码

| 项 | 情况 |
|---|---|
| `kitpvp.ench_fill` | `kit/enchanter` 里写了，之后**没有任何地方读它** |
| `#ench_twenty` | `load` 里赋值，**从未使用** |

### 7. 锋利等级用 `matches 1..12` 逐条 `set value Ns` 是必要的（1.20.1 不能在 `data modify` 里做算术），但可以少写两条：

```mcfunction
execute if score #ench_lv kitpvp.game matches 12 run data modify ... set value 12s
execute if score #ench_lv kitpvp.game matches 12.. run data modify ... set value 12s   # 这两条重复了
```

留 `12..` 那条就够（它同时兜住 12 和更高）。

---

## 四、一致性（合进主分支前必须处理）

| 项 | 现状 | 建议 |
|---|---|---|
| 职业 id | `kitpvp.kit 98`，但卡片写「经典（表）」 | 98–99 在本仓库的编号表里是**历史**段；表段还空着 15/16/17/20/21/22，挪过去 |
| 随机池 | `kit/random` 仍是 `#pool_size 41`，没有 98 | 要么加进池子（记得 `pool_size` +1 并在末尾追加映射），要么明确写"仅手动选择" |
| 文档 | 分支里 `ai-content/` 完全没有"附魔师" | 至少在 `06-kit-registry.md` 登记一行 + 一节数值说明；`07-objective-tags.md` 补 `ench_*` 那 6 个 objective |
| 升级发光 | 每次强化给自己 5 秒 `glowing` | 纯被动 + 每 46.5 秒暴露一次位置，早期等于白送对手情报；建议改成只对自己可见的粒子，或干脆去掉 |

---

## 五、平衡方向（供参考，需实测）

- 现在 11 发、46.5 秒、8:00 封顶。我们这边多数局 **4~5 分钟**就结束了，等于**永远吃不到后期**——前期金剑 4 伤、无技能，大概率打不过战士。
- 建议**前重后轻**：0:15 / 0:45 / 1:15 / 1:50 / 2:30 / 3:10 / 3:50 / 4:30 / 5:10 / 5:50 / 6:30，共 11 发、6:30 封顶；或者压成 8 发、每发间隔 40 秒。
- 护甲成长是随机的（保护 / 弹射保护 / 荆棘 / 火焰保护 / 爆炸保护），方差很大；如果想让强度稳定，可以考虑"保护固定、其余随机"。

---

## 六、合并建议

**不要整分支 merge**：那个分支有 628 个提交，混着 `debug/ench_*` 一堆调试函数和 `skill/earth/` 的大改，直接合会把主线刚修好的东西（海洋图、载体 tag、溺尸按类型清理、11-26 平衡批次）搅在一起。

建议流程：

1. 在分支上按上面 1~4 改完（主要是删 74 个文件 + 加闸门 + 补 `gen_cleanup`）；
2. 把 `kit/enchanter`、`kit/info/enchanter`、`skill/enchanter/*` 单独摘出来，作为**一个独立 PR**；
3. 主线这边我先接：id 挪到表段、登记 06/07、加进随机池；
4. 平衡数值等你们定完节奏再调。

---

## 附：本项目可复用的自检

改完（不管在哪个分支）都跑一遍：

```
python tools/check.py        # 断链 / JSON / 模板 / 选择器 / objective criteria / 清场覆盖
python tools/gen_cleanup.py  # 动过 summon 或刷怪蛋时必跑
python tools/gen_structure.py
python tools/smoke.py        # 需要一台本地 1.20.1 测试服，见 tools/README.md
```