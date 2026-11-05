# @s = 命中点（由 execute at @p 进来）：半径 2.5 内所有活人吃 14 点魔法伤害（magic 不吃护甲）
# 召唤者不算：跟有主/无主无关，炮弹不砸自己人（手动召的没有主，这条自然不命中任何人）
execute as @a[distance=..2.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #spk_owner kitpvp.game run damage @s 14 minecraft:magic
particle minecraft:electric_spark ~ ~1 ~ 1.2 1.2 1.2 0.2 40 normal
particle minecraft:end_rod ~ ~1 ~ 1.6 1.4 1.6 0.12 18 normal
particle minecraft:flash ~ ~1 ~ 0 0 0 0 1 normal
playsound minecraft:entity.lightning_bolt.impact master @a[distance=..32] ~ ~ ~ 1.0 0.9
