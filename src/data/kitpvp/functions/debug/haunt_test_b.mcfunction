# 由 haunt_test 排程调用（1 刻后）：锚在恼鬼身上，不依赖玩家坐标
execute at @e[tag=kitpvp.debug_vex_holder,limit=1,sort=nearest] run summon minecraft:wither_skeleton ~ ~2 ~ {UUID:[I;1900005,2,1,1],Tags:["kitpvp.debug_vex_leashed"],Leash:{UUID:[I;1900005,1,1,1]},NoGravity:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,CustomName:'{"text":"无重力凋零骷髅","color":"gray"}',CustomNameVisible:1b,HandItems:[{id:"minecraft:stone_sword",Count:1b},{}]}
execute at @e[tag=kitpvp.debug_vex_holder,limit=1,sort=nearest] run tellraw @a [{"text":"[试验] 已挂上：Leash 指向恼鬼 UUID。看它被拽着飞时的样子。","color":"gray"}]
