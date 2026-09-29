下面是新增的 debug 功能集。全部放在 `src/data/kitpvp/functions/debug/` 下，命名空间沿用 `kitpvp`，全部使用 1.20.1 语法。

说明：
- 打开调试菜单：`/function kitpvp:debug/menu`
- 所有 `tellraw` 里的 `clickEvent` 都带前导 `/`，`hoverEvent` 用 `contents`
- 生成的怪物都会带 tag `kitpvp.debug_mob`，便于 `kill_mobs` 一键收拾
- 生成 NBT 使用 1.20.1 旧版字段名（`CustomName` / `HandItems` / `Count:1b` 等）

src/data/kitpvp/functions/debug/menu.mcfunction
```mcfunction
# ===== 调试主菜单 =====
# 调用：/function kitpvp:debug/menu

tellraw @s [{"text":"═══════ 调试控制台 ═══════","color":"dark_red","bold":true}]
tellraw @s [{"text":"[ 打开大厅菜单 ]","color":"green","clickEvent":{"action":"run_command","value":"/function kitpvp:lobby/menu"},"hoverEvent":{"action":"show_text","contents":[{"text":"打开主大厅菜单","color":"gray"}]}}]
tellraw @s [{"text":"[ 打开职业列表 ]","color":"green","clickEvent":{"action":"run_command","value":"/function kitpvp:kit/list"},"hoverEvent":{"action":"show_text","contents":[{"text":"打开职业分类列表","color":"gray"}]}}]
tellraw @s [{"text":"[ 查看我的状态 ]","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/status"},"hoverEvent":{"action":"show_text","contents":[{"text":"显示分数、标签、全局状态","color":"gray"}]}}]
tellraw @s [{"text":"───── 自身 ─────","color":"gray"}]
tellraw @s [{"text":"[ 回满血 ]","color":"light_purple","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/heal"},"hoverEvent":{"action":"show_text","contents":[{"text":"立即回满血量","color":"gray"}]}}]
tellraw @s [{"text":"[ 加 1 命 ]","color":"light_purple","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/add_lives"},"hoverEvent":{"action":"show_text","contents":[{"text":"命数 +1","color":"gray"}]}}]
tellraw @s [{"text":"[ 减 1 命 ]","color":"dark_purple","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/remove_lives"},"hoverEvent":{"action":"show_text","contents":[{"text":"命数 -1","color":"gray"}]}}]
tellraw @s [{"text":"[ 无敌 开/关 ]","color":"dark_purple","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/god_toggle"},"hoverEvent":{"action":"show_text","contents":[{"text":"切换抗性 V 调试无敌","color":"gray"}]}}]
tellraw @s [{"text":"[ 自杀（测死亡流程） ]","color":"dark_red","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/kill_self"},"hoverEvent":{"action":"show_text","contents":[{"text":"走正常死亡结算","color":"gray"}]}}]
tellraw @s [{"text":"[ 传送回大厅 ]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/tp_lobby"},"hoverEvent":{"action":"show_text","contents":[{"text":"走 lobby/enter 流程","color":"gray"}]}}]
tellraw @s [{"text":"───── 冷却 ─────","color":"gray"}]
tellraw @s [{"text":"[ 冷却清零（自己） ]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/reset_cd"},"hoverEvent":{"action":"show_text","contents":[{"text":"只清自己的 cd / cd2","color":"gray"}]}}]
tellraw @s [{"text":"[ 冷却清零（所有人） ]","color":"gold","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/reset_cd_all"},"hoverEvent":{"action":"show_text","contents":[{"text":"清所有玩家的 cd / cd2","color":"gray"}]}}]
tellraw @s [{"text":"───── 实体 ─────","color":"gray"}]
tellraw @s [{"text":"[ 生成调试怪物 ]","color":"red","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/spawn"},"hoverEvent":{"action":"show_text","contents":[{"text":"打开怪物生成菜单","color":"gray"}]}}]
tellraw @s [{"text":"[ 清除调试怪物 ]","color":"dark_red","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/kill_mobs"},"hoverEvent":{"action":"show_text","contents":[{"text":"清除全部 kitpvp.debug_mob","color":"gray"}]}}]
tellraw @s [{"text":"───── 游戏控制 ─────","color":"gray"}]
tellraw @s [{"text":"[ 开始游戏 ]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:game/start"},"hoverEvent":{"action":"show_text","contents":[{"text":"立即开始一局","color":"gray"}]}}]
tellraw @s [{"text":"[ 强制结算 ]","color":"gold","clickEvent":{"action":"run_command","value":"/function kitpvp:game/end"},"hoverEvent":{"action":"show_text","contents":[{"text":"进入结算流程","color":"gray"}]}}]
tellraw @s [{"text":"[ 强制重置 ]","color":"red","clickEvent":{"action":"run_command","value":"/function kitpvp:game/reset"},"hoverEvent":{"action":"show_text","contents":[{"text":"立即重置回大厅","color":"gray"}]}}]
tellraw @s [{"text":"[ 强制跑胜负判定 ]","color":"aqua","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/check_winner"},"hoverEvent":{"action":"show_text","contents":[{"text":"手动触发 game/check_winner","color":"gray"}]}}]
tellraw @s [{"text":"═════════════════════","color":"dark_red","bold":true}]
```

src/data/kitpvp/functions/debug/status.mcfunction
```mcfunction
# ===== 显示自己的调试状态 =====
# 调用：/function kitpvp:debug/status

tellraw @s [{"text":"═══════ 我的状态 ═══════","color":"gold","bold":true}]
tellraw @s [{"text":"职业ID: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.kit"},"color":"yellow"},{"text":"   命数: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.lives"},"color":"red"},{"text":"   存活: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.alive"},"color":"green"}]
tellraw @s [{"text":"冷却: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.cd"},"color":"aqua"},{"text":"   第二冷却: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.cd2"},"color":"aqua"}]
tellraw @s [{"text":"击杀: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.kills"},"color":"light_purple"},{"text":"   死亡: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.deaths"},"color":"dark_red"}]
tellraw @s [{"text":"无敌剩余: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.inv"},"color":"gold"},{"text":"   死亡检测: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.death_detect"},"color":"red"}]
tellraw @s [{"text":"金苹果 used/last: ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.gapple_used"},"color":"gold"},{"text":" / ","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.gapple_last"},"color":"gold"}]
tellraw @s [{"text":"全局 state: ","color":"gray"},{"score":{"name":"#state","objective":"kitpvp.game"},"color":"aqua"},{"text":"   幸存者: ","color":"gray"},{"score":{"name":"#survivors","objective":"kitpvp.game"},"color":"green"},{"text":"   地图ID: ","color":"gray"},{"score":{"name":"#global","objective":"kitpvp.map"},"color":"yellow"},{"text":"   倒计时: ","color":"gray"},{"score":{"name":"#global","objective":"kitpvp.timer"},"color":"gold"},{"text":"   test: ","color":"gray"},{"score":{"name":"#test","objective":"kitpvp.game"},"color":"red"}]
tellraw @s [{"text":"标签: ","color":"gray"},{"nbt":"Tags","entity":"@s","color":"yellow"}]
tellraw @s [{"text":"═════════════════════","color":"gold","bold":true}]
```

src/data/kitpvp/functions/debug/heal.mcfunction
```mcfunction
# ===== 回满血 =====
# 1.20.1 无 /heal，用 instant_health amplifier 5 (level 6) 回满
# saturation amplifier 10 顺带补饱食度

effect give @s minecraft:instant_health 1 5 true
effect give @s minecraft:saturation 1 10 true
tellraw @s [{"text":"[调试] 已回满血","color":"green"}]
```

src/data/kitpvp/functions/debug/add_lives.mcfunction
```mcfunction
# ===== 命数 +1 =====

scoreboard players add @s kitpvp.lives 1
tellraw @s [{"text":"[调试] 命数 +1，当前：","color":"green"},{"score":{"name":"@s","objective":"kitpvp.lives"},"color":"yellow"}]
```

src/data/kitpvp/functions/debug/remove_lives.mcfunction
```mcfunction
# ===== 命数 -1 =====

scoreboard players remove @s kitpvp.lives 1
tellraw @s [{"text":"[调试] 命数 -1，当前：","color":"red"},{"score":{"name":"@s","objective":"kitpvp.lives"},"color":"yellow"}]
```

src/data/kitpvp/functions/debug/reset_cd.mcfunction
```mcfunction
# ===== 清零自己的冷却 =====

scoreboard players set @s kitpvp.cd 0
scoreboard players set @s kitpvp.cd2 0
tellraw @s [{"text":"[调试] 自己的冷却已清零","color":"green"}]
```

src/data/kitpvp/functions/debug/reset_cd_all.mcfunction
```mcfunction
# ===== 清零所有玩家的冷却 =====

scoreboard players set @a kitpvp.cd 0
scoreboard players set @a kitpvp.cd2 0
tellraw @a [{"text":"[调试] 所有人的冷却已清零","color":"yellow"}]
```

src/data/kitpvp/functions/debug/god_toggle.mcfunction
```mcfunction
# ===== 切换调试无敌 =====
# 用 tag kitpvp.debug_god 记住状态，命令里用 execute if/unless 分派

execute if entity @s[tag=kitpvp.debug_god] run function kitpvp:debug/god_off
execute unless entity @s[tag=kitpvp.debug_god] run function kitpvp:debug/god_on
```

src/data/kitpvp/functions/debug/god_on.mcfunction
```mcfunction
# ===== 开启调试无敌 =====
# 抗性 V = amplifier 4，时长给一个很大的秒数

tag @s add kitpvp.debug_god
effect give @s minecraft:resistance 999999 4 true
tellraw @s [{"text":"[调试] 无敌已开启（抗性 V）","color":"green"}]
```

src/data/kitpvp/functions/debug/god_off.mcfunction
```mcfunction
# ===== 关闭调试无敌 =====

tag @s remove kitpvp.debug_god
effect clear @s minecraft:resistance
tellraw @s [{"text":"[调试] 无敌已关闭","color":"red"}]
```

src/data/kitpvp/functions/debug/kill_self.mcfunction
```mcfunction
# ===== 自杀（测试死亡处理流程） =====

kill @s
```

src/data/kitpvp/functions/debug/tp_lobby.mcfunction
```mcfunction
# ===== 传送回大厅 =====
# 直接走 lobby/enter 流程，保证 tag / 模式 / 菜单与正常进入一致

function kitpvp:lobby/enter
```

src/data/kitpvp/functions/debug/check_winner.mcfunction
```mcfunction
# ===== 手动跑一次胜负判定 =====
# 用于调试过程中快速触发 game/check_winner 里的逻辑

function kitpvp:game/check_winner
```

src/data/kitpvp/functions/debug/spawn.mcfunction
```mcfunction
# ===== 生成调试怪物（子菜单） =====
# 所有生成出来的实体都带 tag kitpvp.debug_mob，便于一键清理

tellraw @s [{"text":"═══════ 生成怪物 ═══════","color":"red","bold":true}]
tellraw @s [{"text":"[ 假人靶子（无 AI 僵尸） ]","color":"gray","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/spawn_dummy"},"hoverEvent":{"action":"show_text","contents":[{"text":"静音、无 AI、不动但可打","color":"gray"}]}}]
tellraw @s [{"text":"[ 攻击僵尸（铁剑） ]","color":"green","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/spawn_zombie"},"hoverEvent":{"action":"show_text","contents":[{"text":"持铁剑的僵尸","color":"gray"}]}}]
tellraw @s [{"text":"[ 攻击骷髅（弓） ]","color":"green","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/spawn_skeleton"},"hoverEvent":{"action":"show_text","contents":[{"text":"持弓的骷髅","color":"gray"}]}}]
tellraw @s [{"text":"[ 苦力怕 ]","color":"green","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/spawn_creeper"},"hoverEvent":{"action":"show_text","contents":[{"text":"受 mobGriefing=false 保护","color":"gray"}]}}]
tellraw @s [{"text":"[ 清空调试怪物 ]","color":"dark_red","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/kill_mobs"},"hoverEvent":{"action":"show_text","contents":[{"text":"kill 所有 kitpvp.debug_mob","color":"gray"}]}}]
tellraw @s [{"text":"[ 返回 ]","color":"yellow","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/menu"},"hoverEvent":{"action":"show_text","contents":[{"text":"回到调试菜单","color":"gray"}]}}]
```

src/data/kitpvp/functions/debug/spawn_dummy.mcfunction
```mcfunction
# ===== 生成假人靶子（无 AI 僵尸） =====
# 站在 @s 朝向 3 格外；静音、无 AI、可被打、不掉装备

execute at @s run summon minecraft:zombie ~ ~ ~3 {Tags:["kitpvp.debug_mob"],CustomName:'{"text":"调试靶子","color":"gray","italic":true}',CustomNameVisible:1b,Silent:1b,NoAI:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{},{}],ArmorItems:[{},{},{},{}]}
tellraw @s [{"text":"[调试] 已生成假人靶子","color":"green"}]
```

src/data/kitpvp/functions/debug/spawn_zombie.mcfunction
```mcfunction
# ===== 生成攻击僵尸（持铁剑） =====
# HandItems: [主手, 副手]，HandDropChances 设为 0 掉率

execute at @s run summon minecraft:zombie ~ ~ ~3 {Tags:["kitpvp.debug_mob"],CustomName:'{"text":"调试僵尸","color":"red"}',CustomNameVisible:1b,PersistenceRequired:1b,HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],HandDropChances:[0.0f,0.0f]}
tellraw @s [{"text":"[调试] 已生成攻击僵尸","color":"green"}]
```

src/data/kitpvp/functions/debug/spawn_skeleton.mcfunction
```mcfunction
# ===== 生成攻击骷髅（持弓） =====

execute at @s run summon minecraft:skeleton ~ ~ ~3 {Tags:["kitpvp.debug_mob"],CustomName:'{"text":"调试骷髅","color":"red"}',CustomNameVisible:1b,PersistenceRequired:1b,HandItems:[{id:"minecraft:bow",Count:1b},{}],HandDropChances:[0.0f,0.0f]}
tellraw @s [{"text":"[调试] 已生成攻击骷髅","color":"green"}]
```

src/data/kitpvp/functions/debug/spawn_creeper.mcfunction
```mcfunction
# ===== 生成苦力怕 =====
# 地形破坏由 gamerule mobGriefing=false 兜底

execute at @s run summon minecraft:creeper ~ ~ ~3 {Tags:["kitpvp.debug_mob"],CustomName:'{"text":"调试苦力怕","color":"red"}',CustomNameVisible:1b,PersistenceRequired:1b}
tellraw @s [{"text":"[调试] 已生成苦力怕","color":"green"}]
```

src/data/kitpvp/functions/debug/kill_mobs.mcfunction
```mcfunction
# ===== 清除调试怪物 =====
# 只清打了 tag kitpvp.debug_mob 的实体，不影响其他生物

kill @e[tag=kitpvp.debug_mob]
tellraw @s [{"text":"[调试] 已清除所有调试怪物","color":"red"}]
```

几点提醒：

1. 全部文件都用旧的 `functions`（复数）路径，命名空间 `kitpvp`。
2. `debug/tp_lobby` 走的是 `lobby/enter`，会顺带 `gamemode adventure` + `clear` + 弹菜单，跟正常进入一致；若你希望"只传送不动状态"，告诉我，我再拆一份。
3. `debug/status` 用到了 `#survivors`、`#test`、`#state`、`#global` 这些假玩家分数，它们都已在 `load.mcfunction` 中初始化；若以后新增假玩家，同样按红线要求先在 `load` 里 `set` 一份。
4. 想更方便调出，可以在 `lobby/menu.mcfunction` 末尾追加：
```mcfunction
tellraw @s [{"text":"[调试]","color":"dark_red","clickEvent":{"action":"run_command","value":"/function kitpvp:debug/menu"},"hoverEvent":{"action":"show_text","contents":[{"text":"打开调试控制台","color":"gray"}]}}]
```
5. 生成怪物用 `summon` + 旧版 NBT（`HandItems`、`Count:1b`、`CustomName: '...'`），没有使用 1.20.5+ 的 components 或 1.20.2+ 的宏。