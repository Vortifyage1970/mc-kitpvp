# 试验：蝙蝠（持绳方，会飞、到处乱撞，但不打人）+ 骷髅弓箭手（被拴方，会被拽着走）
# 用法：站在空旷处执行 /function kitpvp:debug/haunt_test
# 清理：/kill @e[tag=kitpvp.debug_bat_holder] 与 /kill @e[tag=kitpvp.debug_bat_leashed]
kill @e[tag=kitpvp.debug_bat_holder]
kill @e[tag=kitpvp.debug_bat_leashed]
# 蝙蝠平时倒挂/飞行切换靠 AI，不写额外 NBT；给它一个固定 UUID 方便下一帧被 Leash 指向
summon minecraft:bat ~ ~2 ~ {UUID:[I;1900006,1,1,1],Tags:["kitpvp.debug_bat_holder"],CustomName:'{"text":"蝙蝠","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b}
schedule function kitpvp:debug/haunt_test_b 1t replace
tellraw @s [{"text":"[试验] 蝙蝠已生成，下一帧把骷髅弓箭手拴给它。","color":"yellow"}]
