# 地球·67 多肽_β转角：竖链 = 9 只独立实体（每刻被 tp 叠成一根柱子），底座那颗氨基酸再拴 5 节尾巴
# ★ 不用 Passengers 嵌套：原版把乘客叠在载具同一坐标上，9 层挤成一坨看不出"竖直"；改成分刻召唤 + 每刻 tp 定位
# ★ 每只都 NoAI：位置由 tick 决定，自己的 AI 只会跟 tp 抢
kill @e[tag=kitpvp.earth_polypeptide_betaturn]
kill @e[tag=kitpvp.earth_polypeptide_betaturn_rope]
summon minecraft:zombie ~ ~ ~ {id:"minecraft:zombie",UUID:[I;1900002,1,1,1],Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_polypeptide_betaturn","kitpvp.earth_polypeptide_betaturn_node1"],Silent:1b,NoAI:1b,Health:5.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:5.0}],ArmorItems:[{},{},{},{id:"minecraft:smooth_stone",Count:1b}],CustomName:'{"text":"氨基酸","color":"green"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b}
schedule function kitpvp:summon/earth_polypeptide_betaturn_node2 1t replace
schedule function kitpvp:summon/earth_polypeptide_betaturn_tail1 2t replace
