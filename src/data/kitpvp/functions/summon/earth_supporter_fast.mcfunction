# 地球·71 支援者·fast（裸降）：头戴刷怪笼的骷髅，铁剑，15 血，从召唤点上方 30 格直接砸下来
# 先在地面召、下一刻再提上去：link 只认领 4 格以内的 earth_minion_new（拿队伍 + earth_owner），
# 直接在 30 格高召会拿不到归属，落地后变成谁靠近打谁（包括召唤者）
# 无敌是给下落段用的：30 格自由落体的摔落伤害足以摔死 15 血的骷髅，落地两刻后由 supporter_land 解除
summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_supporter","kitpvp.sup_wait"],CustomName:'{"text":"支援者","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:15.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:15.0}],HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:spawner",Count:1b}],Invulnerable:1b}
scoreboard players set @e[tag=kitpvp.earth_supporter,limit=1,sort=nearest] kitpvp.sup_land 0
