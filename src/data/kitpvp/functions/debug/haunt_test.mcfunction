# 试验：恼鬼（vex，持绳方，会飞会冲脸）+ 无重力凋零骷髅（被拴方，飘在它底下 1.8 格）
# 用法：站在空旷处执行 /function kitpvp:debug/haunt_test
# 清理：/kill @e[tag=kitpvp.debug_vex_holder] 与 /kill @e[tag=kitpvp.debug_vex_leashed]
kill @e[tag=kitpvp.debug_vex_holder]
kill @e[tag=kitpvp.debug_vex_leashed]
# Life:0 ⇒ 不进入"60 秒后消散"的倒计时（唤魔者召的恼鬼才带正数 Life）
summon minecraft:vex ~ ~1 ~ {UUID:[I;1900005,1,1,1],Tags:["kitpvp.debug_vex_holder"],CustomName:'{"text":"恼鬼","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Life:0,Health:14.0f}
schedule function kitpvp:debug/haunt_test_b 1t replace
tellraw @s [{"text":"[试验] 恼鬼已生成，下一帧在它头顶挂一只无重力凋零骷髅。","color":"yellow"}]
