# 地球·11 跟踪炸弹：隐形小僵尸骑着已点燃的苦力怕（6 秒后爆，正常爆炸半径）
# 小僵尸 6 秒后由 tick 清除（earth_life 120）；苦力怕的引信与是否被骑无关，照常倒计时
summon minecraft:creeper ~ ~ ~ {Tags:["kitpvp.earth_bomb"],ignited:1b,Fuse:120s,ExplosionRadius:3b,Passengers:[{id:"minecraft:zombie",Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_tracker"],CustomName:'{"text":"跟踪炸弹","color":"dark_red"}',CustomNameVisible:1b,IsBaby:1b,Invisible:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b}]}
scoreboard players set @e[tag=kitpvp.earth_minion_new] kitpvp.earth_life 120
