# 里·坦克（kit = 25）：钻石全套荆棘 V + 耐久 III 木剑，靠反弹伤害的致命肉盾
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 25
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

# 护甲 20 / 韧性 8 由钻石装备自然提供，不额外 set attribute（否则翻倍，见 kit/tank）
item replace entity @s armor.head with minecraft:diamond_helmet{Unbreakable:1b,Enchantments:[{id:"minecraft:thorns",lvl:5}]}
item replace entity @s armor.chest with minecraft:diamond_chestplate{Unbreakable:1b,Enchantments:[{id:"minecraft:thorns",lvl:5}]}
item replace entity @s armor.legs with minecraft:diamond_leggings{Unbreakable:1b,Enchantments:[{id:"minecraft:thorns",lvl:5}]}
item replace entity @s armor.feet with minecraft:diamond_boots{Unbreakable:1b,Enchantments:[{id:"minecraft:thorns",lvl:5}]}
item replace entity @s hotbar.0 with minecraft:wooden_sword{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s hotbar.1 with minecraft:cooked_beef 12

# 只有 1 条命：死了直接进旁观，没有重生第二轮
function kitpvp:skill/tainted_tank/passive

scoreboard players set @s kitpvp.lives 1

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"里·坦克","color":"dark_red","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
