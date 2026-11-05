# 5 秒到点：没点的人挨一下瞬间伤害并被告状；点过的人不扣血
# 结算完把 0/1 一律推成 2：两只动员家的窗口撞在一起时，重复跑也不会重复扣血
execute as @a[scores={kitpvp.mob_ready=0}] run function kitpvp:skill/earth/mobilizer_punish
scoreboard players set @a[scores={kitpvp.mob_ready=0..1}] kitpvp.mob_ready 2
