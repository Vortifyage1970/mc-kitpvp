# 地球·43 COSER：头戴初音未来头颅的骷髅、粉色皮革胸甲，常驻虚弱 X + 速度 III
# 打人给纸：tick 里靠玩家 HurtTime=9 那一帧 + 32 格内存在 COSER 判定（见 skill/earth/coser_paper）
# 虚弱 X 让近战几乎无伤，主要威胁是它的箭
summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_coser"],CustomName:'{"text":"COSER","color":"light_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,ArmorItems:[{},{},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:16738036}}},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:{Id:[I;0,0,0,0],Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvOGFhOWQwMjdkYzc0ZGVjZDMzMTNmZTBmNTcxYTU2NGRkMDBmZWVhNjkwY2I1YzVkNDA2NGM0MjJjNDU5ZWJkYSJ9fX0="}]}}}}]}
effect give @e[tag=kitpvp.earth_coser] minecraft:speed infinite 2 true
effect give @e[tag=kitpvp.earth_coser] minecraft:weakness infinite 9 true