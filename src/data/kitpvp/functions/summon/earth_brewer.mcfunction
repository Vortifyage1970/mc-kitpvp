# 地球·76 酿造台：头戴酿造台的僵尸，站桩不动，每 15 秒朝脚边砸一瓶随机药水
# 药水由 skill/earth/brewer_drop 摇号后丢出：力量 I / 速度 II / 瞬间伤害 I / 反胃 I / 抗性提升 I
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_brewer"],CustomName:'{"text":"酿造台","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,NoAI:1b,Silent:1b,CanPickUpLoot:0b,ArmorItems:[{},{},{},{id:"minecraft:brewing_stand",Count:1b}],HandItems:[{},{}]}
# 15 秒 = 300 刻（tick.mcfunction:258 统一往下减）
scoreboard players set @e[tag=kitpvp.earth_brewer] kitpvp.earth_cd_a 300
