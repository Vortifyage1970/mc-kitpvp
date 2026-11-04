# 地球·34 大蜜蜂：一只没有巢的蜜蜂，存在期间给半径 10 格内的所有玩家和生物持续挖掘疲劳 III
# 蜂类不设 HivePos 也能飞（只是会一直试图回家，原地打转），CannotEnterHiveTicks 拉满避免它钻巢
# 注意：真蜇到人会走原版 BEE_STING 逻辑，20 刻后自己死掉 —— 这一点 NBT 关不掉，只能靠仇恨值避免
summon minecraft:bee ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_bigbee"],CustomName:'{"text":"大蜜蜂","color":"yellow"}',CustomNameVisible:1b,PersistenceRequired:1b,Health:10.0f,CannotEnterHiveTicks:999999,AngerTime:0,Attributes:[{Name:"minecraft:generic.max_health",Base:10.0}]}
# 光环改成 tick 里每刻直接跑（tag 判定，不再用 earth_cd_a 节流），所以这里不需要给计时器初值
