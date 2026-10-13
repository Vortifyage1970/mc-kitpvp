# 全局计时器：每 20 刻递减一次并自我调度；非进行中即自清
execute unless score #state kitpvp.game matches 1 run schedule clear kitpvp:game/timer_tick

execute if score #state kitpvp.game matches 1 run scoreboard players remove #global kitpvp.timer 1

execute if score #state kitpvp.game matches 1 if score #global kitpvp.timer matches 0 run function kitpvp:game/sudden_death_start

execute if score #state kitpvp.game matches 1 if score #global kitpvp.timer matches 1.. run schedule function kitpvp:game/timer_tick 20t replace
