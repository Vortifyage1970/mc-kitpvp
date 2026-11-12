# 水星魂石：一次性 buff，20 秒速度 +200%（速度等级 X = amplifier 9）
# 触发改成 advancement（item_used_on_block + NBT 带 KitSoulMercury），驯兽师的海豚蛋不会再误触发
advancement revoke @s only kitpvp:player/soul_mercury_use

effect give @s minecraft:speed 20 9 true
title @s actionbar {"text":"魂石·极速：20 秒移动速度 +200%","color":"aqua"}
playsound minecraft:entity.dolphin.splash master @s ~ ~ ~ 1.0 1.4

execute at @s run kill @e[tag=kitpvp.soul_mercury_token]
execute at @s run kill @e[type=minecraft:dolphin,name="水星魂石",distance=..8]
