# 一次性发回两个令牌（缺哪个补哪个），随后关窗。
# 窗口只由"真的放过技能"打开，所以拖动物品 / 丢地上都不会多给（见 04 §四）
execute unless data entity @s Inventory[{tag:{KitTaintedFisherBlue:1b}}] run function kitpvp:skill/tainted_fisher/give_blue
execute unless data entity @s Inventory[{tag:{KitTaintedFisherDomain:1b}}] run function kitpvp:skill/tainted_fisher/give_domain

tag @s remove kitpvp.tainted_fisher_handout

title @s actionbar {"text":"两个技能已就绪","color":"dark_aqua"}
playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.3
