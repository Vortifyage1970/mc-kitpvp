# 地球·43 COSER：头戴初音未来头颅的骷髅，粉色皮革胸甲、裤子、鞋子，常驻速度 II
# 打人给纸：tick 里靠玩家 HurtTime=9 那一帧 + 32 格内存在 COSER 判定（见 skill/earth/coser_paper）
# 伤害压到 1 点：generic.attack_damage 改成 1.0；双手空着不给弓（不给弓它就没有远程手段）
summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_coser"],CustomName:'{"text":"COSER","color":"light_purple"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:10.0f,Attributes:[{Name:"minecraft:generic.attack_damage",Base:1.0},{Name:"minecraft:generic.max_health",Base:10.0}],HandItems:[{},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:16738036}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:16738036}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:16738036}}},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:{Id:[I;0,0,0,0],Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvOGFhOWQwMjdkYzc0ZGVjZDMzMTNmZTBmNTcxYTU2NGRkMDBmZWVhNjkwY2I1YzVkNDA2NGM0MjJjNDU5ZWJkYSJ9fX0="}]}}}}]}
effect give @e[tag=kitpvp.earth_coser] minecraft:speed infinite 1 true
# 猫叫计时（4 秒叫一声；分数不存在的话 scores={..0} 选择器不匹配，会一直不叫）
scoreboard players set @e[tag=kitpvp.earth_coser] kitpvp.earth_cd_a 80
