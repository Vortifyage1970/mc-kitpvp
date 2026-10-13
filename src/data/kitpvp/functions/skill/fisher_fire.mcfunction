# 三分支互斥，必须在同一刻读同一份背包状态（refill 一旦发戟，后续背包检查就会自骗）
execute if data entity @s Inventory[{tag:{KitFisherTrident:1b}}] run title @s actionbar {"text":"你已持有三叉戟","color":"gray"}

execute unless data entity @s Inventory[{tag:{KitFisherTrident:1b}}] unless score @s kitpvp.fisher_no_tri matches 160.. run title @s actionbar {"text":"三叉戟尚未离场","color":"gray"}

execute unless data entity @s Inventory[{tag:{KitFisherTrident:1b}}] if score @s kitpvp.fisher_no_tri matches 160.. run function kitpvp:skill/fisher_refill
