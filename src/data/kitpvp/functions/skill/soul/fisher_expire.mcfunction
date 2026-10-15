# 20 秒到：收回魂石三叉戟（背包里那把 + 掉在地上的，防"丢地上留下"）、停雨、摘 tag
clear @s minecraft:trident{KitSoulFisherTrident:1b}
kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:trident",tag:{KitSoulFisherTrident:1b}}}]

# 停雨不判 tag：本局的雨可能因为清场而失去主人，无条件停雨最省心（load 关了 doWeatherCycle，见 04 §五）
weather clear

tag @s remove kitpvp.soul_fisher_active
scoreboard players set @s kitpvp.soul_fisher_timer 0

title @s actionbar {"text":"魂石·激流已消失（自己那把三叉戟不受影响）","color":"gray"}
