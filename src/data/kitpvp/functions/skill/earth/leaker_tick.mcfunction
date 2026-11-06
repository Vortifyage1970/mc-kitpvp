# @s = 泄露者的播报时钟（一个 marker）；场上还有活着的就播报并重置 15 秒，全死光就自毁
execute if entity @e[tag=kitpvp.earth_leaker] run scoreboard players set @s kitpvp.leaker_cd 300
# sort=random,limit=1 ⇒ 从还活着的那几个里随机抽一个（1.20.1 支持 sort=random）
execute if entity @e[tag=kitpvp.earth_leaker] as @e[tag=kitpvp.earth_leaker,sort=random,limit=1] at @s run function kitpvp:skill/earth/leaker_report
execute unless entity @e[tag=kitpvp.earth_leaker] run kill @s
