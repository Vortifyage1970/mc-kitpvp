execute as @e[tag=kitpvp.displayitem,type=armor_stand] unless data entity @s HomePos run data modify entity @s HomePos set from entity @s Pos
execute as @e[tag=kitpvp.displayitem,type=armor_stand] run data modify entity @s Pos set from entity @s HomePos
execute as @e[tag=kitpvp.displayitem,type=armor_stand] run data merge entity @s {Motion:[0d,0d,0d]}