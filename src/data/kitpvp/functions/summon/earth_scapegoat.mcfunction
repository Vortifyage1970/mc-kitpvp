# 地球·59 借调员工：头戴俄罗斯三色旗、一身灰西装的僵尸（三件皮革 color:1973790 = 脏灰）
# 机制就是公司那套：真出事了，把锅推给"借调来的俄罗斯员工"——而且他真的会认
# 废在哪：他只替你挨 2 点，你自己照样挂 3 秒反胃（"通报批评"）；37.5% 概率才认（4 次 1in2 拼 0..15 后 <=5）
# 每 30 秒还会主动认领一件跟自己毫无关系的事（纯聊天栏文本，没有任何效果）；死时只掉一张「解雇通知」
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_scapegoat"],CustomName:'{"text":"借调员工","color":"white"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,HandItems:[{},{}],ArmorItems:[{id:"minecraft:leather_boots",Count:1b,tag:{display:{color:1973790}}},{id:"minecraft:leather_leggings",Count:1b,tag:{display:{color:1973790}}},{id:"minecraft:leather_chestplate",Count:1b,tag:{display:{color:1973790}}},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:{Id:[I;-1833612613,1180452691,-2131754201,-1819904435],Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYzA2ZDJlMDRmZWFmMmI5MGVkODQ0NzQ0ZDFhMDJhMzc1NDEwNTA2OWUwMTExNTcyNzQwYTExYjM2ZWRkYWQ5OSJ9fX0="}]}}}}]}
summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_scapegoat_guard"]}
scoreboard players set @e[tag=kitpvp.earth_scapegoat] kitpvp.scapegoat_cd 600
