# 首行推进快照，漏写会每刻连发
scoreboard players operation @s kitpvp.sun_flare_last = @s kitpvp.sun_flare_used

# 施法被 cd 闸门拦着：令牌被偷 / 丢地上也吃不到额外一发，补货交给 tick 的 refill_flare（见 04 §四）
execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/sun/flare_fire
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"太阳耀斑冷却中","color":"gold"}
