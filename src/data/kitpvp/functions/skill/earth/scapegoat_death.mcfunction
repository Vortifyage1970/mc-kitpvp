# @s = 跟着本体走的守卫：借调期结束，锅已经甩完，只留一张「解雇通知」
execute at @s run tellraw @a [{"text":"[借调员工] ","color":"gray"},{"text":"我的借调期……结束了。","color":"gray","italic":true}]
execute at @s run playsound minecraft:entity.villager.death master @a[distance=..24] ~ ~ ~ 0.8 1.1
summon minecraft:item ~ ~1 ~ {Tags:["kitpvp.junk_new","kitpvp.earth_scapegoat_notice"],PickupDelay:20s,Item:{id:"minecraft:paper",Count:1b,tag:{display:{Name:'{"text":"解雇通知","color":"gray","italic":false}'},Enchantments:[{id:"minecraft:unbreaking",lvl:1}],kitpvp:{serial:0}}}}
execute as @e[tag=kitpvp.junk_new] at @s run function kitpvp:skill/earth/junk_serial
kill @s
