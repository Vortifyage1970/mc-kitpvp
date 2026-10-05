# ===== 纵火狂（kit = 5）=====
# 装备：红色皮革头/胸 + 铁腿/靴（全套火焰保护 III）
#       石剑（火焰附加 II）+ 打火石 + 熟牛排 16
# 技能：燃烧瓶 —— 选职业时给 2 瓶，投掷落地生成 4x4 火，
#       45 秒补 1 瓶，上限 2 瓶

function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 5
tag @s add kitpvp.selected

# --- 盔甲：红色皮革 + 铁，全套火焰保护 III ---
item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,display:{color:11546150},Enchantments:[{id:"minecraft:fire_protection",lvl:3}]}
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:11546150},Enchantments:[{id:"minecraft:fire_protection",lvl:3}]}
item replace entity @s armor.legs with minecraft:iron_leggings{Unbreakable:1b,Enchantments:[{id:"minecraft:fire_protection",lvl:3}]}
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b,Enchantments:[{id:"minecraft:fire_protection",lvl:3}]}

# --- 主手：石剑（火焰附加 II）---
item replace entity @s weapon.mainhand with minecraft:stone_sword{Unbreakable:1b,Enchantments:[{id:"minecraft:fire_aspect",lvl:2}]}

# --- 食物 / 工具 ---
give @s minecraft:cooked_beef 16
give @s minecraft:flint_and_steel 1

# --- 初始 2 瓶燃烧瓶 ---
# 药水本体是普通喷溅水瓶（无任何效果），只靠 display.Name 与颜色区分
scoreboard players set @s kitpvp.arsonist_ammo 2
scoreboard players set @s kitpvp.cd 0
give @s minecraft:splash_potion{KitFireBomb:1b,CustomPotionColor:16750848,display:{Name:'{"text":"燃烧瓶","color":"gold","bold":true}'}} 2

tellraw @s [{"text":"已选择 ","color":"green"},{"text":"纵火狂","color":"gold","bold":true}]