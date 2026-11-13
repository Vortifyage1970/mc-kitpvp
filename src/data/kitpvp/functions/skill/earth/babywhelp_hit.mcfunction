# @s = 火球（执行位置就在命中点）：结算 4 点魔法伤害 + 点着玩家，然后炸掉自己
execute as @a[distance=..1.5,gamemode=!spectator,tag=!kitpvp.spectator] run data merge entity @s {Fire:60s}
# 有主就按"生物远程攻击"结算（归还击杀/伤害归属），主人已经死了就退化成无来源伤害
execute if entity @e[tag=kitpvp.earth_babywhelp,distance=..48] as @a[distance=..1.5,gamemode=!spectator,tag=!kitpvp.spectator] at @s run damage @s 4 minecraft:magic by @e[tag=kitpvp.earth_babywhelp,distance=..48,limit=1]
execute unless entity @e[tag=kitpvp.earth_babywhelp,distance=..48] run damage @a[distance=..1.5,gamemode=!spectator,tag=!kitpvp.spectator] 4 minecraft:magic
particle minecraft:explosion ~ ~ ~ 0 0 0 0 1
particle minecraft:flame ~ ~ ~ 0.3 0.3 0.3 0.05 15
playsound minecraft:entity.generic.explode hostile @a[distance=..16] ~ ~ ~ 0.8 1.2
kill @s
