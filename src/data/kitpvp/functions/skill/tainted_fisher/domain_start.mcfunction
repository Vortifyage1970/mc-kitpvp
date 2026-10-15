# 起手：cd2 先占 20 刻（1 秒前摇），开领域时改写成 4800；计时器 1220 → 1200 → 0 表达三段
scoreboard players set @s kitpvp.cd2 20
scoreboard players set @s kitpvp.tainted_fisher_domain_timer 1220
tag @s remove kitpvp.tainted_fisher_domain
tag @s add kitpvp.tainted_fisher_domain

# 清掉刷怪蛋刷出的那只鱿鱼
execute at @s run kill @e[type=minecraft:squid,tag=kitpvp.tainted_fisher_domain_token,distance=..16]

# 收走另一个技能的令牌（同 blue_start）
clear @s minecraft:glow_squid_spawn_egg{KitTaintedFisherBlue:1b}

# 转雨：激流在雨里全图可用；doWeatherCycle 已关，雨得自己停（domain_end 与 game/reset）
weather rain 60

tellraw @a [{"text":"◆　","color":"dark_aqua"},{"text":"领","color":"dark_blue","bold":true},{"text":"域","color":"blue","bold":true},{"text":"展","color":"dark_aqua","bold":true},{"text":"开","color":"aqua","bold":true},{"text":"　◆","color":"dark_aqua"}]
execute as @a at @s run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 0.6 0.8
title @s actionbar {"text":"领域展开中…（1 秒）","color":"dark_aqua"}
