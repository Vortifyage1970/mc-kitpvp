打乱后的出生点分配（只重出 `spawn_1`~`spawn_9`，其余文件不变）：

打乱顺序的依据：分配机制是"随机起点 + 沿 1→9 环形顺次领人"，所以**相邻编号必须在地理上远离**。重排后所有相邻编号的直线距离都 ≥ 76 格（原本连续的"同一行/同一列"配对，如 473,527↔527,527，被拆到了不相邻的位置）。

| 新编号 | 坐标 | 象限 |
|---|---|---|
| 1 | 554 76 446 | 外圈·东北 |
| 2 | 473 69 527 | 内圈·西南 |
| 3 | 446 76 446 | 外圈·西北 |
| 4 | 527 69 473 | 内圈·东北 |
| 5 | 554 76 554 | 外圈·东南 |
| 6 | 473 69 473 | 内圈·西北 |
| 7 | 527 69 527 | 内圈·东南 |
| 8 | 446 76 554 | 外圈·西南 |
| 9 | 500 72 500 | 中心 |

src/data/kitpvp/functions/map/arena/spawn_1.mcfunction
```mcfunction
# 竞技场出生点 1（改坐标改下面两行）
tp @s 554 76 446
spawnpoint @s 554 76 446
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
```

src/data/kitpvp/functions/map/arena/spawn_2.mcfunction
```mcfunction
# 竞技场出生点 2（改坐标改下面两行）
tp @s 473 69 527
spawnpoint @s 473 69 527
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
```

src/data/kitpvp/functions/map/arena/spawn_3.mcfunction
```mcfunction
# 竞技场出生点 3（改坐标改下面两行）
tp @s 446 76 446
spawnpoint @s 446 76 446
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
```

src/data/kitpvp/functions/map/arena/spawn_4.mcfunction
```mcfunction
# 竞技场出生点 4（改坐标改下面两行）
tp @s 527 69 473
spawnpoint @s 527 69 473
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
```

src/data/kitpvp/functions/map/arena/spawn_5.mcfunction
```mcfunction
# 竞技场出生点 5（改坐标改下面两行）
tp @s 554 76 554
spawnpoint @s 554 76 554
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
```

src/data/kitpvp/functions/map/arena/spawn_6.mcfunction
```mcfunction
# 竞技场出生点 6（改坐标改下面两行）
tp @s 473 69 473
spawnpoint @s 473 69 473
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
```

src/data/kitpvp/functions/map/arena/spawn_7.mcfunction
```mcfunction
# 竞技场出生点 7（改坐标改下面两行）
tp @s 527 69 527
spawnpoint @s 527 69 527
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
```

src/data/kitpvp/functions/map/arena/spawn_8.mcfunction
```mcfunction
# 竞技场出生点 8（改坐标改下面两行）
tp @s 446 76 554
spawnpoint @s 446 76 554
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
```

src/data/kitpvp/functions/map/arena/spawn_9.mcfunction
```mcfunction
# 竞技场出生点 9（改坐标改下面两行）
tp @s 500 72 500
spawnpoint @s 500 72 500
tag @s add kitpvp.spawn_assigned
scoreboard players add #cur kitpvp.tmp 1
execute if score #cur kitpvp.tmp matches 10.. run scoreboard players set #cur kitpvp.tmp 1
```

---

**注意事项**

- `distribute` / `pass` / `restore` / `select_arena` 及 `map/` 根下四个文件的内容与上一轮相同，不重出。若你上一轮还没落盘，请以那一版为准。
- 若后续再加出生点，同样按"相邻编号距离最大化"的原则插进环形，别直接追加到末尾（追加会让 9→10 相邻变近）。
- 中心点 9（500 72 500）到任何内圈点只有 38 格距离，这是几何上无法避免的——现在的排法把中心点两侧都换成外圈邻居（8 和 1），所以 9 的两条边都是 76 格。