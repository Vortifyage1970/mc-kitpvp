# 起手 20 刻后展开：报幕、起乐、两个技能一起锁 240 秒
tellraw @a [{"text":"◆　","color":"dark_aqua"},{"text":"无量空渔","color":"white","bold":true},{"text":"！","color":"aqua","bold":true},{"text":"　◆","color":"dark_aqua"}]
execute as @a at @s run playsound minecraft:entity.warden.sonic_boom master @s ~ ~ ~ 0.6 1.1
execute as @a at @s run playsound minecraft:item.trident.thunder master @s ~ ~ ~ 0.5 0.9
particle minecraft:splash ~ ~1 ~ 2.5 2.5 2.5 0.1 400

# 雨爱约 58 秒，与 60 秒领域基本同步
function kitpvp:music/yu_ai/start

scoreboard players set @s kitpvp.cd 4800
scoreboard players set @s kitpvp.cd2 4800
title @s actionbar {"text":"领域展开：无量空渔 60 秒","color":"dark_aqua"}
