# @s = 凤凰的守卫 marker，阶段 1 走完 200 刻：在蛋的位置复活第二形态（只此一次）
scoreboard players set @s kitpvp.phx_stage 2
execute at @s run kill @e[tag=kitpvp.phx_egg,distance=..4]
execute at @s run particle minecraft:lava ~ ~ ~ 0.5 0.8 0.5 0.05 70 force
execute at @s run particle minecraft:flame ~ ~ ~ 0.6 1.0 0.6 0.05 70 force
execute at @s run playsound minecraft:entity.blaze.shoot master @a ~ ~ ~ 1.2 0.6
execute at @s run playsound minecraft:entity.generic.explode master @a ~ ~ ~ 0.5 1.4
execute at @s run summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_phoenix","kitpvp.earth_phoenix_reborn"],CustomName:'{"text":"凤凰","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{id:"minecraft:golden_sword",Count:1b},{}]}
# 第二形态不带 earth_minion_new（否则下一次召唤的 link 会把它算成别人的召唤物）；主人与队伍在这里手动补
scoreboard players add @e[tag=kitpvp.earth_phoenix_reborn] kitpvp.earth_owner 0
scoreboard players operation @e[tag=kitpvp.earth_phoenix_reborn] kitpvp.earth_owner = @s kitpvp.earth_owner
scoreboard players operation #phx_t kitpvp.game = @s kitpvp.earth_owner
execute if score #phx_t kitpvp.game matches 1 run team join earth_1 @e[tag=kitpvp.earth_phoenix_reborn]
execute if score #phx_t kitpvp.game matches 2 run team join earth_2 @e[tag=kitpvp.earth_phoenix_reborn]
execute if score #phx_t kitpvp.game matches 3 run team join earth_3 @e[tag=kitpvp.earth_phoenix_reborn]
execute if score #phx_t kitpvp.game matches 4 run team join earth_4 @e[tag=kitpvp.earth_phoenix_reborn]
execute if score #phx_t kitpvp.game matches 5 run team join earth_5 @e[tag=kitpvp.earth_phoenix_reborn]
execute if score #phx_t kitpvp.game matches 6 run team join earth_6 @e[tag=kitpvp.earth_phoenix_reborn]
tag @e[tag=kitpvp.earth_phoenix_reborn] remove kitpvp.earth_phoenix_reborn
