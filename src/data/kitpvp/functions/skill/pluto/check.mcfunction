# 鹦鹉没了（找不到属于自己号的那只）=> 本体强制死亡
# 抗性 V 挡不住 out_of_world，正好用来保证"必死"；死亡照常扣命、传回出生点，
# 新鹦鹉由 player/after_death → skill/pluto/respawn 在重生后补上（见 06 §76）
scoreboard players operation #ptid kitpvp.game = @s kitpvp.ptid
scoreboard players set #pparrot kitpvp.game 0
execute as @e[type=minecraft:parrot,tag=kitpvp.pluto_parrot] if score @s kitpvp.parrot_owner = #ptid kitpvp.game run scoreboard players set #pparrot kitpvp.game 1
execute if score #pparrot kitpvp.game matches 0 run damage @s 1000 minecraft:out_of_world
