# @s = 资本家：每挨一次打掉一张「十万大刀乐」（掉在脚边，20 刻后才能捡，避免自己人被弹开）
# 和 COSER 的「物料」同一套：附魔只为发光 + junk_serial 盖唯一流水号 ⇒ 永不一堆
summon minecraft:item ~ ~1 ~ {Tags:["kitpvp.junk_new","kitpvp.earth_capital_loot"],PickupDelay:20s,Item:{id:"minecraft:paper",Count:1b,tag:{display:{Name:'{"text":"十万大刀乐","color":"gold","italic":false}'},Enchantments:[{id:"minecraft:unbreaking",lvl:1}],kitpvp:{serial:0}}}}
execute as @e[tag=kitpvp.junk_new] at @s run function kitpvp:skill/earth/junk_serial
playsound minecraft:entity.experience_orb.pickup master @a[distance=..24] ~ ~ ~ 0.9 1.2
particle minecraft:totem_of_undying ~ ~1 ~ 0.2 0.3 0.2 0.05 8 normal
