# 地球·75 凤凰：红珊瑚块头 + 金剑僵尸，第一形态 20 血；倒下留一颗「凤凰蛋」，10 秒后原地复活一次（第二形态 10 血）
# 不打召唤者靠队伍：link 把玩家和 earth_minion_new 放进同一队 earth_N，原版 AI 会跳过队友
# 一对凤凰一个配对号（kitpvp.phx_pair）：同时有好几只时，守卫/蛋/本体不会串台
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_phoenix"],CustomName:'{"text":"凤凰","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{id:"minecraft:golden_sword",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:fire_coral_block",Count:1b}]}
# 给这只本体发配对号，并召一个跟它同号的隐形守卫（守卫每刻跟着它，本体倒下时停在死亡位置）
execute as @e[tag=kitpvp.earth_phoenix,tag=kitpvp.earth_minion_new] at @s run function kitpvp:summon/earth_phoenix_pair
