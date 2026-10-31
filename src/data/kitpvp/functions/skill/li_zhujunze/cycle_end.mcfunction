# 第 12 秒：一圈结束先把计时器归零，再数当前 iLsacuL，≥14 只就打开每刻自爆开关
# 只数"会死的那批"：soul_li_pig 是抗性 V、炸不死的，算进来会让 ≥14 的判定永远关不掉（见 li_apply）
scoreboard players set #litimer kitpvp.game 0
scoreboard players set #licount kitpvp.game 0
execute as @e[tag=kitpvp.li_pig,tag=!kitpvp.soul_li_pig] run scoreboard players add #licount kitpvp.game 1
execute if score #licount kitpvp.game matches 14.. run scoreboard players set #liapoc kitpvp.game 1
