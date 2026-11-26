# 辞令补货：上限 1、20 秒（400 刻）；cd 由使用侧 cizhi_cast 起计（见 03 §2.13）
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:sniffer_spawn_egg{KitCizhi:1b} 0
execute if score @s kitpvp.tmp matches ..0 run function kitpvp:skill/zhuzhiwu/give_token
execute if score @s kitpvp.tmp matches ..0 run scoreboard players set @s kitpvp.cd 400
execute if score @s kitpvp.tmp matches ..0 run title @s actionbar {"text":"补给：辞令","color":"gold"}
