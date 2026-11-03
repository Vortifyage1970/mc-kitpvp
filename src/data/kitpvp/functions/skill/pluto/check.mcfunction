# 鹦鹉没了（找不到属于自己号的那只）=> 本体强制死亡
# ⚠ 必须有宽限：跨区传送 / 区块刚卸载的那几刻，@e 也选不到它。原来立刻判死，
#   表现就是"传送到地图先白死一条命"（2026-11 实测踩到）。现在缺 6 刻才判死，中途找到就清零。
scoreboard players operation #ptid kitpvp.game = @s kitpvp.ptid
scoreboard players set #pparrot kitpvp.game 0
execute as @e[type=minecraft:parrot,tag=kitpvp.pluto_parrot] if score @s kitpvp.parrot_owner = #ptid kitpvp.game run scoreboard players set #pparrot kitpvp.game 1

execute if score #pparrot kitpvp.game matches 1 run scoreboard players set @s kitpvp.parrot_miss 0
execute if score #pparrot kitpvp.game matches 0 run scoreboard players add @s kitpvp.parrot_miss 1
execute if score @s kitpvp.parrot_miss matches 6.. run function kitpvp:skill/pluto/die
