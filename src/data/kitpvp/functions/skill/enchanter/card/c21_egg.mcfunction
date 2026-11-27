# 赌徒之蛋：留着，用掉之后下一次领域不吃冷却
give @s minecraft:turtle_spawn_egg{KitEnchRedraw:1b,display:{Name:'{"text":"坐杀博徒·重开","color":"light_purple","italic":false}'},Enchantments:[{id:"minecraft:unbreaking",lvl:1s}]} 1
tellraw @s [{"text":"★ 抽到：","color":"gold"},{"text":"赌徒之蛋","color":"gold","bold":true},{"text":"（右键使用：下次领域不消耗冷却）","color":"gray"}]
playsound minecraft:entity.player.levelup master @s ~ ~ ~ 0.7 1.2
