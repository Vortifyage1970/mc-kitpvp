# 地球·40 追猎者：普通僵尸（会自己寻路追人），谁跑得快就瞬移到谁脸前
# 速度分由 skill/earth/stalker_track 每刻算好（格/刻 x100），判定与闪现都在 skill/earth/stalker_blink
# 阈值 v 就写在 stalker_blink 的 scores={kitpvp.pspd=35..} 里：35 = 0.35 格/刻（≈7 格/秒，疾跑跳跃就够）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_stalker"],CustomName:'{"text":"追猎者","color":"red"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{id:"minecraft:iron_sword",Count:1b},{}]}
scoreboard players set @e[tag=kitpvp.earth_stalker] kitpvp.earth_cd_a 1