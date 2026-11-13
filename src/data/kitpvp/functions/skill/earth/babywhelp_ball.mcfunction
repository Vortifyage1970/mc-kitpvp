# @s = 飞龙宝宝吐出的火球（small_fireball）
# ⚠ 它自己的 Motion 是 0、带 NoGravity：这个火球完全靠下面的 tp 飞，不让原版物理碰它。
#   原因：原版小火球砸到方块会就地放火，而且无视 mobGriefing（MC-70251）——
#   让它自己飞，射偏一发竞技场就着一块。零速度时原版的命中检测长度为 0，永远不会触发。
scoreboard players add @s kitpvp.bw_life 1
# 尾迹
execute at @s run particle minecraft:flame ~ ~ ~ 0.02 0.02 0.02 0.005 1

# ---- 重新挑"能打的人"：32 格内、非创造/旁观/观战、且不是召唤者本人 ----
# bw_owner 是吐火球时记在这颗火球上的召唤者 etid；owner=0（没分配）时不做排除，否则会误伤旁观的其它玩家
scoreboard players set #bw_o kitpvp.game 0
scoreboard players operation #bw_o kitpvp.game = @s kitpvp.bw_owner
tag @a remove kitpvp.bw_cur
execute if score #bw_o kitpvp.game matches 1.. as @a[distance=..32,gamemode=!spectator,gamemode=!creative,tag=!kitpvp.spectator] unless score @s kitpvp.etid = #bw_o kitpvp.game run tag @s add kitpvp.bw_cur
execute unless score #bw_o kitpvp.game matches 1.. as @a[distance=..32,gamemode=!spectator,gamemode=!creative,tag=!kitpvp.spectator] run tag @s add kitpvp.bw_cur

# 追击：每刻对准目标的胸口再前进 0.9 格（at @s 会把这只火球自己的 Rotation 带进 ^ 的计算）
execute at @s if entity @p[tag=kitpvp.bw_cur] facing entity @p[tag=kitpvp.bw_cur] eyes run tp @s ^ ^ ^0.9
# 一个能打的人都没有：按自己最后的朝向继续飞，靠寿命自然消失
execute at @s unless entity @p[tag=kitpvp.bw_cur] run tp @s ^ ^ ^0.9

# 撞到方块：冒烟熄灭，不烧方块
execute at @s unless block ~ ~ ~ minecraft:air unless block ~ ~ ~ minecraft:cave_air unless block ~ ~ ~ minecraft:void_air run function kitpvp:skill/earth/babywhelp_fizzle
# 命中：1.7 格内。火球飞在目标眼高，而 distance 量的是到玩家"脚底坐标"的距离（垂直差恒约 1.62），
# 所以半径必须略大于 1.62 才咬得到人：1.7 换算成水平约 0.5 格，正好是"贴到人"的时机（2.2 就是隔着一格多提前炸）
execute at @s if entity @a[tag=kitpvp.bw_cur,distance=..1.7] run function kitpvp:skill/earth/babywhelp_hit
# 寿命上限 40 刻（约 16 格），没打到任何东西也会消失
execute if score @s kitpvp.bw_life matches 40.. run function kitpvp:skill/earth/babywhelp_fizzle
