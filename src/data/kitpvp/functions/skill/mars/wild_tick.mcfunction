# 每 24 刻（1.2 秒）在巨人附近刷一只生灵
execute if score #mars_wild_timer kitpvp.game matches 1.. run scoreboard players remove #mars_wild_timer kitpvp.game 1
execute if score #mars_wild_timer kitpvp.game matches ..0 run function kitpvp:skill/mars/wild_spawn
