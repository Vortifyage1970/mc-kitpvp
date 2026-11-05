# 调试：原地召 10 只随机生灵，围成一圈（半径 2）+ 头顶两层错开，避免全部叠在同一点
# 走 random 而不是 summon：summon 会播 10 次草地音、刷 10 条 actionbar，而且每只都重跑一次 link
# 最后由一次 link 统一认归属：它会把 4 格内所有 earth_minion_new 拉进你的队槽（所以它们不会打你）
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
function kitpvp:skill/earth/link
title @s actionbar {"text":"已召 10 只随机生灵","color":"aqua"}
playsound minecraft:block.grass.place master @s ~ ~ ~ 1.0 0.9
