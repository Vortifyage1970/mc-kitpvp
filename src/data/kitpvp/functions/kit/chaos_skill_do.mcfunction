# 重铸：清掉手上的武器，随机发一把新的；冷却 30 秒（600 刻）
scoreboard players set @s kitpvp.chaos_skill_cd 600
execute at @s run kill @e[tag=kitpvp.chaos_token,distance=..8]
playsound minecraft:block.beacon.activate master @s ~ ~ ~ 1 1.2
particle minecraft:enchanted_hit ~ ~1 ~ 0.5 0.5 0.5 0.1 20 normal
item replace entity @s weapon.mainhand with minecraft:air
title @s actionbar {"text":"混沌·重铸","color":"dark_purple"}
function kitpvp:kit/chaos_next
