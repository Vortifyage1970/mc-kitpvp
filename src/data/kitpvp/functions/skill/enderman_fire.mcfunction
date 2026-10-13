# 冷却从投出瞬间起算 500 刻（25 秒）；末影珍珠的传送是原版行为，本函数不接管
execute if score @s kitpvp.ender_ammo matches 1.. run scoreboard players remove @s kitpvp.ender_ammo 1

scoreboard players set @s kitpvp.cd 500

title @s actionbar {"text":"末影之珠已投出","color":"dark_purple"}
playsound minecraft:entity.ender_pearl.throw master @s ~ ~ ~ 0.8 1.2
