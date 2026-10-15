# 自动补货：真瓶子不足 2 瓶就补 1 瓶并罚 45 秒节流。投出不碰 cd，cd 只由 skill/arsonist/give 写（见 03 §2.13）
# 数量必须用 clear ... 0 读背包真实值：计数器会因"丢瓶子到地上 / 背包满时 give 掉在地上"虚高，
# 虚高到上限之后就永远不再补货（见 04 §八）
scoreboard players set @s kitpvp.arsonist_ammo 0
execute store result score @s kitpvp.arsonist_ammo run clear @s minecraft:splash_potion{KitFireBomb:1b} 0

execute if score @s kitpvp.arsonist_ammo matches ..1 run function kitpvp:skill/arsonist/give
