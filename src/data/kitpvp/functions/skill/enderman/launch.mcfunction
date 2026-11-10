# @s = 刚出传送门的玩家：一次位移（只改位置、不改视角），之后交给重力
# 方向取"出口门的朝向"（rotated as 门），所以镜头不会因为门派的方向而转过去
# 表：墙门 = 水平甩出去（下落越深越平、越远，避免高台跳进来时"弹一下又掉"的蹦床感）
#     地面门 = 竖直往上顶；天花板门 = 竖直往下砸

execute if score #tep_face kitpvp.game matches 0 if score @s kitpvp.tep_dash matches ..3 rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^0.4 ^1.6
execute if score #tep_face kitpvp.game matches 0 if score @s kitpvp.tep_dash matches 4..7 rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^0.2 ^2.8
execute if score #tep_face kitpvp.game matches 0 if score @s kitpvp.tep_dash matches 8..11 rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^0.0 ^4.0
execute if score #tep_face kitpvp.game matches 0 if score @s kitpvp.tep_dash matches 12.. rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^-0.2 ^5.2
execute if score #tep_face kitpvp.game matches 0 if score @s kitpvp.tep_dash matches ..3 rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^0.4 ^1.6
execute if score #tep_face kitpvp.game matches 0 if score @s kitpvp.tep_dash matches 4..7 rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^0.2 ^2.8
execute if score #tep_face kitpvp.game matches 0 if score @s kitpvp.tep_dash matches 8..11 rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^0.0 ^4.0
execute if score #tep_face kitpvp.game matches 0 if score @s kitpvp.tep_dash matches 12.. rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^-0.2 ^5.2

execute if score #tep_face kitpvp.game matches 1 if score @s kitpvp.tep_dash matches ..3 rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^1.6 ^0.4
execute if score #tep_face kitpvp.game matches 1 if score @s kitpvp.tep_dash matches 4..7 rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^2.6 ^0.4
execute if score #tep_face kitpvp.game matches 1 if score @s kitpvp.tep_dash matches 8..11 rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^3.6 ^0.4
execute if score #tep_face kitpvp.game matches 1 if score @s kitpvp.tep_dash matches 12.. rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^4.6 ^0.4
execute if score #tep_face kitpvp.game matches 1 if score @s kitpvp.tep_dash matches ..3 rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^1.6 ^0.4
execute if score #tep_face kitpvp.game matches 1 if score @s kitpvp.tep_dash matches 4..7 rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^2.6 ^0.4
execute if score #tep_face kitpvp.game matches 1 if score @s kitpvp.tep_dash matches 8..11 rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^3.6 ^0.4
execute if score #tep_face kitpvp.game matches 1 if score @s kitpvp.tep_dash matches 12.. rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^4.6 ^0.4

execute if score #tep_face kitpvp.game matches 2 if score @s kitpvp.tep_dash matches ..3 rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^-1.0 ^0.4
execute if score #tep_face kitpvp.game matches 2 if score @s kitpvp.tep_dash matches 4..7 rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^-1.6 ^0.4
execute if score #tep_face kitpvp.game matches 2 if score @s kitpvp.tep_dash matches 8..11 rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^-2.2 ^0.4
execute if score #tep_face kitpvp.game matches 2 if score @s kitpvp.tep_dash matches 12.. rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^-2.8 ^0.4
execute if score #tep_face kitpvp.game matches 2 if score @s kitpvp.tep_dash matches ..3 rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^-1.0 ^0.4
execute if score #tep_face kitpvp.game matches 2 if score @s kitpvp.tep_dash matches 4..7 rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^-1.6 ^0.4
execute if score #tep_face kitpvp.game matches 2 if score @s kitpvp.tep_dash matches 8..11 rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^-2.2 ^0.4
execute if score #tep_face kitpvp.game matches 2 if score @s kitpvp.tep_dash matches 12.. rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^-2.8 ^0.4

data merge entity @s {FallDistance:0f}
particle minecraft:dragon_breath ~ ~0.9 ~ 0.4 0.5 0.4 0.05 14 normal
playsound minecraft:entity.enderman.teleport master @a[distance=..16] ~ ~ ~ 0.8 1.1
