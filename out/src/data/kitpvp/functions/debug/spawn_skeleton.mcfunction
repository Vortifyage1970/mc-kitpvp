# ===== 生成攻击骷髅（持弓） =====

execute at @s run summon minecraft:skeleton ~ ~ ~3 {Tags:["kitpvp.debug_mob"],CustomName:'{"text":"调试骷髅","color":"red"}',CustomNameVisible:1b,PersistenceRequired:1b,HandItems:[{id:"minecraft:bow",Count:1b},{}],HandDropChances:[0.0f,0.0f]}
tellraw @s [{"text":"[调试] 已生成攻击骷髅","color":"green"}]
