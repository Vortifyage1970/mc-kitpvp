# 把属于自己的舔狗拉到主身边：大厅到地图、死亡重生都是跨区块传送，
# 原版"距离超过 12 格自动跟随"要求狼所在的区块还在 tick，传送后不保证
# tick 每刻调用一次：狗始终待在主人所在区块，才不会出现"看不见→误判丢了→又召一只"（见 04 §十四）
# 调用方需 `as 玩家 at 玩家`（本函数用 ~ ~ ~ 取调用位置）；只拉 12 格外的，免得贴在身上抖
scoreboard players operation #vtid kitpvp.game = @s kitpvp.vtid
execute as @e[type=minecraft:wolf,tag=kitpvp.venus_dog,distance=12..] if score @s kitpvp.dog_owner = #vtid kitpvp.game run tp @s ~ ~ ~
