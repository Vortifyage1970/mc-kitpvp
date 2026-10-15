# 「苍」起手：1.5 秒前摇，交给 30 刻的 cang_tick 计时器报幕与释放。
# 此刻先把 cd 占成 30 刻 —— 它同时锁住"再按一次"和另一个技能，释放时会被改写成 1200（60 秒）。
# 不用 schedule 拆时间轴：两个里·渔夫同时咏唱时同名 schedule 会被 replace 互相顶掉，计时器才能各算各的
scoreboard players set @s kitpvp.cd 30
scoreboard players set @s kitpvp.tainted_fisher_cang_timer 30
tag @s remove kitpvp.tainted_fisher_cang
tag @s add kitpvp.tainted_fisher_cang

# 刷怪蛋必定真的刷出一只发光鱿鱼，当场清掉（distance 16 覆盖右键射程，只认自己 tag 的那只）
execute at @s run kill @e[type=minecraft:glow_squid,tag=kitpvp.tainted_fisher_blue_token,distance=..16]

# 另一个技能的令牌当场收走：此刻两个技能都被占位锁住，留着它只会让人拿着按不出反应
# （clear 只清背包，丢在地上那份收不掉；重发由 tick 在 cd/cd2 同时归零后统一做）
clear @s minecraft:squid_spawn_egg{KitTaintedFisherDomain:1b}

tellraw @a [{"text":"◈　","color":"gold"},{"text":"位","color":"gold","bold":true},{"text":"相","color":"yellow","bold":true},{"text":"　◈","color":"gold"}]
execute as @a at @s run playsound minecraft:block.conduit.activate master @s ~ ~ ~ 0.7 1.3
title @s actionbar {"text":"咏唱中…（1.5 秒）","color":"aqua"}
