# ===== 生成攻击僵尸（持铁剑） =====
# HandItems: [主手, 副手]，HandDropChances 设为 0 掉率

execute at @s run summon minecraft:zombie ~ ~ ~3 {Tags:["kitpvp.debug_mob"],CustomName:'{"text":"调试僵尸","color":"red"}',CustomNameVisible:1b,PersistenceRequired:1b,HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],HandDropChances:[0.0f,0.0f]}
tellraw @s [{"text":"[调试] 已生成攻击僵尸","color":"green"}]