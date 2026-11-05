# 地球·50 隐匿者：头戴红树根的僵尸，每 5 秒朝天上放一枚黑色烟花
# 烟花本身不伤人，纯粹是"给自己报点"——放一次亮一次，谁都能顺着看过来
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_hider"],CustomName:'{"text":"隐匿者","color":"dark_gray"}',CustomNameVisible:0b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],ArmorItems:[{},{},{},{id:"minecraft:mangrove_roots",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_hider] kitpvp.earth_cd_a 100
