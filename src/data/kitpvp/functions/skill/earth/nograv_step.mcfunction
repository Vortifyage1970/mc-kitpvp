# @s = 一只无重力召唤物，at 它身上：朝最近的玩家走一步
# ★ 远处（>6 格）直接落到玩家脚下 —— 玩家站的地方一定是空气，这样不会把乘客（僵尸）塞进方块里扣血
# ★ 近处（1.5~6 格）先 facing 把"前方"朝向玩家，再沿 ^ ^ ^ 挪 0.12；面朝方向变了，^ 才指向玩家
#   facing 写在 execute 里（execute ... facing entity <实体> feet 一定存在），不要用 tp 自带 facing 的写法
# ★ 前方 0.6 格不是空气就不走（三种空气 id 逐个点名，不用方块标签）⇒ 被墙挡住会停在原地，想恢复穿墙删掉三条 if block
# 计数 #nograv_runs 只用来排查"这条到底有没有每秒跑"，不影响手感
scoreboard players add #nograv_runs kitpvp.game 1
execute if entity @p[distance=6..24,sort=nearest] run tp @s @p[distance=6..24,sort=nearest] ~ ~ ~
execute if entity @p[distance=1.5..6,sort=nearest] facing entity @p[distance=1.5..6,sort=nearest] feet if block ^ ^ ^0.6 minecraft:air run tp @s ^ ^ ^0.12
execute if entity @p[distance=1.5..6,sort=nearest] facing entity @p[distance=1.5..6,sort=nearest] feet if block ^ ^ ^0.6 minecraft:cave_air run tp @s ^ ^ ^0.12
execute if entity @p[distance=1.5..6,sort=nearest] facing entity @p[distance=1.5..6,sort=nearest] feet if block ^ ^ ^0.6 minecraft:void_air run tp @s ^ ^ ^0.12

# ★ 保底：万一还是落进方块里（低天花板、楼梯缝、玩家贴墙），把整只往上顶出去，别让乘客吃窒息伤害
# 两遍是因为单次只抬 1.2 格，卡在两格深的夹缝里需要两次
execute unless block ~ ~ ~ minecraft:air unless block ~ ~ ~ minecraft:cave_air unless block ~ ~ ~ minecraft:void_air run tp @s ~ ~1.2 ~
execute unless block ~ ~ ~ minecraft:air unless block ~ ~ ~ minecraft:cave_air unless block ~ ~ ~ minecraft:void_air run tp @s ~ ~1.2 ~