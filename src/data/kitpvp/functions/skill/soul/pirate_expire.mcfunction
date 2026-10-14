clear @s minecraft:crossbow{KitSoulPirateCrossbow:1b}
kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:crossbow",tag:{KitSoulPirateCrossbow:1b}}}]

tag @s remove kitpvp.soul_pirate_held
scoreboard players set @s kitpvp.soul_pirate_timer 0

title @s actionbar {"text":"魂石手炮已消失","color":"gray"}
