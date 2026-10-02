# 命令手册（1.20.1）

> 本文件写"能用的、易错的"，不重复 `00-version.md` 的禁止项。
> 禁止项以 `00-version.md` 为准。

---

## 一、玩家筛选

```mcfunction
execute as @a[tag=!kitpvp.joined] run function kitpvp:player/join
execute as @a[scores={kitpvp.kit=1,kitpvp.alive=1}] run ...
execute as @a[scores={kitpvp.cd=1..}] run scoreboard players remove @s kitpvp.cd 1
execute as @a[scores={kitpvp.cd=..300},tag=kitpvp.shield_held] run ...
```

- `scores={obj=1..}` 是"≥ 1"；`scores={obj=..300}` 是"≤ 300"；`scores={obj=0}` 是精确等于。
- **服务端可能跳刻**：到期判定一律用 `..N` 而不是 `=N`。
- 所有 tick 里的玩家筛选都要显式加 `tag=!kitpvp.spectator`。

---

## 二、补零、递增、递减、快照

```mcfunction
scoreboard players add @a kitpvp.inv 0
scoreboard players remove @s kitpvp.cd 1
scoreboard players set @s kitpvp.cd 800
scoreboard players operation @s kitpvp.gapple_last = @s kitpvp.gapple_used
```

- `add ... 0` 是补零惯用法：给没分数的玩家建一个 0，**不改动已有分数**。
- `set` 会归零已有分数，不能拿来补零。
- `operation A = B` 是复制 B 到 A，用于快照推进。

---

## 三、统计 objective

```mcfunction
scoreboard objectives add kitpvp.tank_used minecraft.used:minecraft.iron_golem_spawn_egg
scoreboard objectives add kitpvp.gapple_used minecraft.used:minecraft.golden_apple
scoreboard objectives add kitpvp.ready_used minecraft.used:minecraft.carrot_on_a_stick
```

- 检测方式：本刻 `used > last` → 刚使用过一次。
- **只覆盖原版物品，且不分来源**。
- 必须在 `load.mcfunction` 里统一创建。

---

## 四、NBT 与背包检测

```mcfunction
execute unless data entity @s Inventory[{tag:{KitTankEgg:1b}}] run ...
clear @s minecraft:shield{KitShield:1b}
give @s minecraft:iron_golem_spawn_egg{KitTankEgg:1b,display:{Name:'{"text":"举盾令牌","color":"aqua","bold":true}'}} 1
give @s minecraft:shield{KitShield:1b,Damage:256} 1
```

- 路径用点号分隔，数组用方括号：`Inventory[...]`、`SelectedItem.tag.xxx`。
- **1.20.1 是旧版 NBT**：`Enchantments:[{id,lvl}]`、`display:{Name}`、`Unbreakable:1b`、`Damage:256`。
- `clear <target> <item>{<nbt>}` 只清背包。

---

## 五、判定与伤害

```mcfunction
execute as @a[tag=kitpvp.selected,gamemode=!spectator] if entity @s[y=-1024,dy=950] run damage @s 1000 minecraft:out_of_world
kill @e[type=minecraft:arrow,nbt={inGround:1b}]
execute as @a[scores={kitpvp.kit=3}] at @s run kill @e[type=iron_golem,distance=..16,name="举盾令牌"]
```

- **虚空判死**：`y=-1024,dy=950` 覆盖 y ∈ [-1024, -74]。
  改阈值**只改 `dy`**（上界 = y + dy - 1），不要动 `y`。
- `damage ... minecraft:out_of_world` 绕过抗性，适合做"强制判死"。
- `distance=..16` 以执行点为圆心，半径 16 格。
- `name="..."` 匹配生物 CustomName 纯文本。
- **任何全局 `kill @e` 都要在注释里写明可能误杀什么**。

---

## 六、药水效果

```mcfunction
effect give @s minecraft:instant_health 1 5 true
effect give @s minecraft:invisibility 5 0 true
effect give @s minecraft:speed 5 2 true
effect clear @s
```

- 参数顺序：`effect give <target> <effect> <持续秒> <amplifier> <隐藏粒子>`
- amplifier 0 = I 级，2 = III 级，5 = VI 级。
- `instant_health` 治疗量 = 4 × 2^amp 点。amp 5 = 128 点，足够回满。
- **同效果高等级会顶替低等级**，不叠加。

---

## 七、文本组件

```mcfunction
title @s actionbar {"text":"补给进入冷却：40 秒","color":"gray"}
tellraw @a {"text":"[开始游戏]","color":"green","clickEvent":{"action":"run_command","value":"/function kitpvp:game/start"}}
```

- 用小驼峰 `clickEvent` / `hoverEvent`，不用 `click_event`。
- `run_command` 的 `value` **必须**以 `/` 开头。
- `hoverEvent` 字段是 `contents`，不是 `value`。
- 外层单引号包 JSON 时，**内部全部用双引号**。

---

## 八、其它

```mcfunction
ride @s dismount
schedule function kitpvp:game/reset 200t replace
xp set @s 0 points
xp set @s 0 levels
attribute @s minecraft:generic.max_health base set 20
```

- `schedule ... replace` 的语义是"同 id 只保留最后一次"，适合全局唯一计时器。
- `attribute ... base set` 是修改基础值，`clear_player` 里复位属性时用。
- 1.20.1 无 `/heal`、无 `/extinguish`。

---

## 九、gamerule 与调试反馈

- 所有 gamerule 在 `load.mcfunction` 里设置（按需开启/关闭）。
- 建议设置 `gamerule sendCommandFeedback false`，但注意：**它会吞掉大量命令反馈**。
- 写调试函数时用 `tellraw` / `say` 显式输出，别靠默认反馈判断成败。