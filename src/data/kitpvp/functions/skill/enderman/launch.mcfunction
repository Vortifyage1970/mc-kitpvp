# @s = 刚出传送门的玩家：一次 tp 送到门外 + 抬高，之后完全交给重力（不再逐刻 tp，所以不会卡）
# 分档用字面量坐标（tp 的 ^ 位移只能写字面量），越深的下落弹得越远越高
execute if score @s kitpvp.tep_dash matches ..3 at @s run tp @s ^ ^0.6 ^1.6
execute if score @s kitpvp.tep_dash matches 4..7 at @s run tp @s ^ ^1.0 ^2.8
execute if score @s kitpvp.tep_dash matches 8..11 at @s run tp @s ^ ^1.4 ^4.0
execute if score @s kitpvp.tep_dash matches 12.. at @s run tp @s ^ ^1.8 ^5.2
data merge entity @s {FallDistance:0f}
particle minecraft:dragon_breath ~ ~0.9 ~ 0.4 0.5 0.4 0.05 14 normal
playsound minecraft:entity.enderman.teleport master @a[distance=..16] ~ ~ ~ 0.8 1.1
