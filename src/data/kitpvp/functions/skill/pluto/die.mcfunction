# 宽限走完还是没有鹦鹉 => 判定"鹦鹉已死"，本体跟着死
# 抗性 V 挡不住 out_of_world，正好用来保证必死；死亡照常扣命、传回出生点
# 计数在这里清零：重生后由 player/after_death → skill/pluto/respawn 补一只新鹦鹉（见 06 §76）
scoreboard players set @s kitpvp.parrot_miss 0
damage @s 1000 minecraft:out_of_world
