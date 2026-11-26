# 护甲升一级：满 11 级就不再涨，只把蓄力钉在 3
scoreboard players set @s kitpvp.ench_ap 3
execute if score @s kitpvp.ench_armor matches ..10 run function kitpvp:skill/enchanter/up_armor_do
