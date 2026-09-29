# ===== 生成假人靶子（无 AI 僵尸） =====
# 站在 @s 朝向 3 格外；静音、无 AI、可被打、不掉装备

execute at @s run summon minecraft:zombie ~ ~ ~3 {Tags:["kitpvp.debug_mob"],CustomName:'{"text":"调试靶子","color":"gray","italic":true}',CustomNameVisible:1b,Silent:1b,NoAI:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{},{}],ArmorItems:[{},{},{},{}]}
tellraw @s [{"text":"[调试] 已生成假人靶子","color":"green"}]