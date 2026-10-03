# ===== 魂石之弓：20 秒到期 =====
execute as @a[tag=kitpvp.soul_bow_held,scores={kitpvp.soul_bow_timer=1..}] run scoreboard players remove @s kitpvp.soul_bow_timer 1
execute as @a[tag=kitpvp.soul_bow_held,scores={kitpvp.soul_bow_timer=..0}] run function kitpvp:skill/soul/bow_expire
