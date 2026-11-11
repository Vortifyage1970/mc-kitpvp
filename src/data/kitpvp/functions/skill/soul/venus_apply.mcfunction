# 金星魂石落地（执行位置 = 落点，@s = 使用者）：召一只持续 20 秒的舔狗
# 20 秒里它带着「武装模块」的增益 + 「制冷模块」的减速光环；到点原地自爆并死亡（见 skill/soul/venus_end）
summon minecraft:wolf ~ ~ ~ {Tags:["kitpvp.soul_venus_dog","kitpvp.soul_venus_new"],PersistenceRequired:1b,Silent:1b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],CustomName:'{"text":"舔狗","color":"gold"}',CustomNameVisible:1b}
execute as @a[distance=..12,sort=nearest,limit=1] run data modify entity @e[tag=kitpvp.soul_venus_new,type=minecraft:wolf,limit=1,sort=nearest] Owner set from entity @s UUID
execute as @a[distance=..12,sort=nearest,limit=1] run tag @s add kitpvp.soul_venus_owner
scoreboard players set @e[tag=kitpvp.soul_venus_new] kitpvp.soul_timer 400
scoreboard players set @e[tag=kitpvp.soul_venus_new] kitpvp.soul_next 0
tag @e[tag=kitpvp.soul_venus_new] remove kitpvp.soul_venus_new

title @s actionbar {"text":"魂石·舔狗：20 秒后自爆","color":"gold"}
playsound minecraft:entity.wolf.growl master @s ~ ~ ~ 1.0 1.2
