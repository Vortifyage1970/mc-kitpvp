# 地球·72 支援者（缓降）：同一只刷怪笼头骷髅，但提起前先灌 60 秒缓降，慢慢飘下来
# 60 秒是为了撑满 30 格的下落（缓降大约 0.7 格/秒，30 格要 40 秒上下），药效到点也不会摔伤：
# 整个下落段都有 Invulnerable，落地两刻后才由 supporter_land 解除
# 其余同 earth_supporter_a：先在地面召（为了 link 认领 4 格内的新召唤物）
summon minecraft:skeleton ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_supporter","kitpvp.sup_wait","kitpvp.sup_veil"],CustomName:'{"text":"支援者","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:15.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:15.0}],HandItems:[{id:"minecraft:iron_sword",Count:1b},{}],ArmorItems:[{},{},{},{id:"minecraft:spawner",Count:1b}],Invulnerable:1b}
execute as @e[tag=kitpvp.sup_veil,limit=1,sort=nearest] run effect give @s minecraft:slow_falling 1200 0 true
scoreboard players set @e[tag=kitpvp.earth_supporter,limit=1,sort=nearest] kitpvp.sup_land 0
