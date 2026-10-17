# 重生兜底（见 04 §十一）：出生点那格或它正上方被水/方块占住时，原版判定重生点无效，
# 会把玩家丢到主世界出生点（主大厅）。这里按分配出生点时记下的编号，把人送回自己那个点。
# 锚点是站在各出生点上的隐形 marker，随每局 map/distribute 重建、game/reset 清掉。
# 1.20.1 没有 `return`，也不需要在开头加守卫：编号不匹配或锚点已被清时，整行自己静默不执行。
execute if score @s kitpvp.spawn_slot matches 1 at @e[type=minecraft:marker,tag=kitpvp.spawn_anchor.1,limit=1] run tp @s ~ ~ ~
execute if score @s kitpvp.spawn_slot matches 2 at @e[type=minecraft:marker,tag=kitpvp.spawn_anchor.2,limit=1] run tp @s ~ ~ ~
execute if score @s kitpvp.spawn_slot matches 3 at @e[type=minecraft:marker,tag=kitpvp.spawn_anchor.3,limit=1] run tp @s ~ ~ ~
execute if score @s kitpvp.spawn_slot matches 4 at @e[type=minecraft:marker,tag=kitpvp.spawn_anchor.4,limit=1] run tp @s ~ ~ ~
execute if score @s kitpvp.spawn_slot matches 5 at @e[type=minecraft:marker,tag=kitpvp.spawn_anchor.5,limit=1] run tp @s ~ ~ ~
execute if score @s kitpvp.spawn_slot matches 6 at @e[type=minecraft:marker,tag=kitpvp.spawn_anchor.6,limit=1] run tp @s ~ ~ ~
execute if score @s kitpvp.spawn_slot matches 7 at @e[type=minecraft:marker,tag=kitpvp.spawn_anchor.7,limit=1] run tp @s ~ ~ ~
execute if score @s kitpvp.spawn_slot matches 8 at @e[type=minecraft:marker,tag=kitpvp.spawn_anchor.8,limit=1] run tp @s ~ ~ ~
execute if score @s kitpvp.spawn_slot matches 9 at @e[type=minecraft:marker,tag=kitpvp.spawn_anchor.9,limit=1] run tp @s ~ ~ ~
