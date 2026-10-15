# 魂石·激流的 400 刻时间轴：400 起手 → 380 落「无量空渔」→ 0 收束（一个计时器表达两段，同里·渔夫的 domain_tick）
# 由 tick 以 `as @a[tag=kitpvp.soul_fisher_active] at @s` 调用，所以 ~ 都锚在玩家身上
execute if score @s kitpvp.soul_fisher_timer matches 380 run function kitpvp:skill/soul/fisher_open
execute if score @s kitpvp.soul_fisher_timer matches 1.. run scoreboard players remove @s kitpvp.soul_fisher_timer 1
execute if score @s kitpvp.soul_fisher_timer matches ..0 run function kitpvp:skill/soul/fisher_expire
