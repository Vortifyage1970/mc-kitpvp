# 全员就绪 → 开局。守卫：至少 1 人已准备（否则空大厅也判定就绪）、无人未准备、#state=0
execute if entity @a[tag=kitpvp.in_lobby,tag=kitpvp.ready] unless entity @a[tag=kitpvp.in_lobby,tag=!kitpvp.ready] if score #state kitpvp.game matches 0 run function kitpvp:game/start
