# 全局计时器：每 20 刻递减一次并自我调度；非进行中即自清
execute unless score #state kitpvp.game matches 1 run schedule clear kitpvp:game/timer_tick

execute if score #state kitpvp.game matches 1 run scoreboard players remove #global kitpvp.timer 1

execute if score #state kitpvp.game matches 1 if score #global kitpvp.timer matches 0 run function kitpvp:game/sudden_death_start

# 最后 4 分钟起，每分钟 actionbar 报一次（只在整分钟提示，不打扰）
execute if score #state kitpvp.game matches 1 if score #global kitpvp.timer matches 240 run title @a actionbar {"text":"距突然死亡还有 4 分钟","color":"gold"}
execute if score #state kitpvp.game matches 1 if score #global kitpvp.timer matches 180 run title @a actionbar {"text":"距突然死亡还有 3 分钟","color":"gold"}
execute if score #state kitpvp.game matches 1 if score #global kitpvp.timer matches 120 run title @a actionbar {"text":"距突然死亡还有 2 分钟","color":"yellow"}
execute if score #state kitpvp.game matches 1 if score #global kitpvp.timer matches 60 run title @a actionbar {"text":"距突然死亡还有 1 分钟","color":"red"}

execute if score #state kitpvp.game matches 1 if score #global kitpvp.timer matches 1.. run schedule function kitpvp:game/timer_tick 20t replace
