# 由 tools/gen_chaos.py 生成：清掉玩家身上所有混沌武器（任何格子），望远镜不碰
# 每行先用 if data 守卫：clear 匹配到 0 个会让整份函数中止，没有守卫时后面的清不掉
# clear 不写 maxCount（默认清全部）
execute if data entity @s Inventory[{tag:{ChaosBlade:1b},id:"minecraft:bow"}] run clear @s minecraft:bow{ChaosBlade:1b}
execute if data entity @s Inventory[{tag:{ChaosBlade:1b},id:"minecraft:crafting_table"}] run clear @s minecraft:crafting_table{ChaosBlade:1b}
execute if data entity @s Inventory[{tag:{ChaosBlade:1b},id:"minecraft:crossbow"}] run clear @s minecraft:crossbow{ChaosBlade:1b}
execute if data entity @s Inventory[{tag:{ChaosBlade:1b},id:"minecraft:diamond_axe"}] run clear @s minecraft:diamond_axe{ChaosBlade:1b}
execute if data entity @s Inventory[{tag:{ChaosBlade:1b},id:"minecraft:diamond_sword"}] run clear @s minecraft:diamond_sword{ChaosBlade:1b}
execute if data entity @s Inventory[{tag:{ChaosBlade:1b},id:"minecraft:golden_axe"}] run clear @s minecraft:golden_axe{ChaosBlade:1b}
execute if data entity @s Inventory[{tag:{ChaosBlade:1b},id:"minecraft:golden_sword"}] run clear @s minecraft:golden_sword{ChaosBlade:1b}
execute if data entity @s Inventory[{tag:{ChaosBlade:1b},id:"minecraft:iron_shovel"}] run clear @s minecraft:iron_shovel{ChaosBlade:1b}
execute if data entity @s Inventory[{tag:{ChaosBlade:1b},id:"minecraft:iron_sword"}] run clear @s minecraft:iron_sword{ChaosBlade:1b}
execute if data entity @s Inventory[{tag:{ChaosBlade:1b},id:"minecraft:stone_axe"}] run clear @s minecraft:stone_axe{ChaosBlade:1b}
execute if data entity @s Inventory[{tag:{ChaosBlade:1b},id:"minecraft:stone_sword"}] run clear @s minecraft:stone_sword{ChaosBlade:1b}
execute if data entity @s Inventory[{tag:{ChaosBlade:1b},id:"minecraft:trident"}] run clear @s minecraft:trident{ChaosBlade:1b}
execute if data entity @s Inventory[{tag:{ChaosBlade:1b},id:"minecraft:wooden_sword"}] run clear @s minecraft:wooden_sword{ChaosBlade:1b}
