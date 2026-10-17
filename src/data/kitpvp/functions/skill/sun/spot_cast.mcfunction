# 首行推进快照，漏写会每刻连发
scoreboard players operation @s kitpvp.sun_spot_last = @s kitpvp.sun_spot_used

# 黑子看 cd2；补货交给 tick 的 refill_spot
execute if score @s kitpvp.cd2 matches ..0 run function kitpvp:skill/sun/spot_fire
execute if score @s kitpvp.cd2 matches 1.. run title @s actionbar {"text":"太阳黑子冷却中","color":"dark_purple"}
