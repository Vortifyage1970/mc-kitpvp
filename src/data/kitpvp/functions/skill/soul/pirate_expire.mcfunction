clear @s minecraft:crossbow{KitSoulPirateCrossbow:1b}
kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:crossbow",tag:{KitSoulPirateCrossbow:1b}}}]
# 散装炮弹与海盗自己的弹药同 NBT，分不出来，故不回收；换弹会把它清成 1 发

tag @s remove kitpvp.soul_pirate_held
scoreboard players set @s kitpvp.soul_pirate_timer 0

title @s actionbar {"text":"魂石大型手炮已消失","color":"gray"}
