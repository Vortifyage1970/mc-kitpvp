# 读了 15 秒：两条各 +1 点，并重置读书计时
scoreboard players set @s kitpvp.ench_book_t 0
playsound minecraft:block.enchantment_table.use master @s ~ ~ ~ 0.5 1.6
particle minecraft:enchant ~ ~1 ~ 0.4 0.6 0.4 0.2 12
scoreboard players add @s kitpvp.ench_sw 1
scoreboard players add @s kitpvp.ench_ap 1
function kitpvp:skill/enchanter/ench_check
