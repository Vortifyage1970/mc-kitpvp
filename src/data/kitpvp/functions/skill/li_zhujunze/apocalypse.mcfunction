# 每刻：所有 iLsacuL 以半径 8 自爆；一只都不剩时关掉开关
# 爆炸伤害在下一 tick 结算，所以这里数到的数量含"本刻刚引爆、还没死"的猪，开关会多留一 tick
# soul_li_pig（魂石那只抗性 V 的）只跳过"炸它"这一步：炸它没有任何效果，还会每刻刷一朵苦力怕。
# 但"关开关"只数会死的那批——这样它自己活着不会把 ≥14 的开关卡在开着的状态（见 li_apply）
execute as @e[tag=kitpvp.li_pig,tag=!kitpvp.soul_li_pig] at @s run function kitpvp:skill/li_zhujunze/boom8

scoreboard players set #licount kitpvp.game 0
execute as @e[tag=kitpvp.li_pig,tag=!kitpvp.soul_li_pig] run scoreboard players add #licount kitpvp.game 1
execute if score #licount kitpvp.game matches 0 run scoreboard players set #liapoc kitpvp.game 0
