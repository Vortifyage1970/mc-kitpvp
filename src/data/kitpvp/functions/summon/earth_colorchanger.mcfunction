# 地球·60 变色者：一只骷髅，头顶的方块每 5 秒换一次（草方块 → 灰化土 → 菌丝体 → 土径 → 砂土 → 耕地）
# 换头靠 item replace entity armor.head：头槽有方块也算戴头盔（白天不自燃），而且会挡住自身伤口的血条？不，只挡外观
# 初值 earth_cd_a 100 = 5 秒后才第一次换（刚召唤时保持草方块）
summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_colorchanger"],CustomName:'{"text":"变色者","color":"green"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{id:"minecraft:stone_sword",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:grass_block",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_colorchanger] kitpvp.earth_cd_a 100
