# 幂等发放寻戟令牌（溺尸刷怪蛋，KitFisherEgg:1b）。
# 刷怪蛋的 display.Name 会成为生成生物的 CustomName（已实测），tick 靠 name="寻戟" 清怪。
execute unless data entity @s Inventory[{tag:{KitFisherEgg:1b}}] run give @s minecraft:drowned_spawn_egg{KitFisherEgg:1b,display:{Name:'{"text":"寻戟","color":"blue"}'}} 1
