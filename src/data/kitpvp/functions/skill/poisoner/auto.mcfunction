# 自动补货：真瓶子不足 2 瓶就补 1 瓶并罚 15 秒节流（cd 只由 give 写，投出不罚）
# 数量必须用 clear ... 0 读背包真实值（计数器会被丢瓶子 / 背包满的掉落带偏，见 04 §八）
scoreboard players set @s kitpvp.poisoner_ammo 0
execute store result score @s kitpvp.poisoner_ammo run clear @s minecraft:lingering_potion{Potion:"minecraft:long_poison"} 0

execute if score @s kitpvp.poisoner_ammo matches ..1 run function kitpvp:skill/poisoner/give
