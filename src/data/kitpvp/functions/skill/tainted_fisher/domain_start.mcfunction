# 「领域展开」起手：cd2 先占成 20 刻（1 秒前摇），开领域时改写成 4800（240 秒）。
# 计时器 1220 刻一个变量表达三段：1220 起手 → 1200 开领域 → 0 收束（同 05 §4 的"同一变量表达效果期+冷却期"）
scoreboard players set @s kitpvp.cd2 20
scoreboard players set @s kitpvp.tainted_fisher_domain_timer 1220
tag @s remove kitpvp.tainted_fisher_domain
tag @s add kitpvp.tainted_fisher_domain

# 刷怪蛋刷出的那只鱿鱼当场清掉（只认自己 tag 的那只，地图里的鱿鱼不动）
execute at @s run kill @e[type=minecraft:squid,tag=kitpvp.tainted_fisher_domain_token,distance=..16]

# 另一个技能的令牌当场收走（同 blue_start）：两个技能此时都被占位锁住，留着只会按不出反应
clear @s minecraft:glow_squid_spawn_egg{KitTaintedFisherBlue:1b}

# 雨从起手那刻就落：激流 I 三叉戟在雨里能全图突进，这是本技能的核心联动。
# load 里关了 doWeatherCycle，雨不会自己停 —— 停雨由 domain_end 与 game/reset 两道保险负责（见 04 §五）
weather rain 60

tellraw @a [{"text":"◆　","color":"dark_aqua"},{"text":"领","color":"dark_blue","bold":true},{"text":"域","color":"blue","bold":true},{"text":"展","color":"dark_aqua","bold":true},{"text":"开","color":"aqua","bold":true},{"text":"　◆","color":"dark_aqua"}]
execute as @a at @s run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 0.6 0.8
title @s actionbar {"text":"领域展开中…（1 秒）","color":"dark_aqua"}
