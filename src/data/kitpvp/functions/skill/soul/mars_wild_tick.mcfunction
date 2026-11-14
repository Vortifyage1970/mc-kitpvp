# 与 skill/mars/wild_tick 同节奏：每 24 刻在巨人处刷一只地球生灵（1.2 秒）
execute if score #soul_mars_wild_timer kitpvp.game matches 1.. run scoreboard players remove #soul_mars_wild_timer kitpvp.game 1
execute if score #soul_mars_wild_timer kitpvp.game matches ..0 run function kitpvp:skill/soul/mars_wild_spawn
