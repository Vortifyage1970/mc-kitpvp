# @s = 制冷中的舔狗：给 10 格内的其他玩家打上"正在冷气里"的标记（主人按 vtid 排除）
# 冷度的加减在 tick 里按这个标记分流：有标记 +1、没标记 -1
scoreboard players operation #vtid kitpvp.game = @s kitpvp.dog_owner
execute as @a[distance=..10,scores={kitpvp.alive=1},tag=!kitpvp.spectator] unless score @s kitpvp.vtid = #vtid kitpvp.game run tag @s add kitpvp.venus_chilled
