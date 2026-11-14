# 跳跳虎：队长每 5 秒召出来的 5 血骷髅（场上同一时间只能有一只，见 captain_tick）
# 头是 minecraft-heads #14437 的跳跳虎（mcheads 镜像 humanoid/xkdj，皮肤 5a6256ff…）
summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.cap_tiger"],CustomName:'{"text":"跳跳虎","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:5.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:5.0}],HandItems:[{id:"minecraft:bow",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:player_head",Count:1b,tag:{SkullOwner:{Id:[I;-2006578585,-714847409,-2112399659,1106472229],Properties:{textures:[{Value:"eyJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNWE2MjU2ZmM2ODJiMmQzNzU4NzdhOTA2Yjc4NDJiYmI3MTU5NGYyYWYxMmViZTZiYWI4YzE1MmY0MTVhIn19fQ=="}]}}}}]}
# 认召唤者：@s 是队长，它身上记着 earth_owner（玩家的 1..6 队槽）。先把分数补零，免得没归属时 operation 留旧值
scoreboard players add @s kitpvp.earth_owner 0
scoreboard players operation @e[tag=kitpvp.cap_tiger,distance=..6] kitpvp.earth_owner = @s kitpvp.earth_owner
# 进同一队 ⇒ 原版就判定"自己人"，跳跳虎的箭不会落在召唤者身上
execute if score @s kitpvp.earth_owner matches 1 run team join earth_1 @e[tag=kitpvp.cap_tiger,distance=..6]
execute if score @s kitpvp.earth_owner matches 2 run team join earth_2 @e[tag=kitpvp.cap_tiger,distance=..6]
execute if score @s kitpvp.earth_owner matches 3 run team join earth_3 @e[tag=kitpvp.cap_tiger,distance=..6]
execute if score @s kitpvp.earth_owner matches 4 run team join earth_4 @e[tag=kitpvp.cap_tiger,distance=..6]
execute if score @s kitpvp.earth_owner matches 5 run team join earth_5 @e[tag=kitpvp.cap_tiger,distance=..6]
execute if score @s kitpvp.earth_owner matches 6 run team join earth_6 @e[tag=kitpvp.cap_tiger,distance=..6]
# 跳跃提升 V（amplifier 4）：一蹦三层楼，跳着追人
effect give @e[tag=kitpvp.cap_tiger] minecraft:jump_boost infinite 4 true
