# @s = 滑冰者本体（at 它身上）：在脚下那格铺细雪，10 秒后由 tick 的 snow_clear 收回
# 只在脚下是空气时铺（air / cave_air / void_air 三个 id 逐个点名 —— 整个仓库没有可信的方块标签先例）
# 下一次 20 刻（1 秒）后再铺；本体是 stray，自己站在细雪里不会掉血
scoreboard players set #snow_time kitpvp.game 200
execute at @s if block ~ ~ ~ minecraft:air run function kitpvp:skill/earth/snow_place
execute at @s if block ~ ~ ~ minecraft:cave_air run function kitpvp:skill/earth/snow_place
execute at @s if block ~ ~ ~ minecraft:void_air run function kitpvp:skill/earth/snow_place
scoreboard players set @s kitpvp.earth_cd_a 20
