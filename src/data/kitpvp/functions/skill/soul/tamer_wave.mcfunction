# 一波：1 只狗 + 4 只动物（@s = marker，执行位置 = 落点）
scoreboard players set @s kitpvp.soul_next 100

# 狗：先召出来，再把最近的那名玩家写成主人（= 驯服），最后摘掉临时标签
execute at @s run summon minecraft:wolf ~ ~ ~ {Tags:["kitpvp.soul_tamer_wolf","kitpvp.soul_tamer_new"],PersistenceRequired:1b,Silent:1b}
execute as @a[distance=..12,sort=nearest,limit=1] run data modify entity @e[tag=kitpvp.soul_tamer_new,type=minecraft:wolf,limit=1,sort=nearest] Owner set from entity @s UUID
tag @e[tag=kitpvp.soul_tamer_new] remove kitpvp.soul_tamer_new

# 期间的速度 I + 生命恢复 I：每波续一次 6 秒，覆盖到下一波
execute at @s as @e[tag=kitpvp.soul_tamer_wolf,distance=..24] run effect give @s minecraft:speed 6 0 true
execute at @s as @e[tag=kitpvp.soul_tamer_wolf,distance=..24] run effect give @s minecraft:regeneration 6 0 true

# 4 只随机动物：同一个函数连调四次
execute at @s run function kitpvp:skill/soul/tamer_animal
execute at @s run function kitpvp:skill/soul/tamer_animal
execute at @s run function kitpvp:skill/soul/tamer_animal
execute at @s run function kitpvp:skill/soul/tamer_animal

playsound minecraft:entity.wolf.ambient master @a[distance=..24] ~ ~ ~ 0.8 1.1
