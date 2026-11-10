# @s = 冲刺中的玩家：每刻沿视线前进 0.55 格（步子小才不卡），撞到实心方块就停
scoreboard players remove @s kitpvp.tep_step 1
execute positioned ^ ^ ^0.55 if block ~ ~ ~ minecraft:air if block ~ ~1 ~ minecraft:air run tp @s ~ ~ ~
execute positioned ^ ^ ^0.55 unless block ~ ~ ~ minecraft:air run scoreboard players set @s kitpvp.tep_step 0
execute positioned ^ ^ ^0.55 if block ~ ~1 ~ minecraft:air unless block ~ ~ ~ minecraft:air run scoreboard players set @s kitpvp.tep_step 0
data merge entity @s {FallDistance:0f}
execute unless score @s kitpvp.tep_step matches 1.. run particle minecraft:poof ~ ~0.9 ~ 0.2 0.6 0.2 0.01 6 normal
