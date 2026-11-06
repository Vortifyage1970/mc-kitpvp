# @s = 刚挨打的玩家；2 格内有借调员工时，有 37.5% 概率由他抢先认领这口锅
# 认领的效果很废：他自己掉 2 点血，玩家仍然挂 3 秒反胃 —— 伤害该掉的早掉了，这就是"背锅"
scoreboard players set #sg_roll kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #sg_roll kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #sg_roll kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #sg_roll kitpvp.game 4
execute if predicate kitpvp:random/1in2 run scoreboard players add #sg_roll kitpvp.game 8
execute if score #sg_roll kitpvp.game matches ..5 at @s run function kitpvp:skill/earth/scapegoat_confess
