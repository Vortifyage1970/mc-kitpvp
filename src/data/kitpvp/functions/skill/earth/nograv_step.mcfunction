# @s = 一只无重力召唤物，at 它身上：朝最近的玩家走一步
# ★ 远处（>6 格）直接落到玩家脚下 —— 玩家站的地方一定是空气，这样不会把乘客（僵尸）塞进方块里扣血
# ★ 近处（1.5~6 格）才小步挪，而且要求前方 0.6 格处是空气（三个 id 逐个点名，不用方块标签）
#   代价：它不再穿墙，被墙挡住会停在原地 —— 想恢复穿墙就把三条 if block 删掉
execute if entity @p[distance=6..24,sort=nearest] run tp @s @p[distance=6..24,sort=nearest] ~ ~ ~
execute if entity @p[distance=1.5..6,sort=nearest] run tp @s ~ ~ ~ facing entity @p[distance=1.5..6,sort=nearest] feet
execute if entity @p[distance=1.5..6,sort=nearest] if block ^ ^ ^0.6 minecraft:air run tp @s ^ ^ ^0.12
execute if entity @p[distance=1.5..6,sort=nearest] if block ^ ^ ^0.6 minecraft:cave_air run tp @s ^ ^ ^0.12
execute if entity @p[distance=1.5..6,sort=nearest] if block ^ ^ ^0.6 minecraft:void_air run tp @s ^ ^ ^0.12