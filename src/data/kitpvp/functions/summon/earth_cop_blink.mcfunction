# 地球·40 交警（闪现版）：面板与第 37 只"交警·查车"一致 —— 磁石头头、双手末地烛、常驻速度 III
# 区别有两点：① 不坐矿车（它要自己寻路追人，坐车就动不了）；② 谁跑得比 v 快就瞬移到谁脸前
# 速度分由 skill/earth/cop_blink_track 每刻算好（格/刻 x100），判定与闪现都在 skill/earth/cop_blink_jaunt
# 阈值 v 就写在 cop_blink_jaunt 的 scores={kitpvp.pspd=35..} 里：35 = 0.35 格/刻（≈7 格/秒，疾跑跳跃就够）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_cop_blink"],CustomName:'{"text":"交警","color":"yellow"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,HandItems:[{id:"minecraft:end_rod",Count:1b},{id:"minecraft:end_rod",Count:1b}],ArmorItems:[{},{},{},{id:"minecraft:lodestone",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_cop_blink] kitpvp.earth_cd_a 1
effect give @e[tag=kitpvp.earth_cop_blink] minecraft:speed infinite 2 true