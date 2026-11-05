# 地球·53 金星：一只白色的雪狐（Type:1b = snow），走到哪冷到哪
# 效果直接复用金星职业的"制冷模块"：10 格内不是召唤者的玩家累积 coldness（0..100），按档位给缓慢 I~V
# 冷度的加减/上限/上药全在 tick 的通用段（kitpvp.venus_chilled / kitpvp.coldness），这里只负责打标记
# 不限时：舔狗那套是"放 10 秒"，这只狐狸活着就一直冷（它没有计时器，也没有 earth_cd_a）
summon minecraft:fox ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_venus"],Type:1b,CustomName:'{"text":"金星","color":"light_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Sitting:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}]}
