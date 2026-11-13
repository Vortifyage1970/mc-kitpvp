# @s = 火球（执行位置就在命中点）：结算 4 点魔法伤害 + 点着玩家，然后炸掉自己
# 想让目标"烧起来"不能用 /data 改玩家的 Fire（玩家数据不允许 data 命令修改，会报错），只能 setblock fire（会留下一格火、还会蔓延）——这里改成火焰粒子代替，不做点燃
# ---- 诊断（确认原因后删这三行）----
execute as @a[distance=..2.2,gamemode=!spectator,tag=!kitpvp.spectator] run tellraw @a [{"text":"[诊断] 命中 ","color":"green"},{"selector":"@s"},{"text":"｜模式 ","color":"gray"},{"nbt":"playerGameType","entity":"@s","color":"aqua"},{"text":"｜血量 ","color":"gray"},{"nbt":"Health","entity":"@s","color":"aqua"}]
# 有主就按"生物远程攻击"结算（归还击杀/伤害归属），主人已经死了就退化成无来源伤害
execute if entity @e[tag=kitpvp.earth_babywhelp,distance=..48] as @a[distance=..2.2,gamemode=!spectator,tag=!kitpvp.spectator] at @s run damage @s 4 minecraft:magic by @e[tag=kitpvp.earth_babywhelp,distance=..48,limit=1]
execute unless entity @e[tag=kitpvp.earth_babywhelp,distance=..48] run damage @a[distance=..2.2,gamemode=!spectator,tag=!kitpvp.spectator] 4 minecraft:magic
execute as @a[distance=..2.2,gamemode=!spectator,tag=!kitpvp.spectator] run tellraw @a [{"text":"[诊断] 打完血量 ","color":"green"},{"nbt":"Health","entity":"@s","color":"gold"}]
particle minecraft:explosion ~ ~ ~ 0 0 0 0 1
particle minecraft:flame ~ ~ ~ 0.25 0.25 0.25 0.03 6
playsound minecraft:entity.generic.explode hostile @a[distance=..16] ~ ~ ~ 0.8 1.2
kill @s
