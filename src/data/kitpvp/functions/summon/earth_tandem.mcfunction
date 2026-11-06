# 地球·68 串联体 tandem：两只僵尸，头都是末影箱、手里各握一把锋利 II 的回想碎片（纯发光，不影响近战）
# ★ 同一时刻只允许存在一对：开头先 kill 掉旧的，避免随机池连出好几对导致判定互相抢
kill @e[tag=kitpvp.earth_tandem]
# 牵引：tick 里两只相距超过 4 格就把 b 拉到 a 身边（不做任何"谁离玩家近"的判断）
# 判定（每 2 秒）：两个半身轮流拿速度 II（先 a 后 b），与玩家位置无关；缓慢已整体移除
# 一只死了：另一只立刻清空效果、永久获得速度 II + 力量 I + 发光（tandem_alone）
summon minecraft:zombie ~ ~ ~ {UUID:[I;1900003,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_tandem","kitpvp.earth_tandem_a"],CustomName:'{"text":"串联体","color":"dark_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b,Health:20.0f,HandItems:[{id:"minecraft:echo_shard",Count:1b,tag:{Enchantments:[{id:"minecraft:sharpness",lvl:2}]}},{}],Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ArmorItems:[{},{},{},{id:"minecraft:ender_chest",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_tandem_a] kitpvp.earth_cd_a 40
summon minecraft:zombie ~ ~ ~-1.5 {UUID:[I;1900003,2,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_tandem","kitpvp.earth_tandem_b"],CustomName:'{"text":"串联体","color":"dark_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Silent:1b,Health:20.0f,HandItems:[{id:"minecraft:echo_shard",Count:1b,tag:{Enchantments:[{id:"minecraft:sharpness",lvl:2}]}},{}],Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ArmorItems:[{},{},{},{id:"minecraft:ender_chest",Count:1b}]}
