# 游玩模式：生存 + 参与统计（挂 selected）；不自动给职业，不结算
tag @s add kitpvp.selected

tag @s remove kitpvp.spectator
tag @s remove kitpvp.in_lobby
tag @s remove kitpvp.respawn_pending

scoreboard players set @s kitpvp.lives 3
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.inv 0

gamemode survival @s
clear @s
effect clear @s

function kitpvp:player/invincible

title @s times 5 30 10
title @s title {"text":"游玩模式","color":"green","bold":true}
title @s subtitle {"text":"请先选职业","color":"gray"}
