# 地球·75 铁人：普通僵尸（保留原版 AI，自己会走会打，不用 tp 驱）
# 造型：皮革套染色（钢铁侠的红金配色，颜色自己选的）+ 铁块当头（方块占头盔位 ⇒ 白天不自燃，又够"铁人"）
# 附魔：三件皮革各爆炸保护 V + 靴子摔落保护 V（炸弹是真爆炸，自己要站爆点上）
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_ironman"],CustomName:'{"text":"铁人","color":"aqua"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:14721056},Enchantments:[{id:"minecraft:blast_protection",lvl:5},{id:"minecraft:feather_falling",lvl:5}]}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:12598571},Enchantments:[{id:"minecraft:blast_protection",lvl:5}]}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:12598571},Enchantments:[{id:"minecraft:blast_protection",lvl:5}]}},{id:"minecraft:iron_block",Count:1b}]}
scoreboard players set @e[tag=kitpvp.earth_ironman] kitpvp.im_cd 100
