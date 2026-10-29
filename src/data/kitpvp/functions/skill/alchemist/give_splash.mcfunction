# 幂等发放整套：数量按背包真实值读，缺哪种补哪种（不用 Inventory 判"有没有"，那只看得见库存里的一个）
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:splash_potion{KitAlchemistSpeed:1b} 0
execute if score @s kitpvp.tmp matches ..0 run function kitpvp:skill/alchemist/give_speed
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:splash_potion{KitAlchemistRegen:1b} 0
execute if score @s kitpvp.tmp matches ..0 run function kitpvp:skill/alchemist/give_regen
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:splash_potion{KitAlchemistJump:1b} 0
execute if score @s kitpvp.tmp matches ..0 run function kitpvp:skill/alchemist/give_jump
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:splash_potion{KitAlchemistInvis:1b} 0
execute if score @s kitpvp.tmp matches ..0 run function kitpvp:skill/alchemist/give_invis
