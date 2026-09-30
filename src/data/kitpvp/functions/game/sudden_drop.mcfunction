# ===== 突然死亡：每 20 秒给存活玩家发一次魂石 =====
# 魂石清单未定（设计文档第十节 TODO），当前留空接口

# 非进行中 → 中止循环
execute unless score #state kitpvp.game matches 1 run schedule clear kitpvp:game/sudden_drop

# 发放（占位）
# execute as @a[scores={kitpvp.alive=1},tag=kitpvp.selected] run function kitpvp:skill/soul_stone

# 继续调度（20 秒后再次发放）
execute if score #state kitpvp.game matches 1 run schedule function kitpvp:game/sudden_drop 400t replace