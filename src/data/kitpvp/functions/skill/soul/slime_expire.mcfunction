# 到期只撤开关，不碰效果：增益是 20 秒一次性的，会自己走完（清掉会连表史莱姆的无限跳跃提升一起摘掉）
tag @s remove kitpvp.soul_slime_active
tag @s remove kitpvp.rocket_full
scoreboard players set @s kitpvp.soul_slime_timer 0
scoreboard players set @s kitpvp.rocket_charge 0
# 里·史莱姆（kit 31）自己的蓄力不随魂石到期而失效
execute unless score @s kitpvp.kit matches 31 run tag @s remove kitpvp.rocket_jump

title @s actionbar {"text":"魂石·蓄力已消散","color":"gray"}
