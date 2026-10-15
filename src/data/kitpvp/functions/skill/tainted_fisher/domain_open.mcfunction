# 起手后 20 刻：领域正式展开 —— 报幕、起乐、锁住两个技能（放领域展开 → 两个都锁 240 秒）
tellraw @a [{"text":"◆　","color":"dark_aqua"},{"text":"无量空渔","color":"white","bold":true},{"text":"！","color":"aqua","bold":true},{"text":"　◆","color":"dark_aqua"}]
execute as @a at @s run playsound minecraft:entity.warden.sonic_boom master @s ~ ~ ~ 0.6 1.1
execute as @a at @s run playsound minecraft:item.trident.thunder master @s ~ ~ ~ 0.5 0.9
particle minecraft:splash ~ ~1 ~ 2.5 2.5 2.5 0.1 400

# 雨爱（yu_ai）：114 个事件的音符盒链，约 58 秒，与本技能的 60 秒领域基本同步
function kitpvp:music/yu_ai/start

scoreboard players set @s kitpvp.cd 4800
scoreboard players set @s kitpvp.cd2 4800
title @s actionbar {"text":"领域展开：无量空渔（60 秒）","color":"dark_aqua"}
