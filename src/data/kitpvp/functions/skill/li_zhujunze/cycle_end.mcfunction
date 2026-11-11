# 第 12 秒：计时器归零，再数当前 iLsacuL
#  · 数量 ≥40（正常一局到不了：复制封顶 16）→ 打开"全部爆炸"开关，一次炸干净（安全阀）
#  · 否则数量 ≥16（满场）→ 静默清掉复制体，留下种子猪继续下一圈
# ⚠ 魂石那只（soul_li_pig）不算数：它打不死、清不掉，会凭空把数量顶上去
scoreboard players set #litimer kitpvp.game 0
scoreboard players set #licount kitpvp.game 0
execute as @e[tag=kitpvp.li_pig,tag=!kitpvp.soul_li_pig] run scoreboard players add #licount kitpvp.game 1
execute if score #licount kitpvp.game matches 40.. run scoreboard players set #liapoc kitpvp.game 1
execute if score #licount kitpvp.game matches 16..39 run function kitpvp:skill/li_zhujunze/cycle_clear
