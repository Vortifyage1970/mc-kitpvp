# @s = 一只无重力召唤物，at 它身上：朝最近的玩家走一步
# ★ 远处（6~24 格）直接贴到玩家身上。注意目的地必须写成"实体"形式（tp @s @p），
#   不能写成 tp @s @p ~ ~ ~ —— 实体选择器后面接坐标三元组在 1.20.1 里解析不了，
#   会导致整个函数加载失败、一条都不执行（这就是"不动"的真正原因）
# ★ 近处（1.5~6 格）先用 execute facing 把朝向指向玩家，再沿 ^ ^ ^ 挪 0.12；
#   前方 0.6 格不是空气就不走（三种空气 id 逐个点名）⇒ 被墙挡住会停在原地，想要穿墙就删这三条
# 计数 #nograv_runs 只用来排查"这条到底有没有每秒跑"，不影响手感
scoreboard players add #nograv_runs kitpvp.game 1
execute if entity @p[distance=6..24,sort=nearest] run tp @s @p[distance=6..24,sort=nearest]
execute if entity @p[distance=1.5..6,sort=nearest] facing entity @p[distance=1.5..6,sort=nearest] feet if block ^ ^ ^0.6 minecraft:air run tp @s ^ ^ ^0.12
execute if entity @p[distance=1.5..6,sort=nearest] facing entity @p[distance=1.5..6,sort=nearest] feet if block ^ ^ ^0.6 minecraft:cave_air run tp @s ^ ^ ^0.12
execute if entity @p[distance=1.5..6,sort=nearest] facing entity @p[distance=1.5..6,sort=nearest] feet if block ^ ^ ^0.6 minecraft:void_air run tp @s ^ ^ ^0.12

# ★ 保底：万一还是落进方块里（低天花板、楼梯缝、玩家贴墙），把整只往上顶出去，别让乘客吃窒息伤害
execute unless block ~ ~ ~ minecraft:air unless block ~ ~ ~ minecraft:cave_air unless block ~ ~ ~ minecraft:void_air run tp @s ~ ~1.2 ~
execute unless block ~ ~ ~ minecraft:air unless block ~ ~ ~ minecraft:cave_air unless block ~ ~ ~ minecraft:void_air run tp @s ~ ~1.2 ~