# @s = 滑冰者本体（at 它身上）：在脚下那格铺细雪，永久保留
# ★ 不挂 marker、不进 earth_snow 计时：谁都不会来收回它（想改回"会化"的雪痕，改用 skill/earth/snow_place）
# ★ 只在脚下是空气时铺（air / cave_air / void_air 三个 id 逐个点名 —— 整个仓库没有可信的方块标签先例），
#   所以不会吃掉地形和地图装饰
# 下一格雪 20 刻（1 秒）后再铺；本体是 stray（在 freeze_immune_entity_types 里），自己站在细雪里不掉血
# 清场靠地图复原（map/*/restore 的 place template），reset 不会逐格扫空气
execute at @s if block ~ ~ ~ minecraft:air run setblock ~ ~ ~ minecraft:powder_snow
execute at @s if block ~ ~ ~ minecraft:cave_air run setblock ~ ~ ~ minecraft:powder_snow
execute at @s if block ~ ~ ~ minecraft:void_air run setblock ~ ~ ~ minecraft:powder_snow
scoreboard players set @s kitpvp.earth_cd_a 20
