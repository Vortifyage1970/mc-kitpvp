# @s = 非玩家实体（召唤物 / 箭 / 掉落物）：从A 进、从 B 出
execute at @e[tag=kitpvp.tep_b,limit=1] run tp @s ~ ~-1.2 ~
scoreboard players set @s kitpvp.tep_ready 20
tag @s add kitpvp.tep_locked
data merge entity @s {Motion:[0.0d,0.3d,0.0d]}
particle minecraft:dragon_breath ~ ~0.5 ~ 0.3 0.5 0.3 0.03 10 normal
