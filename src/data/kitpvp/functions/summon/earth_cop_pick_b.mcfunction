# 由 summon/earth_cop_pick 调：查车 / 闪现 五五开（各占总出率 1/3）
scoreboard players set #cop_pick_b kitpvp.game 0
execute store success score #cop_pick_b kitpvp.game if predicate kitpvp:random/1in2
execute if score #cop_pick_b kitpvp.game matches 1 run function kitpvp:summon/earth_cop_cleaner
execute if score #cop_pick_b kitpvp.game matches 0 run function kitpvp:summon/earth_cop_blink
