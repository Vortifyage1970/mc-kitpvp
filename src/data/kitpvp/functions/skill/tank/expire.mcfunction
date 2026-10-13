# 到期清盾。已知取舍：clear 只作用于持有者，丢地上的盾不会被清（仍带 80 耐久，用完即碎）
clear @s minecraft:shield{KitShield:1b}
tag @s remove kitpvp.shield_held

title @s actionbar {"text":"护盾已消失","color":"gray"}
