# 资本家死了：在尸体位置掉一张「十万大刀乐」（@s = 跟着它走的守卫 marker）
# 和「物料」同一套：先当普通物品召唤，再交给 junk_serial 盖一个唯一流水号 ⇒ 只占一格、不叠加
summon minecraft:item ~ ~1 ~ {Tags:["kitpvp.junk_new","kitpvp.earth_capital_loot"],PickupDelay:20s,Item:{id:"minecraft:paper",Count:1b,tag:{display:{Name:'{"text":"十万大刀乐","color":"gold","italic":false}'},Enchantments:[{id:"minecraft:unbreaking",lvl:1}],kitpvp:{serial:0}}}}
execute as @e[tag=kitpvp.junk_new] at @s run function kitpvp:skill/earth/junk_serial
playsound minecraft:entity.experience_orb.pickup master @a[distance=..24] ~ ~ ~ 1.0 0.8
tellraw @a [{"text":"资本家","color":"gold","bold":true},{"text":" 掉了一张 ","color":"white"},{"text":"十万大刀乐","color":"gold"},{"text":"。","color":"white"}]
kill @s
