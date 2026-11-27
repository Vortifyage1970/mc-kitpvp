effect give @s minecraft:instant_health 1 1 true
effect give @s minecraft:regeneration 2 2 true
tellraw @s [{"text":"★ 抽到：","color":"gold"},{"text":"大回复","color":"gold","bold":true},{"text":"（回复约 10 点生命）","color":"gray"}]
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.7 1.4
