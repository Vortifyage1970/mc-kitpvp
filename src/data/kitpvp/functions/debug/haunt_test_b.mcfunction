# 由 haunt_test 排程调用（1 刻后）：锚在蝙蝠身上，不依赖玩家坐标
execute at @e[tag=kitpvp.debug_bat_holder,limit=1,sort=nearest] run summon minecraft:skeleton ~ ~-1.5 ~ {UUID:[I;1900006,2,1,1],Tags:["kitpvp.debug_bat_leashed"],Leash:{UUID:[I;1900006,1,1,1]},Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,CustomName:'{"text":"骷髅弓箭手","color":"gray"}',CustomNameVisible:1b,HandItems:[{id:"minecraft:bow",Count:1b},{}]}
execute at @e[tag=kitpvp.debug_bat_holder,limit=1,sort=nearest] run tellraw @a [{"text":"[试验] 骷髅弓箭手已拴在蝙蝠身上（Leash 指向蝙蝠 UUID）。","color":"gray"}]
