# 幻翼的"共生"守卫 + 强制俯冲：被拴的骷髅一死幻翼跟着死；幻翼没了就停止自续
# 每刻检查（由 haunt_test_b 启动，靠自身 schedule 续命，不需要挂进 tick）
execute unless entity @e[tag=kitpvp.debug_phantom_leashed] run kill @e[tag=kitpvp.debug_phantom_holder]
# ---- 强制俯冲：原版幻翼要"锁定目标 + 盘旋到 attackPhase 到位"才扑，站着不动它可能一直绕圈 ----
# 每 100 刻（5 秒）强制扑一次：朝玩家方向直推，冲到离玩家 3 格内就自动停（最多 40 刻）
scoreboard players add #ph_t kitpvp.game 1
execute if score #ph_t kitpvp.game matches 100.. run scoreboard players set #ph_t kitpvp.game 0
execute if score #ph_t kitpvp.game matches 0 run scoreboard players set #ph_dv kitpvp.game 40
execute if score #ph_dv kitpvp.game matches 1.. as @e[tag=kitpvp.debug_phantom_holder] at @s if entity @p[gamemode=!spectator,tag=!kitpvp.spectator,distance=3..] facing entity @p[gamemode=!spectator,tag=!kitpvp.spectator] feet run tp @s ^ ^ ^0.6
execute if score #ph_dv kitpvp.game matches 1.. run scoreboard players remove #ph_dv kitpvp.game 1
execute if entity @e[tag=kitpvp.debug_phantom_holder] run schedule function kitpvp:debug/haunt_watch 1t replace
