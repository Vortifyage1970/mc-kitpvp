# 由 haunt_test 排程调用（1 刻后）：位置锚在闹鬼身上，所以不依赖玩家坐标
execute at @e[tag=kitpvp.debug_haunt_holder,limit=1,sort=nearest] run summon minecraft:wither_skeleton ~ ~1.8 ~ {UUID:[I;1900004,2,1,1],Tags:["kitpvp.debug_haunt_leashed"],Leash:{UUID:[I;1900004,1,1,1]},NoGravity:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,CustomName:'{"text":"无重力凋零骷髅","color":"gray"}',CustomNameVisible:1b,HandItems:[{id:"minecraft:stone_sword",Count:1b},{}]}
execute at @e[tag=kitpvp.debug_haunt_holder,limit=1,sort=nearest] run tellraw @a [{"text":"[试验] 无重力凋零骷髅已挂在闹鬼头顶 1.8 格，Leash 指向闹鬼的 UUID。","color":"gray"}]
