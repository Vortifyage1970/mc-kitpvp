# ===== 生成苦力怕 =====
# 地形破坏由 gamerule mobGriefing=false 兜底

execute at @s run summon minecraft:creeper ~ ~ ~3 {Tags:["kitpvp.debug_mob"],CustomName:'{"text":"调试苦力怕","color":"red"}',CustomNameVisible:1b,PersistenceRequired:1b}
tellraw @s [{"text":"[调试] 已生成苦力怕","color":"green"}]