# 第 12 秒：一圈结束先把计时器归零，再数当前 iLsacuL，≥14 只就打开每刻自爆开关
# ⚠ 魂石那只（soul_li_pig）**不能算进这个数**：它是一只打不死、玩家也清不掉的猪，
#   会把 13 只硬顶到 14 → 开关打开 → 之后每次放蛋生出来的猪当刻就被炸（"瞬爆"）。
#   它照常参加复制与引爆（那是它的演出），只是不能当"凑数的那一只"。
scoreboard players set #litimer kitpvp.game 0
scoreboard players set #licount kitpvp.game 0
execute as @e[tag=kitpvp.li_pig,tag=!kitpvp.soul_li_pig] run scoreboard players add #licount kitpvp.game 1
execute if score #licount kitpvp.game matches 14.. run scoreboard players set #liapoc kitpvp.game 1
