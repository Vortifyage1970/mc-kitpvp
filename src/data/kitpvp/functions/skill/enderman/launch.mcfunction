# @s = 刚出传送门的玩家：一次 tp 送到门外面（+ 抬高），之后完全交给重力，不逐刻 tp
# 按出口门的类型分三张表：#tep_face 0 墙（水平甩出去）/ 1 地面（竖直往上顶）/ 2 天花板（竖直往下砸）
# 每一档按进门时的下落深度选：掉得越深，弹得越远/越高
execute if score #tep_face kitpvp.game matches 0 if score @s kitpvp.tep_dash matches ..3 at @s run tp @s ^ ^0.4 ^1.6
execute if score #tep_face kitpvp.game matches 0 if score @s kitpvp.tep_dash matches 4..7 at @s run tp @s ^ ^0.6 ^2.8
execute if score #tep_face kitpvp.game matches 0 if score @s kitpvp.tep_dash matches 8..11 at @s run tp @s ^ ^0.8 ^4.0
execute if score #tep_face kitpvp.game matches 0 if score @s kitpvp.tep_dash matches 12.. at @s run tp @s ^ ^1.0 ^5.2

execute if score #tep_face kitpvp.game matches 1 if score @s kitpvp.tep_dash matches ..3 at @s run tp @s ^ ^1.6 ^0.4
execute if score #tep_face kitpvp.game matches 1 if score @s kitpvp.tep_dash matches 4..7 at @s run tp @s ^ ^2.6 ^0.4
execute if score #tep_face kitpvp.game matches 1 if score @s kitpvp.tep_dash matches 8..11 at @s run tp @s ^ ^3.6 ^0.4
execute if score #tep_face kitpvp.game matches 1 if score @s kitpvp.tep_dash matches 12.. at @s run tp @s ^ ^4.6 ^0.4

execute if score #tep_face kitpvp.game matches 2 if score @s kitpvp.tep_dash matches ..3 at @s run tp @s ^ ^-1.0 ^0.4
execute if score #tep_face kitpvp.game matches 2 if score @s kitpvp.tep_dash matches 4..7 at @s run tp @s ^ ^-1.6 ^0.4
execute if score #tep_face kitpvp.game matches 2 if score @s kitpvp.tep_dash matches 8..11 at @s run tp @s ^ ^-2.2 ^0.4
execute if score #tep_face kitpvp.game matches 2 if score @s kitpvp.tep_dash matches 12.. at @s run tp @s ^ ^-2.8 ^0.4

data merge entity @s {FallDistance:0f}
particle minecraft:dragon_breath ~ ~0.9 ~ 0.4 0.5 0.4 0.05 14 normal
playsound minecraft:entity.enderman.teleport master @a[distance=..16] ~ ~ ~ 0.8 1.1
