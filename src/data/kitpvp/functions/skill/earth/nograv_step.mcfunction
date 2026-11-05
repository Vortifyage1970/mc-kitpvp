# @s = 一只无重力召唤物，at 它身上：朝最近的玩家走一步
# ★ 顺滑跟随：24 格内每刻都只挪 0.12 格（≈2.4 格/秒），不再按距离分段 —— 分段那版会在 6 格处"啪"一下瞬移
#   挪的方向用 execute facing 把眼睛朝向玩家脚底（含俯仰），所以上下楼/爬台阶时也会跟着往上飘
# ★ 前方 0.5 格不是空气就不走（三种空气 id 逐个点名，没用方块标签）⇒ 撞墙会停下，想要穿墙删掉这三条
# ★ 兜底：玩家跑到 24 格外（刚召唤、玩家传送走了）才直接贴过去；这是救命用的，不是日常移动
scoreboard players add #nograv_runs kitpvp.game 1
execute if entity @p[distance=1.5..24,sort=nearest] facing entity @p[distance=1.5..24,sort=nearest] feet if block ^ ^ ^0.5 minecraft:air run tp @s ^ ^ ^0.12
execute if entity @p[distance=1.5..24,sort=nearest] facing entity @p[distance=1.5..24,sort=nearest] feet if block ^ ^ ^0.5 minecraft:cave_air run tp @s ^ ^ ^0.12
execute if entity @p[distance=1.5..24,sort=nearest] facing entity @p[distance=1.5..24,sort=nearest] feet if block ^ ^ ^0.5 minecraft:void_air run tp @s ^ ^ ^0.12
execute unless entity @p[distance=..24,sort=nearest] if entity @p[distance=24..64,sort=nearest] run tp @s @p[distance=24..64,sort=nearest]

# ★ 保底：万一还是落进方块里（低天花板、楼梯缝、玩家贴墙），把整只往上顶出去，别让乘客吃窒息伤害
execute unless block ~ ~ ~ minecraft:air unless block ~ ~ ~ minecraft:cave_air unless block ~ ~ ~ minecraft:void_air run tp @s ~ ~1.2 ~
execute unless block ~ ~ ~ minecraft:air unless block ~ ~ ~ minecraft:cave_air unless block ~ ~ ~ minecraft:void_air run tp @s ~ ~1.2 ~