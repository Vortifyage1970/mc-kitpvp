clear @s minecraft:arrow

# 清掉地上的箭物品，防"丢一支→换弹→捡回"刷过上限（会一并清掉地图上其它来源的箭）
kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:arrow"}}]

give @s minecraft:arrow 12

title @s actionbar {"text":"换弹完成：12 支箭","color":"gold"}
playsound minecraft:item.crossbow.loading_end master @s ~ ~ ~ 0.8 1.3
