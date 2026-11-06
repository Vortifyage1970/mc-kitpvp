# 幻翼的"共生"守卫：被拴的骷髅一死，幻翼跟着死；幻翼没了就停止自续
# 每刻检查（由 haunt_test_b 启动，靠自身 schedule 续命，不需要挂进 tick）
execute unless entity @e[tag=kitpvp.debug_phantom_leashed] run kill @e[tag=kitpvp.debug_phantom_holder]
execute if entity @e[tag=kitpvp.debug_phantom_holder] run schedule function kitpvp:debug/haunt_watch 1t replace
