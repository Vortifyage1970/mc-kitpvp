# 起手 1 秒后落「无量空渔」！，音效与粒子同 domain_open
tellraw @a [{"text":"◆　","color":"dark_aqua"},{"text":"无量空渔","color":"white","bold":true},{"text":"！","color":"aqua","bold":true},{"text":"　◆","color":"dark_aqua"}]
execute as @a at @s run playsound minecraft:entity.warden.sonic_boom master @s ~ ~ ~ 0.6 1.1
execute as @a at @s run playsound minecraft:item.trident.thunder master @s ~ ~ ~ 0.5 0.9
particle minecraft:splash ~ ~1 ~ 2.5 2.5 2.5 0.1 400
