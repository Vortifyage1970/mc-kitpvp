# 幂等发放举盾令牌（铁傀儡刷怪蛋，KitTankEgg:1b）；tick 会把右键生成的铁傀儡立刻清掉。
execute unless data entity @s Inventory[{tag:{KitTankEgg:1b}}] run give @s minecraft:iron_golem_spawn_egg{KitTankEgg:1b,display:{Name:'{"text":"举盾令牌","color":"aqua","bold":true}'}} 1
