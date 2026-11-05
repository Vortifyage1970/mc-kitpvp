# 对照实验：把蠹虫的 NoGravity 拿掉、换成永久缓降
# 预期：出生在空中会以约 0.1 格/刻慢慢往下飘（不受摔伤）；一旦落地 onGround 恢复 true，
#       原版地面寻路重新工作 —— 它自己会走向玩家，不再需要 nograv_chase 每刻 tp
# 用单独的 tag，避免被 nograv_chase 和"僵尸没了就自杀"那两行接管
summon minecraft:silverfish ~ ~ ~ {Tags:["kitpvp.earth_dirtknight_test"],CustomName:'{"text":"缓降泥土骑士","color":"gray"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Invulnerable:1b,Passengers:[{id:"minecraft:zombie",Tags:["kitpvp.earth_dirt_zombie_test"],CustomName:'{"text":"泥土头僵尸","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,ArmorItems:[{},{},{},{id:"minecraft:dirt",Count:1b}]}]}
effect give @e[tag=kitpvp.earth_dirtknight_test] minecraft:slow_falling infinite 0 true
tellraw @s [{"text":"[对照] 已召唤缓降泥土骑士：看它是慢慢飘下来、落地后自己走，还是原地不动","color":"yellow"}]