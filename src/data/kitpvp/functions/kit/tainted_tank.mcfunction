# 里·坦克（kit = 25）：钻石全套荆棘 V + 耐久 III 木剑，靠反弹伤害的致命肉盾
# 护甲 20 显式写在 AttributeModifiers 里（覆盖默认修饰符 = 韧性从 8 清零，同 kit/tank）；
# 血量减半用玩家属性 max_health 基数 10（clear_player 已把基数重置为 20，这里必须再压）。
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 25
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

item replace entity @s armor.head with minecraft:diamond_helmet{Unbreakable:1b,Enchantments:[{id:"minecraft:thorns",lvl:5}],AttributeModifiers:[{AttributeName:"generic.armor",Name:"kitpvp.ttank_armor_head",Amount:3,Operation:0,UUID:[I;25,0,0,1],Slot:"head"}]}
item replace entity @s armor.chest with minecraft:diamond_chestplate{Unbreakable:1b,Enchantments:[{id:"minecraft:thorns",lvl:5}],AttributeModifiers:[{AttributeName:"generic.armor",Name:"kitpvp.ttank_armor_chest",Amount:8,Operation:0,UUID:[I;25,0,0,2],Slot:"chest"}]}
item replace entity @s armor.legs with minecraft:diamond_leggings{Unbreakable:1b,Enchantments:[{id:"minecraft:thorns",lvl:5}],AttributeModifiers:[{AttributeName:"generic.armor",Name:"kitpvp.ttank_armor_legs",Amount:6,Operation:0,UUID:[I;25,0,0,3],Slot:"legs"}]}
item replace entity @s armor.feet with minecraft:diamond_boots{Unbreakable:1b,Enchantments:[{id:"minecraft:thorns",lvl:5}],AttributeModifiers:[{AttributeName:"generic.armor",Name:"kitpvp.ttank_armor_feet",Amount:3,Operation:0,UUID:[I;25,0,0,4],Slot:"feet"}]}
item replace entity @s hotbar.0 with minecraft:wooden_sword{Unbreakable:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:3}]}
item replace entity @s hotbar.1 with minecraft:cooked_beef 14

# 最大生命 20 → 10（砍半）；重生时基数会保留，不需要在 after_death 重设
attribute @s minecraft:generic.max_health base set 10

function kitpvp:skill/tainted_tank/passive

scoreboard players set @s kitpvp.lives 3

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"里·坦克","color":"dark_red","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
