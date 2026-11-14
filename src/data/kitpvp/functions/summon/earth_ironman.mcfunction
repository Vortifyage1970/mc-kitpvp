# 地球·75 铁人：标准僵尸（原版 AI、原版数值）+ 外观 + 附魔
# 附魔：三件皮革各爆炸保护 V，靴子另加摔落保护 V（炸弹是真爆炸，他自己就站在爆点旁一格）
# 没有任何状态效果与属性改写（无 weakness / 无 resistance / 无 Attributes）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_ironman"],CustomName:'{"text":"铁人","color":"aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,HandItems:[{},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:14721056},Enchantments:[{id:"minecraft:blast_protection",lvl:5},{id:"minecraft:feather_falling",lvl:5}]}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:12598571},Enchantments:[{id:"minecraft:blast_protection",lvl:5}]}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:12598571},Enchantments:[{id:"minecraft:blast_protection",lvl:5}]}},{id:"minecraft:iron_block",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_ironman] kitpvp.im_cd 100
