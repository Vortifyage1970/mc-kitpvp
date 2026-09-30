# ===== 全局计时器：每 20 刻（1 秒）递减一次 =====
# 由 game/start_impl 首次 schedule，此后自我调度

# 非进行中 → 清掉本循环，不再往下走
execute unless score #state kitpvp.game matches 1 run schedule clear kitpvp:game/timer_tick

# 进行中 → 递减
execute if score #state kitpvp.game matches 1 run scoreboard players remove #global kitpvp.timer 1

# 恰好归零 → 进入突然死亡（本轮只触发一次）
execute if score #state kitpvp.game matches 1 if score #global kitpvp.timer matches 0 run function kitpvp:game/sudden_death_start

# 剩余时间 > 0 → 继续调度
execute if score #state kitpvp.game matches 1 if score #global kitpvp.timer matches 1.. run schedule function kitpvp:game/timer_tick 20t replace
