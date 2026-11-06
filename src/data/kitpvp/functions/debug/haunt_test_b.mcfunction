# 由 haunt_test 排程调用（1 刻后）：锚在幻翼身上，不依赖玩家坐标
execute at @e[tag=kitpvp.debug_phantom_holder,limit=1,sort=nearest] run summon minecraft:skeleton ~ ~-2 ~ {UUID:[I;1900007,2,1,1],Tags:["kitpvp.debug_phantom_leashed"],Leash:{UUID:[I;1900007,1,1,1]},NoGravity:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,CustomName:'{"text":"骷髅弓箭手","color":"gray"}',CustomNameVisible:1b,HandItems:[{id:"minecraft:bow",Count:1b},{}]}
execute at @e[tag=kitpvp.debug_phantom_holder,limit=1,sort=nearest] run tellraw @a [{"text":"[试验] 骷髅弓箭手已挂上（NoGravity + Leash 指向幻翼）。","color":"gray"}]
# 开始盯"被拴方是否还活着"：骷髅一死就把幻翼一起带走
schedule function kitpvp:debug/haunt_watch 1t replace
