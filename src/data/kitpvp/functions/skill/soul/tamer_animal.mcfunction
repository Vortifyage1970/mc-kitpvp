# 召一只随机动物（狗以外）：4 次 1in2 拼 0..15 再对 9 取模
# @s = 驯兽师魂石的 marker，执行位置 = 落点；四波各四次调用 = 共 16 只
scoreboard players set #soul_n kitpvp.game 9
scoreboard players set @s kitpvp.rng 0
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 1
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 2
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 4
execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng 8
scoreboard players operation @s kitpvp.rng %= #soul_n kitpvp.game

execute if score @s kitpvp.rng matches 0 run summon minecraft:horse ~ ~ ~ {Tags:["kitpvp.soul_tamer_animal"],PersistenceRequired:1b}
execute if score @s kitpvp.rng matches 1 run summon minecraft:parrot ~ ~ ~ {Tags:["kitpvp.soul_tamer_animal"],PersistenceRequired:1b}
execute if score @s kitpvp.rng matches 2 run summon minecraft:dolphin ~ ~ ~ {Tags:["kitpvp.soul_tamer_animal"],PersistenceRequired:1b}
execute if score @s kitpvp.rng matches 3 run summon minecraft:fox ~ ~ ~ {Tags:["kitpvp.soul_tamer_animal"],PersistenceRequired:1b}
execute if score @s kitpvp.rng matches 4 run summon minecraft:frog ~ ~ ~ {Tags:["kitpvp.soul_tamer_animal"],PersistenceRequired:1b}
execute if score @s kitpvp.rng matches 5 run summon minecraft:tadpole ~ ~ ~ {Tags:["kitpvp.soul_tamer_animal"],PersistenceRequired:1b}
execute if score @s kitpvp.rng matches 6 run summon minecraft:turtle ~ ~ ~ {Tags:["kitpvp.soul_tamer_animal"],PersistenceRequired:1b}
execute if score @s kitpvp.rng matches 7 run summon minecraft:goat ~ ~ ~ {Tags:["kitpvp.soul_tamer_animal"],PersistenceRequired:1b}
execute if score @s kitpvp.rng matches 8 run summon minecraft:salmon ~ ~ ~ {Tags:["kitpvp.soul_tamer_animal"],PersistenceRequired:1b}
