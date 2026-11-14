# [测试] 铁人探针：数场上铁人、看最近一只的冷却、数 8 格内的小炸弹残留
scoreboard players set #im_n kitpvp.game 0
execute as @e[tag=kitpvp.earth_ironman] run scoreboard players add #im_n kitpvp.game 1
tellraw @a [{"text":"[铁人探针] 场上铁人数量：","color":"aqua"},{"score":{"name":"#im_n","objective":"kitpvp.game"},"color":"yellow"}]
execute as @e[tag=kitpvp.earth_ironman,limit=1,sort=nearest] run tellraw @a [{"text":"[铁人探针] 最近这只剩余冷却（0 = 这一帧就该炸）：","color":"aqua"},{"score":{"name":"@s","objective":"kitpvp.im_cd"},"color":"yellow"}]
scoreboard players set #im_b kitpvp.game 0
execute as @e[tag=kitpvp.bomb_small,distance=..8] run scoreboard players add #im_b kitpvp.game 1
tellraw @a [{"text":"[铁人探针] 8 格内小炸弹（正常应该一直是 0，因为它立爆）：","color":"gray"},{"score":{"name":"#im_b","objective":"kitpvp.game"},"color":"gray"}]
