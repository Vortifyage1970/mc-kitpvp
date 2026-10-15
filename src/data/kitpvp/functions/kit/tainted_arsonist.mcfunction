# 里·纵火狂（kit = 27）：红皮革火焰保护 III + 木剑（击退 II / 火焰附加 IV）+ 无法破坏打火石，无技能
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 27
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3

# 红皮革 11546150 与表纵火狂同色；护甲 7 由皮革自然提供，不额外 set attribute（否则翻倍）
item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,display:{color:11546150},Enchantments:[{id:"minecraft:fire_protection",lvl:3}]}
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:11546150},Enchantments:[{id:"minecraft:fire_protection",lvl:3}]}
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b,display:{color:11546150},Enchantments:[{id:"minecraft:fire_protection",lvl:3}]}
item replace entity @s armor.feet with minecraft:leather_boots{Unbreakable:1b,display:{color:11546150},Enchantments:[{id:"minecraft:fire_protection",lvl:3}]}

item replace entity @s hotbar.0 with minecraft:wooden_sword{Unbreakable:1b,Enchantments:[{id:"minecraft:knockback",lvl:2},{id:"minecraft:fire_aspect",lvl:4}]}
item replace entity @s hotbar.1 with minecraft:cooked_beef 16

give @s minecraft:flint_and_steel{Unbreakable:1b} 1

playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
