# 把属于自己的舔狗直接拉到当前位置：大厅到地图是一次跨区块传送，
# 原版"距离超过 12 格自动跟随"要求狼所在的区块还在 tick，传送后不保证
# 调用方需 `as 玩家 at 玩家`（本函数用 ~ ~ ~ 取调用位置）
scoreboard players operation #vtid kitpvp.game = @s kitpvp.vtid
execute as @e[type=minecraft:wolf,tag=kitpvp.venus_dog] if score @s kitpvp.dog_owner = #vtid kitpvp.game run tp @s ~ ~ ~
