# 地球·76 酿造台：头戴灵魂沙的僵尸，手里攥着附魔地狱疣，会走动、会打人
# 每 15 秒在脚边丢一瓶随机喷溅药水，药水落到地上就自己炸开（不停留、不能捡）
# 五种：力量 I / 速度 I / 瞬间伤害 I / 反胃 I / 抗性提升 I，效果持续 15 秒
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_brewer"],CustomName:'{"text":"酿造台","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,Silent:1b,CanPickUpLoot:0b,ArmorItems:[{},{},{},{id:"minecraft:soul_sand",Count:1b}],HandItems:[{id:"minecraft:nether_wart",Count:1b,tag:{Enchantments:[{id:"minecraft:unbreaking",lvl:1s}]}},{}]}
# 15 秒 = 300 刻（tick.mcfunction:258 统一往下减）
scoreboard players set @e[tag=kitpvp.earth_brewer] kitpvp.earth_cd_a 200
