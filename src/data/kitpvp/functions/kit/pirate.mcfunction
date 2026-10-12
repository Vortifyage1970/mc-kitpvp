# ===== 海盗（编号 9） =====
# 调用方：util/give_kit（按 kit 分派）

# 干净起步（本函数会清掉 kit，立刻由下面写回 9）
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 9
tag @s add kitpvp.selected

# 深蓝皮革（13158 = 0x003366）+ 铁甲
item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,display:{color:13158}} 1
item replace entity @s armor.chest with minecraft:iron_chestplate{Unbreakable:1b} 1
item replace entity @s armor.legs with minecraft:iron_leggings{Unbreakable:1b} 1
item replace entity @s armor.feet with minecraft:leather_boots{Unbreakable:1b,display:{color:13158}} 1

# 主手斧：8 伤害 / 1.0 攻速
# 1.20.1 铁律：一旦写了 AttributeModifiers，就会整体取代该物品类型的默认修饰符，
# 所以 attack_damage 与 attack_speed 两条都必须写全。
# 玩家基础 1 伤害 + 7 = 8；基础攻速 4.0 + (-3.0) = 1.0
give @s minecraft:diamond_axe{KitPirateAxe:1b,Unbreakable:1b,AttributeModifiers:[{AttributeName:"minecraft:generic.attack_damage",Name:"kitpvp.pirate_axe_damage",Amount:8.0,Operation:0,UUID:[I;91,92,93,94],Slot:"mainhand"},{AttributeName:"minecraft:generic.attack_speed",Name:"kitpvp.pirate_axe_speed",Amount:-3.0,Operation:0,UUID:[I;91,92,93,95],Slot:"mainhand"}]} 1

# 副手弩——海盗的"手炮"，丢出捡回换弹
# 注：give 不能指定槽位，会掉在首个空槽；玩家自己挪到副手即可，
#     拾取/清除逻辑按 Inventory 全背包扫 NBT，不依赖槽位。
give @s minecraft:crossbow{KitCrossbow:1b,Unbreakable:1b,display:{Name:'{"text":"手炮","color":"dark_blue"}'}} 1

# 开局 1 发炮弹（与换弹给的一致）
give @s minecraft:firework_rocket{KitPirateRocket:1b,Fireworks:{Flight:1,Explosions:[{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b}]}} 1

# 食物
give @s minecraft:cooked_beef 24

# 命数
scoreboard players set @s kitpvp.lives 3

playsound minecraft:item.armor.equip_leather master @s ~ ~ ~ 0.8 1.0
