下面按文件逐个给出。**修改**的文件直接整份替换；**新建**的文件放到对应目录。

---

## 1. `src/data/kitpvp/functions/tick.mcfunction`（修改）

新增一段"清除落地箭"。其余内容保持原样。

```mcfunction
# 每游戏刻执行
# 玩家接入检测：未登记的玩家 → 走 join 流程
execute as @a[tag=!kitpvp.joined] run function kitpvp:player/join

# 冷却递减
execute as @a[scores={kitpvp.cd=1..}] run scoreboard players remove @s kitpvp.cd 1
execute as @a[scores={kitpvp.cd2=1..}] run scoreboard players remove @s kitpvp.cd2 1

# ===== 战士金苹果消耗检测 =====
# 统计 objective：吃掉金苹果的瞬间 used 自动 +1
# 本刻 used 比 last 大 → 刚吃掉，转交 warrior_consume
# 必须在"冷却递减"之后再跑，避免 cd 被本 tick 的递减覆盖
execute as @a[scores={kitpvp.kit=1,kitpvp.alive=1}] if score @s kitpvp.gapple_used > @s kitpvp.gapple_last run function kitpvp:skill/warrior_consume

# ===== 职业技能结算（统一入口）=====
# 只筛"有职业、活着、主技能冷却归零"的玩家，转交 dispatch；
# 具体哪个职业发什么，由 skill/dispatch 按 kitpvp.kit 分派。
# 新增职业请改 skill/dispatch，不要在这里加行。
execute as @a[scores={kitpvp.kit=1..,kitpvp.alive=1}] if score @s kitpvp.cd matches ..0 run function kitpvp:skill/dispatch

# ===== 弓箭手：清除落地的箭 =====
# 弓箭手射出的箭一落地（inGround:1b）就清除，
# 防止"射出去 → 换弹 → 再捡回来"把箭数刷过 12 支上限。
# 副作用：会一并清掉其它来源（如骷髅）落地的箭。
kill @e[type=minecraft:arrow,nbt={inGround:1b}]

# 兼容中途加入的玩家：没有 inv 分数就补 0
scoreboard players add @a kitpvp.inv 0

# 无敌倒计时（每刻 -1）
execute as @a[scores={kitpvp.inv=1..}] run scoreboard players remove @s kitpvp.inv 1

# 无敌结束
execute as @a[tag=kitpvp.invincible,scores={kitpvp.inv=0}] run function kitpvp:player/end_invincible

# 虚空兜底：Y < -74 直接判死（阈值可调）
# y=-1024 配合 dy=950 覆盖 y ∈ [-1024, -74]
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator,gamemode=!spectator] if entity @s[y=-1024,dy=950] run damage @s 1000 minecraft:generic

# 死亡检测
execute as @a[tag=!kitpvp.spectator] if score @s kitpvp.death_detect > @s kitpvp.death_seen run function kitpvp:player/death_dispatch

# 重生后处理（由 on_death 打 tag，本 tick 消费）
execute as @a[tag=kitpvp.respawn_pending,tag=!kitpvp.spectator] run function kitpvp:player/after_death

# ===== 胜负兜底轮询（每 20 刻一次）=====
# 覆盖"玩家中途退出服务器导致幸存者减少，但没人触发 eliminate"的情况
scoreboard players add #tick kitpvp.game 1
execute if score #tick kitpvp.game matches 20.. run scoreboard players set #tick kitpvp.game 0
execute if score #tick kitpvp.game matches 0 if score #state kitpvp.game matches 1 run function kitpvp:game/check_winner
```

---

## 2. `src/data/kitpvp/functions/skill/archer_pickup.mcfunction`（修改）

```mcfunction
# ===== 弓箭手：拾弓触发入口 =====
# 触发器：minecraft:thrown_item_picked_up_by_player
#   条件：被捡起的物品是带 KitBow:1b 标记的 minecraft:bow
# @s = 捡起弓的玩家
#
# 分流：
#   本人是弓箭手（kit=2）→ 换弹
#   其他职业             → 弓被没收，30 秒后归还

# 弓箭手本人 → 换弹
execute if score @s kitpvp.kit matches 2 run function kitpvp:skill/archer_refill

# 非弓箭手 → 没收弓 + 启动 30 秒归还计时
execute unless score @s kitpvp.kit matches 2 run function kitpvp:skill/archer_steal

# 一次性触发器：必须 revoke，否则下一次捡弓不会再触发
advancement revoke @s only kitpvp:player/archer_pickup
```

---

## 3. `src/data/kitpvp/functions/skill/archer_steal.mcfunction`（新建）

```mcfunction
# ===== 非弓箭手捡到弓箭手之弓：没收 + 30 秒后归还 =====
# @s = 捡起弓的非弓箭手
# 调用方：skill/archer_pickup

# 1. 直接从背包里清除这把弓
clear @s minecraft:bow{KitBow:1b}

# 2. 本机提示
title @s actionbar {"text":"这把弓不属于你，已没收","color":"red"}
playsound minecraft:entity.item.break master @s ~ ~ ~ 0.8 1.0

# 3. 全服公告
tellraw @a [{"text":"[!] ","color":"red","bold":true},{"selector":"@s","color":"white"},{"text":" 捡走了弓箭手的弓，30 秒后归还","color":"gray"}]

# 4. 30 秒（600 刻）后归还
#    replace 模式：多次被捡只保留最后一次计时，不会叠出多把弓
schedule function kitpvp:skill/archer_return 600t replace
```

---

## 4. `src/data/kitpvp/functions/skill/archer_return.mcfunction`（新建）

```mcfunction
# ===== 30 秒到：把弓归还给弓箭手 =====
# 触发：schedule function kitpvp:skill/archer_return 600t replace
# 说明：本函数会顺手把"已经拿着弓"的弓箭手也刷新一遍
#       （同类弓全局只有一种，刷新无副作用；代价是该玩家若正在拉弓会被打断）

# 1. 清掉所有弓箭手手上的 KitBow 弓，防止归还后叠加成多把
execute as @a[scores={kitpvp.kit=2}] run clear @s minecraft:bow{KitBow:1b}

# 2. 每个仍在局内的弓箭手重新发一把
execute as @a[scores={kitpvp.kit=2,kitpvp.alive=1},tag=!kitpvp.spectator] run function kitpvp:skill/archer_give_bow

# 3. 公告
tellraw @a [{"text":"[!] ","color":"green","bold":true},{"text":"弓箭手的弓已归还","color":"gray"}]
```

---

## 5. `src/data/kitpvp/functions/skill/archer_give_bow.mcfunction`（新建）

```mcfunction
# ===== 发放一把"弓箭手之弓" =====
# 调用方：
#   kit/archer.mcfunction      （选职业时）
#   skill/archer_return        （30 秒归还）
#
# ⚠ 这里的弓 NBT 必须与 kit/archer.mcfunction 里那一串完全一致，
#   否则归还回来的弓可能被 archer_pickup.json 的触发器条件认不出来。
#   如果 kit/archer 里只写了 {KitBow:1b}，就把下面 Unbreakable 去掉。

give @s minecraft:bow{KitBow:1b,Unbreakable:1b} 1
```

---

## 6. `src/data/kitpvp/functions/skill/archer_refill.mcfunction`（修改）

```mcfunction
# ===== 弓箭手：换弹 =====
# 设计文档：丢出自己的弓并捡起，箭数重置为 12
# @s = 弓箭手本人

# 1. 清空背包里所有箭（包括地图上捡的、别人给的）
clear @s minecraft:arrow

# 2. 清掉地上散落的箭物品
#    防止"丢出一支箭 → 换弹 → 再捡回来"把箭数刷过 12
#    注意：会一并清掉地图上其它来源的箭物品
kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:arrow"}}]

# 3. 补满 12 支
give @s minecraft:arrow 12

title @s actionbar {"text":"换弹完成：12 支箭","color":"gold"}
playsound minecraft:item.crossbow.loading_end master @s ~ ~ ~ 0.8 1.3
```

---

## 改动说明与注意事项

**归还链路**

1. 非弓箭手捡到弓 → `archer_steal` 立刻 `clear` 掉背包里的弓。
2. 同时 `schedule ... 600t replace` 排一次 30 秒后的归还。
3. `archer_return` 清掉所有弓箭手手上的同类弓再重发，保证"弓箭手手上恰好 1 把"。

**为什么用"清光重发"而不是"只补缺的玩家"**

1.20.1 没有 `execute if items`（那是 1.20.5+），也没有办法在执行期把"弓的拥有者名字"动态塞进选择器。要精确判定"哪个弓箭手丢了弓"只能靠 `clear <target> <item> <maxCount>` 的返回值思路，而 `<maxCount>` 是否接受 `0`（表示"只计数不清除"）我不确定——**请用 `/help clear` 或实测验证**。稳妥起见这里改用"清光重发"，语义等价，无语法风险。

**尚未覆盖的边界**

- 玩家把箭存进箱子/末影箱，换弹后再取回来，仍会超过 12 支。要堵这个口子只能走"物品带标记 NBT + 定期扫描背包槽位"的 predicate 方案，成本高，暂不做。
- 落地箭的清除是**全局**的，会连带清掉骷髅等其它来源落地的箭。地图上如果以后有"需要保留落地箭"的设计，需改为按 `Owner` UUID 匹配（1.20.1 做不到动态匹配玩家 UUID，得换思路）。
- `game/reset.mcfunction` 里建议补一行 `schedule clear kitpvp:skill/archer_return`，避免结算期间还留着一个归还定时器。该文件正文我没有，未改动。

**需要你核对的地方**

`kit/archer.mcfunction` 里弓的 NBT 我没有拿到正文，`archer_give_bow` 里写的是 `{KitBow:1b,Unbreakable:1b}`。请打开 `kit/archer.mcfunction` 对比，把这一行改成与它完全一致（`archer_pickup.json` 的 `nbt` 条件也要能匹配上归还的这把弓）。