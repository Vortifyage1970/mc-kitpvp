# 20 秒到：收回魂石三叉戟（含掉在地上那份）、停雨、摘 tag
clear @s minecraft:trident{KitSoulFisherTrident:1b}
kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:trident",tag:{KitSoulFisherTrident:1b}}}]

# 停雨不判主人：本局可能中途清场（见 04 §五）
weather clear

tag @s remove kitpvp.soul_fisher_active
scoreboard players set @s kitpvp.soul_fisher_timer 0

title @s actionbar {"text":"魂石·激流已消失","color":"gray"}
