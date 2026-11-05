# 调试：原地召 10 只随机生灵，围成一圈（半径 2）+ 头顶两层错开，避免全部叠在同一点
# 走 random 而不是 summon：summon 会播 10 次草地音、刷 10 条 actionbar
# ★ 不调 link：这 10 只没有 "谁召的" 这回事 —— 不进你的队槽、也不写 earth_owner
#   ⇒ 它们会主动攻击你；变速器/大蜜蜂这类"认主人"的光环也一律按"无主"处理（正好用来测这条分支）
execute positioned ~2 ~ ~ run function kitpvp:skill/earth/random
execute positioned ~1.41 ~ ~1.41 run function kitpvp:skill/earth/random
execute positioned ~ ~ ~2 run function kitpvp:skill/earth/random
execute positioned ~-1.41 ~ ~1.41 run function kitpvp:skill/earth/random
execute positioned ~-2 ~ ~ run function kitpvp:skill/earth/random
execute positioned ~-1.41 ~ ~-1.41 run function kitpvp:skill/earth/random
execute positioned ~ ~ ~-2 run function kitpvp:skill/earth/random
execute positioned ~1.41 ~ ~-1.41 run function kitpvp:skill/earth/random
execute positioned ~ ~2 ~ run function kitpvp:skill/earth/random
execute positioned ~ ~3 ~ run function kitpvp:skill/earth/random
title @s actionbar {"text":"已召 10 只随机生灵（无归属，会打你）","color":"aqua"}
playsound minecraft:block.grass.place master @s ~ ~ ~ 1.0 0.9
