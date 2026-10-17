# 「苍」起手：1.5 秒前摇交给 cang_tick 计时器。cd 先占 30 刻（锁住再按与另一技能），释放时改写成 900。
# 不用 schedule：两人同时咏唱时同名 schedule 会互相顶掉
scoreboard players set @s kitpvp.cd 30
scoreboard players set @s kitpvp.tainted_fisher_cang_timer 30
tag @s remove kitpvp.tainted_fisher_cang
tag @s add kitpvp.tainted_fisher_cang

# 清掉刷怪蛋刷出的那只发光鱿鱼
execute at @s run kill @e[type=minecraft:glow_squid,tag=kitpvp.tainted_fisher_blue_token,distance=..16]

# 收走另一个技能的令牌（clear 清不到丢在地上那份）
clear @s minecraft:squid_spawn_egg{KitTaintedFisherDomain:1b}

tellraw @a [{"text":"◈　","color":"gold"},{"text":"位","color":"gold","bold":true},{"text":"相","color":"yellow","bold":true},{"text":"　◈","color":"gold"}]
execute as @a at @s run playsound minecraft:block.conduit.activate master @s ~ ~ ~ 0.7 1.3
title @s actionbar {"text":"咏唱中…（1.5 秒）","color":"aqua"}
