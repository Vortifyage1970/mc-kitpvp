# 地球·58 资本家：头戴美国国旗的僵尸，一身纯黑皮革（当西装），死亡时掉一张「十万大刀乐」
# 大刀乐和 COSER 的「物料」是同一套做法：附魔发光 + 唯一流水号 ⇒ 永远不会叠成一堆（见 skill/earth/junk_serial）
# 死亡判定同样走脚下守卫 marker（尸体帧在 1.20.1 抓不到，木星踩过的坑）
# 头槽是方块头 ⇒ 白天不自燃
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_capitalist"],CustomName:'{"text":"资本家","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,HandItems:[{},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:0}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:0}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:0}}},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:{Id:[I;274637347,623131056,-199205630,435873489],Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvY2JiNDg2ODFhMjc5N2I1OGQ1ZDgyZjA4ZDBkMzI1OTVlYThjOTQwYzNjZjE4OTUzNzk2MzNkZmMwMTZhOGU3ZCJ9fX0="}]}}}}]}
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_capitalist_guard"]}
