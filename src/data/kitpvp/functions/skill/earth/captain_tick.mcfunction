# @s = 队长：6 秒一轮 —— cap_cd 从 120 数到 0，120..60 举盾（约 3 秒），59..1 放下
scoreboard players remove @s kitpvp.cap_cd 1
execute if score @s kitpvp.cap_cd matches ..0 run scoreboard players set @s kitpvp.cap_cd 120
execute if score @s kitpvp.cap_cd matches 60.. run tag @s add kitpvp.cap_block
execute if score @s kitpvp.cap_cd matches ..59 run tag @s remove kitpvp.cap_block
# 举盾期间：抗性 IV（减伤 80%）+ 缓慢 I（他站在原地顶住）
execute if entity @s[tag=kitpvp.cap_block] run effect give @s minecraft:resistance infinite 3 true
execute unless entity @s[tag=kitpvp.cap_block] run effect clear @s minecraft:resistance
execute if entity @s[tag=kitpvp.cap_block] run effect give @s minecraft:slowness infinite 0 true
execute unless entity @s[tag=kitpvp.cap_block] run effect clear @s minecraft:slowness
# 举盾那一刻"啪"一声
execute if score @s kitpvp.cap_cd matches 120 run playsound minecraft:item.shield.block hostile @a[distance=..16] ~ ~ ~ 0.9 1.2
# 举盾期间的可视信号：副手盾面（左侧 0.6 格）往冒电火花 + 头顶白雾
execute if entity @s[tag=kitpvp.cap_block] at @s positioned ^ ^ ^0.6 run particle minecraft:electric_spark ~ ~ ~ 0.15 0.25 0.15 0.01 6
execute if entity @s[tag=kitpvp.cap_block] at @s run particle minecraft:end_rod ~ ~2.05 ~ 0.25 0.1 0.25 0.01 3
# 放下盾那一刻也响一声（第 59 刻），提示"现在可以打了"
execute if score @s kitpvp.cap_cd matches 59 run playsound minecraft:item.shield.break hostile @a[distance=..16] ~ ~ ~ 0.4 1.6
