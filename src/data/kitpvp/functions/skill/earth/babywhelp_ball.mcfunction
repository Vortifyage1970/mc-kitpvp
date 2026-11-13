# @s = 飞龙宝宝吐出的火球（small_fireball）
# ⚠ 它自己的 Motion 是 0、带 NoGravity：这个火球完全靠下面的 tp 飞，不让原版物理碰它。
#   原因：原版小火球砸到方块会就地放火，而且无视 mobGriefing（MC-70251）——
#   让它自己飞，射偏一发竞技场就着一块。零速度时原版的命中检测长度为 0，永远不会触发。
scoreboard players add @s kitpvp.bw_life 1
# 尾迹
execute at @s run particle minecraft:flame ~ ~ ~ 0.02 0.02 0.02 0.005 1
# 追击：每刻重新对准"最近的活玩家"的胸口再前进 0.9 格（at @s 会把这只火球自己的 Rotation 带进 ^ 的计算）
# ⚠ 以前是"吐出那一刻的朝向直着飞"——玩家一走就擦过去，看起来就是瞄不准。改成每刻重新 facing，火球会拐一点弯，但跟得住人。
execute at @s facing entity @p[distance=..32,gamemode=!spectator,tag=!kitpvp.spectator] eyes run tp @s ^ ^ ^0.9
# 一个人都没有了：按自己最后的朝向继续飞，靠 40 刻寿命自然消失
execute unless entity @p[distance=..32,gamemode=!spectator,tag=!kitpvp.spectator] at @s run tp @s ^ ^ ^0.9
# 撞到方块：冒烟熄灭，不烧方块、不伤自己人
execute at @s unless block ~ ~ ~ minecraft:air unless block ~ ~ ~ minecraft:cave_air unless block ~ ~ ~ minecraft:void_air run function kitpvp:skill/earth/babywhelp_fizzle
# 命中玩家（2.2 格内）→ 结算伤害
# ⚠ 半径必须 > 1.7：火球是按'比玩家眼高'的高度飞过去的，而 distance 量的是火球到玩家**脚底坐标**的直线距离，..1.5 永远差一点点 ⇒ 火球从人身上穿过去绕圈，看起来既没伤害又轨迹诡异
execute at @s if entity @a[distance=..2.2,gamemode=!spectator,tag=!kitpvp.spectator] run function kitpvp:skill/earth/babywhelp_hit
# 寿命上限 40 刻（约 16 格），没打到任何东西也会消失
execute if score @s kitpvp.bw_life matches 40.. run function kitpvp:skill/earth/babywhelp_fizzle
