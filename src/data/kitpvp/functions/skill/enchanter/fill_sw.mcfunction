# 剑的进度攒满 300（15 秒）：换成 1 点蓄力
scoreboard players set @s kitpvp.ench_sw_fill 0
scoreboard players add @s kitpvp.ench_sw 1
playsound minecraft:block.enchantment_table.use master @s ~ ~ ~ 0.45 1.6
particle minecraft:enchant ~ ~1 ~ 0.3 0.5 0.3 0.1 8
function kitpvp:skill/enchanter/ench_check
