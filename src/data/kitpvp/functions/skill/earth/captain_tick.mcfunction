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
# 举盾那一刻"啪"一声；盾面上有电火花，方便玩家判断现在能不能打
execute if score @s kitpvp.cap_cd matches 120 run playsound minecraft:item.shield.block hostile @a[distance=..16] ~ ~ ~ 0.9 1.2
execute if entity @s[tag=kitpvp.cap_block] at @s run particle minecraft:electric_spark ~ ^1 ~0.55 0.2 0.15 0.2 0.01 1
