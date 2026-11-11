# 建造模式：创造 + 退出游戏统计（摘 selected）；恢复用 debug/play
tag @s remove kitpvp.selected

tag @s remove kitpvp.spectator
tag @s remove kitpvp.respawn_pending
tag @s remove kitpvp.invincible

effect clear @s

# 1.20.1 无 /heal，用瞬加血代替
effect give @s minecraft:instant_health 1 5 true

gamemode creative @s

title @s times 5 30 10
title @s title {"text":"建造模式","color":"light_purple","bold":true}
title @s subtitle {"text":"创造 / 已退出游戏统计","color":"gray"}
