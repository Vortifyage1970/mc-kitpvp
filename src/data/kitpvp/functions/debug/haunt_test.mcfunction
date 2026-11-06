# 试验：幻翼（持绳方，夜里高空盘旋、会俯冲）+ 无重力骷髅弓箭手（被拴方，悬空跟着）
# 用法：站在空旷处执行 /function kitpvp:debug/haunt_test
# 清理：/kill @e[tag=kitpvp.debug_phantom_holder] 与 /kill @e[tag=kitpvp.debug_phantom_leashed]
kill @e[tag=kitpvp.debug_phantom_holder]
kill @e[tag=kitpvp.debug_phantom_leashed]
# ★ 幻翼白天会烧（原版特性，没有 NBT 开关）⇒ 测试请先 /time set night 或关掉日光循环
# Size:0..4 越大 hitbox 越大；这里给 1（中等），不然它会被自己的碰撞箱卡住
summon minecraft:phantom ~ ~5 ~ {UUID:[I;1900007,1,1,1],Tags:["kitpvp.debug_phantom_holder"],Size:1,CustomName:'{"text":"幻翼","color":"dark_aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b}
schedule function kitpvp:debug/haunt_test_b 1t replace
tellraw @s [{"text":"[试验] 幻翼已生成（在你上方 5 格）。白天它会自燃——先 /time set night。","color":"yellow"}]
