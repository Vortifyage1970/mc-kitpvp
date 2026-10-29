# 第 12 秒：一圈结束先把计时器归零，再数当前 iLsacuL，≥14 只就打开每刻自爆开关
scoreboard players set #litimer kitpvp.game 0
scoreboard players set #licount kitpvp.game 0
execute as @e[tag=kitpvp.li_pig] run scoreboard players add #licount kitpvp.game 1
execute if score #licount kitpvp.game matches 14.. run scoreboard players set #liapoc kitpvp.game 1
