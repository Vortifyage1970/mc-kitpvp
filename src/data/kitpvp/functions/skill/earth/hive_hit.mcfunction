# @s = 刚挨了一下打的那只蜂巢（tick 用 nbt={HurtTime:9s} 抓的一帧，一箭/一刀只算一次）
# 第 1 下 → 周围每人 1 个；第 2 下 → 每人 2 个；第 3 下及以后 → 每次每人 3 个
scoreboard players add @s kitpvp.hive_hits 1
# 同一个选择器重复三次，配合 matches 门槛凑出 1 / 2 / 3 个
execute if score @s kitpvp.hive_hits matches 1.. as @a[distance=..8,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s run function kitpvp:skill/earth/hive_give
execute if score @s kitpvp.hive_hits matches 2.. as @a[distance=..8,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s run function kitpvp:skill/earth/hive_give
execute if score @s kitpvp.hive_hits matches 3.. as @a[distance=..8,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s run function kitpvp:skill/earth/hive_give
