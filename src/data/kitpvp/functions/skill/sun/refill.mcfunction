clear @s minecraft:arrow

# 清掉地上的箭物品，防"丢一支→换弹→捡回"刷过 3 支上限（会一并清掉地图上其它来源的箭）
kill @e[type=minecraft:item,nbt={Item:{id:"minecraft:arrow"}}]

give @s minecraft:arrow 3

title @s actionbar {"text":"日冕物质抛射：换弹完成 3 支箭","color":"gold"}
playsound minecraft:item.crossbow.loading_end master @s ~ ~ ~ 0.8 1.3

# 冷却 200 刻（10 秒）必须写在最后一行，否则同函数里靠它判定的行全被自己拦死
scoreboard players set @s kitpvp.sun_reload 200
