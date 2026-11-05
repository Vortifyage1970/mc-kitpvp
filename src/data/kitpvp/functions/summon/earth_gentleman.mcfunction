# 地球·32 绅士：被召唤时把天气调成雨，头戴英国国旗、全身黑色皮革甲、手里拿本书的僵尸
# 雨下 15 秒：load 关了 doWeatherCycle（load.mcfunction:6），weather 的时长不会自己走完，
# 所以除了 weather rain 15 之外，还要排一个 300 刻后的 weather clear 兜底（见 summon/earth_gentleman_rain_end）
# 同一只雨伞只能排一个任务（schedule ... replace 按函数名去重）：连着召两只，雨会从后一只算满 15 秒
weather rain 15
schedule function kitpvp:summon/earth_gentleman_rain_end 300t replace
# 黑色皮甲 = display:{color:0}（RGB 整数）；ArmorItems 顺序是 [靴子, 护腿, 胸甲, 头盔]
# 手上的书用普通 minecraft:book，右键能翻但不会掉页
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_gentleman"],CustomName:'{"text":"绅士","color":"white"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,HandItems:[{id:"minecraft:book",Count:1b},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:0}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:0}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:0}}},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:{Id:[I;0,0,0,0],Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvODgzMWM3M2Y1NDY4ZTg4OGMzMDE5ZTI4NDdlNDQyZGZhYTg4ODk4ZDUwY2NmMDFmZDJmOTE0YWY1NDRkNTM2OCJ9fX0="}]}}}}]}
