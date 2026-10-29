# 地球·4 Sheepass：普通羊，每 10 秒给 20 格内玩家 20 秒反胃（效果在 tick 里跑）
summon minecraft:sheep ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_sheep"],CustomName:'{"text":"Sheepass","color":"white"}',CustomNameVisible:1b,PersistenceRequired:1b}
scoreboard players set @e[tag=kitpvp.earth_minion_new] kitpvp.earth_cd_a 200
