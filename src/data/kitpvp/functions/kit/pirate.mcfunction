# 海盗（kit = 9）
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 9
tag @s add kitpvp.selected

# 深蓝皮革 2302862 = 0x23238E
item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,display:{color:2302862}} 1
item replace entity @s armor.chest with minecraft:leather_chestplate{Unbreakable:1b,display:{color:2302862}} 1
item replace entity @s armor.legs with minecraft:iron_leggings{Unbreakable:1b} 1
item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b} 1

# 1.20.1：写了 AttributeModifiers 就整体取代该物品默认修饰符，攻伤与攻速必须写全
# 主手斧：实际伤害 8 / 攻速 1.0 —— 玩家基础攻击力是 1，所以 Amount 要写 7.0（不是 8.0，见 04 §九）
give @s minecraft:diamond_axe{KitPirateAxe:1b,Unbreakable:1b,AttributeModifiers:[{AttributeName:"minecraft:generic.attack_damage",Name:"kitpvp.pirate_axe_damage",Amount:7.0,Operation:0,UUID:[I;91,92,93,94],Slot:"mainhand"},{AttributeName:"minecraft:generic.attack_speed",Name:"kitpvp.pirate_axe_speed",Amount:-3.0,Operation:0,UUID:[I;91,92,93,95],Slot:"mainhand"}]} 1

# 手炮：give 不指定槽位，落首个空槽；拾取/清除按全背包扫 NBT，不依赖槽位
give @s minecraft:crossbow{KitCrossbow:1b,Unbreakable:1b,display:{Name:'{"text":"手炮","color":"dark_blue"}'}} 1

give @s minecraft:firework_rocket{KitPirateRocket:1b,Fireworks:{Flight:1,Explosions:[{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b}]}} 1

give @s minecraft:cooked_beef 24

scoreboard players set @s kitpvp.lives 3

tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"海盗","color":"dark_blue","bold":true}]
playsound minecraft:item.armor.equip_leather master @s ~ ~ ~ 0.8 1.0
