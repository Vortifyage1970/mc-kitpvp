# 甲的进度攒满 300：换成 1 点蓄力（只扣 300，不丢零头）
scoreboard players remove @s kitpvp.ench_ap_fill 300
scoreboard players add @s kitpvp.ench_ap 1
playsound minecraft:block.enchantment_table.use master @s ~ ~ ~ 0.45 1.2
particle minecraft:enchant ~ ~1 ~ 0.3 0.5 0.3 0.1 8
function kitpvp:skill/enchanter/ench_check