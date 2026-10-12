# ===== 渔夫（kit = 7）=====
# 触发：kit/info/fisher 的「[确认选择]」按钮，@s = 选职业的玩家
# 负责：清场 → 写 kit → 打 tag → 装备 → 补给 → 提示
# 主动技能：寻回三叉戟（令牌驱动，见 skill/fisher_cast）
# 无被动效果；护甲与武器数值全部写在物品的 AttributeModifiers 上
#
# 数值口径（AttributeModifiers 会覆盖物品默认修饰符，故写全套）：
#   护甲：head 2（铁盔）/ chest 6（铁甲）/ legs 5（铁护腿）/ feet 2（铁靴）= 15
#   三叉戟：attack_damage +6 → 基础 1 + 6 = 7
#           attack_speed  -3 → 基础 4 - 3 = 1.0

function kitpvp:util/clear_player
scoreboard players set @s kitpvp.kit 7
scoreboard players set @s kitpvp.fisher_no_tri 0
tag @s add kitpvp.selected

# --- 一、护甲：皮革三件 + 鞘翅，护甲值++ ---
# head：皮革头盔默认 1，覆盖为 2
item replace entity @s armor.head with minecraft:leather_helmet{Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.armor",Name:"generic.armor",Amount:2,Operation:0,UUID:[I;7,0,0,1],Slot:"head"}]} 1
# chest：保护 V
item replace entity @s armor.chest with minecraft:elytra{Unbreakable:1b,Enchantments:[{id:"minecraft:protection",lvl:5}]} 1
# legs：皮革护腿默认 2，覆盖为 5
item replace entity @s armor.legs with minecraft:leather_leggings{Unbreakable:1b,AttributeModifiers:[{AttributeName:"generic.armor",Name:"generic.armor",Amount:5,Operation:0,UUID:[I;7,0,0,3],Slot:"legs"}]} 1
# feet：皮革靴默认 1，覆盖为 2；深海探索者 III
item replace entity @s armor.feet with minecraft:leather_boots{Unbreakable:1b,Enchantments:[{id:"minecraft:depth_strider",lvl:3}],AttributeModifiers:[{AttributeName:"generic.armor",Name:"generic.armor",Amount:2,Operation:0,UUID:[I;7,0,0,4],Slot:"feet"}]} 1

# --- 二、主手：三叉戟（忠诚 II，伤害 7，攻速 1.0）---
# KitFisherTrident:1b 是本职业私有标记，skill/fisher_fire 靠它判断"是否已持有"。
# ⚠ 这把戟的 NBT 必须与 skill/fisher_refill.mcfunction 里补发的那把一致
#   （唯一差别是本行用 item replace 进主手，补发用 give 进背包）。
item replace entity @s weapon.mainhand with minecraft:trident{KitFisherTrident:1b,Unbreakable:1b,Enchantments:[{id:"minecraft:loyalty",lvl:2}],AttributeModifiers:[{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:6,Operation:0,UUID:[I;7,0,0,5],Slot:"mainhand"},{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-3,Operation:0,UUID:[I;7,0,0,6],Slot:"mainhand"}]} 1

# --- 三、鱼竿 / 水桶 / 食物 ---
give @s minecraft:fishing_rod{Unbreakable:1b,Enchantments:[{id:"minecraft:knockback",lvl:1}]} 1
give @s minecraft:water_bucket 1
give @s minecraft:cooked_beef 24

# --- 四、寻戟令牌（主动技能按钮）---
function kitpvp:skill/fisher_give_egg

# --- 五、提示 ---
title @s actionbar {"text":"已选择：渔夫","color":"blue"}
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.5
