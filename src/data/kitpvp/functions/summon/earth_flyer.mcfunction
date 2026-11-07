# 地球·69 飞行器：幻翼吊着骷髅弓箭手盘旋，每 10 秒俯冲 50 格；骷髅死则幻翼同死
# 分两帧召：同一帧召出的实体不在 UUID 索引里，Leash 会被静默丢弃
# 场上一对（UUID 写死给 Leash 用），所以先清掉上一对
# ★ kill 只是标记：幻翼要播完死亡动画（约 20 刻）才真的消失，这期间它的 UUID 还占着，
#   再 summon 同一个 UUID 会被 addFreshEntity 静默丢掉。所以这里只负责清场 + 留一个 marker 记住位置，
#   真正的召唤与重试都在下一刻的 earth_flyer_a（它会一直试到 UUID 空出来，最多 3 秒）。
kill @e[tag=kitpvp.earth_flyer_carrier]
kill @e[tag=kitpvp.earth_flyer_body]
kill @e[tag=kitpvp.fl_anchor]
summon minecraft:marker ~ ~22 ~ {Tags:["kitpvp.fl_anchor"]}
scoreboard players set #fl_wait kitpvp.game 60
schedule function kitpvp:summon/earth_flyer_a 1t replace
