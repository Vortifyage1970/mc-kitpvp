# 抽卡：0..112 = 88.3% 蓄力，113..125 = 10.2% 伤害吸收，126..127 = 1.6% 领域
scoreboard players set #li_r kitpvp.game 0
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 1
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 2
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 4
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 8
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 16
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 32
execute store success score #li_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #li_b kitpvp.game matches 1 run scoreboard players add #li_r kitpvp.game 64
execute if score #li_r kitpvp.game matches 0..112 run function kitpvp:skill/li_ench/pull_charge
execute if score #li_r kitpvp.game matches 113..125 run function kitpvp:skill/li_ench/pull_absorb
execute if score #li_r kitpvp.game matches 126..127 run function kitpvp:skill/li_ench/pull_domain
