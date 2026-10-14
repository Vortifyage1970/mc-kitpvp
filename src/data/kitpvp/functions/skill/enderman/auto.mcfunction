# 补货判据用背包真实数量：计数器会因"珍珠丢地上 / 背包满时 give 掉在地上没捡到"而漂移，
# 虚高到 3 之后就永远不再补货（clear ... 0 只计数不清除）
scoreboard players set @s kitpvp.ender_ammo 0
execute store result score @s kitpvp.ender_ammo run clear @s minecraft:ender_pearl{KitEnderPearl:1b} 0

execute if score @s kitpvp.ender_ammo matches ..2 run function kitpvp:skill/enderman/give
