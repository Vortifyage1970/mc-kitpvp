# 突然死亡心跳：每 20 刻逐玩家倒计时，归零即发一颗魂石（间隔见 game/soul_tick）
execute unless score #state kitpvp.game matches 1 run schedule clear kitpvp:game/sudden_drop
execute if score #state kitpvp.game matches 1 as @a[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator,tag=kitpvp.sudden_death] run function kitpvp:game/soul_tick
execute if score #state kitpvp.game matches 1 run schedule function kitpvp:game/sudden_drop 20t replace
