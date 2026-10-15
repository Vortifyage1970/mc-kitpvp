# 领域收束：开领域满 60 秒（起手后第 1220 刻）。
# 无条件停雨：本局可能中途重置而把雨的"主人"摘掉（clear_player 会拿走 tag），
# 而 load 关了 doWeatherCycle、雨不会自己停 —— 这里与 game/reset 是两道保险（见 04 §五）
weather clear

tellraw @a [{"text":"◆　","color":"dark_aqua"},{"text":"无量空渔 ","color":"gray","bold":true},{"text":"已收束","color":"dark_aqua","bold":true},{"text":"　◆","color":"dark_aqua"}]
execute as @a at @s run playsound minecraft:block.beacon.deactivate master @s ~ ~ ~ 0.6 1.2

tag @s remove kitpvp.tainted_fisher_domain
scoreboard players set @s kitpvp.tainted_fisher_domain_timer 0
effect give @s minecraft:weakness 60 0 true
title @s actionbar {"text":"无量空渔已收束：虚弱 I 60 秒","color":"gray"}
