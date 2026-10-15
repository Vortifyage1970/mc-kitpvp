# 一次性发回两个令牌（缺哪个补哪个），随后关窗。
# 只有"技能真的放出去"（cang_release / domain_open）才会打开这个窗口 ——
# 所以拖动物品、丢地上、塞进箱子都不会凭空多出一个（04 §四的规矩：不能用"背包里没有"当补发依据）。
# 窗口内仍要判背包：玩家若因故手上还有一个（例如地上捡回来的），就不再叠加
execute unless data entity @s Inventory[{tag:{KitTaintedFisherBlue:1b}}] run function kitpvp:skill/tainted_fisher/give_blue
execute unless data entity @s Inventory[{tag:{KitTaintedFisherDomain:1b}}] run function kitpvp:skill/tainted_fisher/give_domain

tag @s remove kitpvp.tainted_fisher_handout

title @s actionbar {"text":"两个技能都已就绪（令牌已发回）","color":"dark_aqua"}
playsound minecraft:entity.item.pickup master @s ~ ~ ~ 0.6 1.3
