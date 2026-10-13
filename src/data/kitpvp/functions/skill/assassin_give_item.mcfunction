# 幂等发放隐匿令牌（末影人刷怪蛋，KitAssassinEgg:1b）；tick 会把生成的末影人立刻清掉
execute unless data entity @s Inventory[{tag:{KitAssassinEgg:1b}}] run give @s minecraft:enderman_spawn_egg{KitAssassinEgg:1b,display:{Name:'{"text":"隐匿令牌","color":"dark_purple","bold":true}'}} 1
