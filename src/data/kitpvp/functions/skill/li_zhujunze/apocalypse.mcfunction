# 每刻：所有 iLsacuL 以半径 8 自爆；一只都不剩时关掉开关
# 爆炸伤害在下一 tick 结算，所以这里数到的数量含"本刻刚引爆、还没死"的猪，开关会多留一 tick
# soul_li_pig（魂石那只抗性 V 的）两条都不参与：炸它没意义，数它会让开关永远关不掉（见 li_apply）
execute as @e[tag=kitpvp.li_pig,tag=!kitpvp.soul_li_pig] at @s run function kitpvp:skill/li_zhujunze/boom8

scoreboard players set #licount kitpvp.game 0
execute as @e[tag=kitpvp.li_pig,tag=!kitpvp.soul_li_pig] run scoreboard players add #licount kitpvp.game 1
execute if score #licount kitpvp.game matches 0 run scoreboard players set #liapoc kitpvp.game 0
