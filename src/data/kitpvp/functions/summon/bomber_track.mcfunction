# 跟踪炸弹：同地球召唤物——隐形小僵尸骑着已点燃的苦力怕（6 秒后爆，半径 3）
# 苦力怕被提前打死时骑手会掉下来，所以给它 120 刻寿命，由 tick 的 bomb_life 清掉
summon minecraft:creeper ~ ~ ~ {Tags:["kitpvp.bomb","kitpvp.bomb_track","kitpvp.bomb_track_new"],CustomName:'{"text":"跟踪炸弹","color":"dark_red"}',CustomNameVisible:1b,ignited:1b,Fuse:120s,ExplosionRadius:3b,Attributes:[{Name:"minecraft:generic.movement_speed",Base:0.40}],Passengers:[{id:"minecraft:zombie",Tags:["kitpvp.bomb_rider","kitpvp.bomb_rider_new","kitpvp.bomb_track_new"],CustomName:'{"text":"跟踪炸弹","color":"dark_red"}',CustomNameVisible:0b,IsBaby:1b,Invisible:1b,Silent:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Attributes:[{Name:"minecraft:generic.movement_speed",Base:0.40}]}]}

# 归属：同地球 / 驯兽师，玩家与召唤物同队才不会互相攻击
scoreboard players add @s kitpvp.btid 0
execute if score @s kitpvp.btid matches 0 run scoreboard players add #btid kitpvp.game 1
execute if score @s kitpvp.btid matches 0 if score #btid kitpvp.game matches 7.. run scoreboard players set #btid kitpvp.game 1
execute if score @s kitpvp.btid matches 0 run scoreboard players operation @s kitpvp.btid = #btid kitpvp.game

execute if score @s kitpvp.btid matches 1 run team join bomb_1 @s
execute if score @s kitpvp.btid matches 2 run team join bomb_2 @s
execute if score @s kitpvp.btid matches 3 run team join bomb_3 @s
execute if score @s kitpvp.btid matches 4 run team join bomb_4 @s
execute if score @s kitpvp.btid matches 5 run team join bomb_5 @s
execute if score @s kitpvp.btid matches 6 run team join bomb_6 @s

execute if score @s kitpvp.btid matches 1 run team join bomb_1 @e[tag=kitpvp.bomb_track_new,distance=..4]
execute if score @s kitpvp.btid matches 2 run team join bomb_2 @e[tag=kitpvp.bomb_track_new,distance=..4]
execute if score @s kitpvp.btid matches 3 run team join bomb_3 @e[tag=kitpvp.bomb_track_new,distance=..4]
execute if score @s kitpvp.btid matches 4 run team join bomb_4 @e[tag=kitpvp.bomb_track_new,distance=..4]
execute if score @s kitpvp.btid matches 5 run team join bomb_5 @e[tag=kitpvp.bomb_track_new,distance=..4]
execute if score @s kitpvp.btid matches 6 run team join bomb_6 @e[tag=kitpvp.bomb_track_new,distance=..4]

execute as @e[tag=kitpvp.bomb_rider_new] run scoreboard players set @s kitpvp.bomb_life 120
tag @e[tag=kitpvp.bomb_rider_new] remove kitpvp.bomb_rider_new
tag @e[tag=kitpvp.bomb_track_new] remove kitpvp.bomb_track_new
