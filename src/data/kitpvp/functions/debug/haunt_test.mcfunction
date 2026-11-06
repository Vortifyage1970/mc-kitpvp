# 试验：闹鬼（持绳方，僵尸 AI 会主动追人）+ 无重力凋零骷髅（被拴方，飘在头顶 1.8 格）
# 用法：站在空旷处（别站太高/别贴墙）执行 /function kitpvp:debug/haunt_test
# 清理：/kill @e[tag=kitpvp.debug_haunt_holder] 与 /kill @e[tag=kitpvp.debug_haunt_leashed]
kill @e[tag=kitpvp.debug_haunt_holder]
kill @e[tag=kitpvp.debug_haunt_leashed]
summon minecraft:zombie ~ ~ ~ {UUID:[I;1900004,1,1,1],Tags:["kitpvp.debug_haunt_holder"],CustomName:'{"text":"闹鬼","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b,Health:40.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:40.0}],HandItems:[{},{}]}
# 第二只在下一刻召：同一刻召出来的兄弟实体还不在 UUID 索引里，Leash 会被当成无效数据丢掉
schedule function kitpvp:debug/haunt_test_b 1t replace
tellraw @s [{"text":"[试验] 闹鬼已生成，下一帧挂上无重力凋零骷髅。站远点看绳子，它会在你头顶飘着射箭。","color":"yellow"}]
