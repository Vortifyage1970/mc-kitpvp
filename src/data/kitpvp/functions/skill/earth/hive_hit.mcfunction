# @s = 刚挨了一下打的那只蜂巢（tick 用 nbt={HurtTime:9s} 抓的一帧，一箭/一刀只算一次）
# 第 1 下 → 周围每人 1 个；第 2 下 → 每人 2 个；第 3 下及以后 → 每次每人 3 个
scoreboard players add @s kitpvp.hive_hits 1
# 主人的编号：先补 0 再抄（手动 /function 召的蜂巢没有 earth_owner 分，直接 operation 会留上一只的旧值）
scoreboard players add @s kitpvp.earth_owner 0
scoreboard players operation #hive_own kitpvp.game = @s kitpvp.earth_owner
# 把召唤者打成临时 tag：选择器里没法直接比"玩家 etid 和蜂巢 owner"，只能先挂标记再排除
tag @a remove kitpvp.hive_exempt
execute if score #hive_own kitpvp.game matches 1.. as @a if score @s kitpvp.etid = #hive_own kitpvp.game run tag @s add kitpvp.hive_exempt
# 同一个选择器重复三次，配合 matches 门槛凑出 1 / 2 / 3 个
# 排除：召唤者（hive_exempt）、创造、旁观（两种观战口径）、尸体
execute if score @s kitpvp.hive_hits matches 1.. as @a[distance=..8,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,tag=!kitpvp.hive_exempt,nbt=!{Health:0.0f}] at @s run function kitpvp:skill/earth/hive_give
execute if score @s kitpvp.hive_hits matches 2.. as @a[distance=..8,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,tag=!kitpvp.hive_exempt,nbt=!{Health:0.0f}] at @s run function kitpvp:skill/earth/hive_give
execute if score @s kitpvp.hive_hits matches 3.. as @a[distance=..8,gamemode=!creative,gamemode=!spectator,tag=!kitpvp.spectator,tag=!kitpvp.hive_exempt,nbt=!{Health:0.0f}] at @s run function kitpvp:skill/earth/hive_give
tag @a remove kitpvp.hive_exempt
