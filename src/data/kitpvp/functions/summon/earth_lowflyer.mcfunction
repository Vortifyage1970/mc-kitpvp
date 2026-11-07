# 地球·73 低空飞行器：蝙蝠吊着骷髅弓箭手在头顶十来格盘旋，每 10 秒往下扑一次；骷髅死则蝙蝠同死
# 和 69 号飞行器同一套骨架，只是"吊车"从幻翼换成蝙蝠、巡航高度从 22 格压到 10 格、俯冲从 50 格压到 14 格
# 分两帧召：同一帧召出的实体不在 UUID 索引里，Leash 会被静默丢弃
# 场上一对（UUID 写死给 Leash 用），所以先清掉上一对
# ★ kill 只是标记：蝙蝠要播完死亡动画才真的消失，这期间它的 UUID 还占着，再 summon 同一个 UUID 会被静默丢掉。
#   所以这里只负责清场 + 留一个 marker 记住位置，真正的召唤与重试都在下一刻的 earth_lowflyer_a（最多试 3 秒）
kill @e[tag=kitpvp.earth_lowflyer_carrier]
kill @e[tag=kitpvp.earth_lowflyer_body]
kill @e[tag=kitpvp.lf_anchor]
summon minecraft:marker ~ ~10 ~ {Tags:["kitpvp.lf_anchor"]}
scoreboard players set #lf_wait kitpvp.game 60
schedule function kitpvp:summon/earth_lowflyer_a 1t replace
