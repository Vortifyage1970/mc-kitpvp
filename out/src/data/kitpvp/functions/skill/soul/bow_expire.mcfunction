# ===== 魂石·弓箭手：20 秒到期 =====
clear @s minecraft:bow{KitSoulBow:1b}
kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:bow",tag:{KitSoulBow:1b}}}]

tag @s remove kitpvp.soul_bow_held
scoreboard players set @s kitpvp.soul_bow_timer 0

title @s actionbar {"text":"魂石之弓已消失","color":"gray"}
