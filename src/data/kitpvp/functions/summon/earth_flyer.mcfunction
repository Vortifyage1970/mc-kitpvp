# 地球·69 飞行器：幻翼吊着骷髅弓箭手盘旋，每 10 秒俯冲 50 格；骷髅死则幻翼同死
# 分两帧召：同一帧召出的实体不在 UUID 索引里，Leash 会被静默丢弃
# 场上一对（UUID 写死给 Leash 用），所以先清掉上一对
# ★ 同一刻 kill + summon 同一个写死 UUID 会被 addFreshEntity 静默拒绝（老实体要到刻末才真的消失），
#   表现为"第一次按只会清场、要按第二次才召得出来"。所以这里只 kill 并在原位放一个 1 刻的 marker 记住位置，
#   真正召唤挪到下一刻的 earth_flyer_a。
kill @e[tag=kitpvp.earth_flyer_carrier]
kill @e[tag=kitpvp.earth_flyer_body]
kill @e[tag=kitpvp.fl_anchor]
summon minecraft:marker ~ ~22 ~ {Tags:["kitpvp.fl_anchor"]}
schedule function kitpvp:summon/earth_flyer_a 1t replace
