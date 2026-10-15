# 400 → 380 落「无量空渔」→ 0 收束（同 domain_tick 的写法）
execute if score @s kitpvp.soul_fisher_timer matches 380 run function kitpvp:skill/soul/fisher_open
execute if score @s kitpvp.soul_fisher_timer matches 1.. run scoreboard players remove @s kitpvp.soul_fisher_timer 1
execute if score @s kitpvp.soul_fisher_timer matches ..0 run function kitpvp:skill/soul/fisher_expire
