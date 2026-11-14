# 随机把刚刷的生灵替换成地球召唤池里的生物（简版：僵尸/骷髅/蜘蛛/苦力怕/羊/猪 六选一）
scoreboard players set #mars_pick kitpvp.game 0
execute if predicate kitpvp:random/1in2 run scoreboard players add #mars_pick kitpvp.game 1
execute if predicate kitpvp:random/1in2 run scoreboard players add #mars_pick kitpvp.game 2
execute if predicate kitpvp:random/1in2 run scoreboard players add #mars_pick kitpvp.game 4
scoreboard players set #mars_pick_max kitpvp.game 6
scoreboard players operation #mars_pick kitpvp.game %= #mars_pick_max kitpvp.game
execute if score #mars_pick kitpvp.game matches 0 run summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.mars_wild"],PersistenceRequired:1b}
execute if score #mars_pick kitpvp.game matches 1 run summon minecraft:spider ~ ~ ~ {Tags:["kitpvp.mars_wild"],PersistenceRequired:1b}
execute if score #mars_pick kitpvp.game matches 2 run summon minecraft:creeper ~ ~ ~ {Tags:["kitpvp.mars_wild"],PersistenceRequired:1b}
execute if score #mars_pick kitpvp.game matches 3 run summon minecraft:sheep ~ ~ ~ {Tags:["kitpvp.mars_wild"],PersistenceRequired:1b}
execute if score #mars_pick kitpvp.game matches 4 run summon minecraft:pig ~ ~ ~ {Tags:["kitpvp.mars_wild"],PersistenceRequired:1b}
execute if score #mars_pick kitpvp.game matches 5 run summon minecraft:cow ~ ~ ~ {Tags:["kitpvp.mars_wild"],PersistenceRequired:1b}
