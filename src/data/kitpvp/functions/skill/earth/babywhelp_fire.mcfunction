# @s = 飞龙宝宝：重置冷却，从嘴里吐一颗火球
scoreboard players set @s kitpvp.bw_cd 100
# 吐之前的预警：喉咙里先亮一下、来一声吸气（不然玩家看不见它在准备）
execute at @s run particle minecraft:flame ~ ~1.4 ~ 0.1 0.1 0.1 0.01 8
execute at @s run playsound minecraft:entity.blaze.breathe hostile @a[distance=..24] ~ ~ ~ 0.8 1.3
# 朝向目标召唤：朝向决定这只火球自己的 Rotation，之后它就沿这条直线飞（见 babywhelp_ball）
execute anchored eyes facing entity @p[distance=..20,gamemode=!spectator,gamemode=!creative,tag=!kitpvp.spectator] feet positioned ^ ^ ^0.8 run summon minecraft:small_fireball ~ ~ ~ {Tags:["kitpvp.bw_ball"],NoGravity:1b,Silent:1b}
execute at @s run playsound minecraft:entity.blaze.shoot hostile @a[distance=..24] ~ ~ ~ 0.9 1.1
