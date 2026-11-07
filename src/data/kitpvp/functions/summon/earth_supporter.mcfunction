# 地球·71 支援者：头戴刷怪笼的骷髅，拿铁剑，15 血，从召唤点上方 20 格砸下来
# 两种亚型各 50%：A 裸降（没有任何药水效果）、B 缓降（slow_falling 20 秒）
# 为什么先在地面召、下一刻再提上去：link 只认领 4 格以内的 earth_minion_new（拿队伍 + earth_owner），
# 直接在 20 格高召会拿不到归属，变成谁靠近打谁（包括召唤者）
# 无敌是给下落段用的：20 格自由落体的摔落伤害足以摔死 15 血的骷髅，落地两刻后由 supporter_land 解除
execute if score @s kitpvp.rng matches 0..34 run summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_supporter","kitpvp.sup_wait"],CustomName:'{"text":"支援者","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:15.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:15.0}],HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:spawner",Count:1b}],Invulnerable:1b}
execute unless score @s kitpvp.rng matches 0..34 run summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_supporter","kitpvp.sup_wait","kitpvp.sup_veil"],CustomName:'{"text":"支援者","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:15.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:15.0}],HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:spawner",Count:1b}],Invulnerable:1b}
# 缓降亚型：落地那一刻就上药，之后提起、下落全程都带着（20 秒足够慢速落到底）
execute as @e[tag=kitpvp.sup_veil,limit=1,sort=nearest] run effect give @s minecraft:slow_falling 400 0 true
scoreboard players set @e[tag=kitpvp.earth_supporter,limit=1,sort=nearest] kitpvp.sup_land 0
