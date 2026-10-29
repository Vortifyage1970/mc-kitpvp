# 幂等发放每条命一套的秘药：数量按背包真实值读，缺哪种补哪种（重生补满也走这里）
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:potion{KitAlchemistFireRes:1b} 0
execute if score @s kitpvp.tmp matches ..0 run function kitpvp:skill/alchemist/give_elixir_fire_res
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:potion{KitAlchemistStrength:1b} 0
execute if score @s kitpvp.tmp matches ..0 run function kitpvp:skill/alchemist/give_elixir_strength
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:potion{KitAlchemistSlowFall:1b} 0
execute if score @s kitpvp.tmp matches ..0 run function kitpvp:skill/alchemist/give_elixir_slow_fall
scoreboard players set @s kitpvp.tmp 0
execute store result score @s kitpvp.tmp run clear @s minecraft:potion{KitAlchemistTurtle:1b} 0
execute if score @s kitpvp.tmp matches ..0 run function kitpvp:skill/alchemist/give_elixir_turtle
