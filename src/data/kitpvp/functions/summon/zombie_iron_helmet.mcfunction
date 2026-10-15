# 测试用召唤物：戴铁头盔的僵尸（护甲 2；戴着头盔就不会日晒着火）。
# 位置 = 调用者脚下；想放远一点：/execute positioned ^3 ^ ^ run function kitpvp:summon/zombie_iron_helmet
# 装备带 Unbreakable：反复测也不会把护甲磨没。清理见 game/reset 的 tag kitpvp.test_dummy
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.test_dummy"],CustomName:'{"text":"铁头盔僵尸","color":"gray"}',CustomNameVisible:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,ArmorItems:[{},{},{},{id:"minecraft:iron_helmet",Count:1b,tag:{Unbreakable:1b}}]}
