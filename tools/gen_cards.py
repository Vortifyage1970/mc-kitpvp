import json, os, re

OUT = r"D:\mc-kitpvp\src\data\kitpvp\functions\kit\info"
ENC_CN = {
    "minecraft:fire_protection": "火焰保护", "minecraft:protection": "保护",
    "minecraft:depth_strider": "深海探索者", "minecraft:feather_falling": "摔落保护",
    "minecraft:sharpness": "锋利", "minecraft:fire_aspect": "火焰附加",
    "minecraft:loyalty": "忠诚", "minecraft:knockback": "击退",
    "minecraft:unbreaking": "耐久", "minecraft:thorns": "荆棘",
    "minecraft:riptide": "激流", "minecraft:flame": "火矢",
    "minecraft:binding_curse": "绑定诅咒",
    "minecraft:smite": "亡灵杀手", "minecraft:bane_of_arthropods": "节肢杀手",
    "minecraft:blast_protection": "爆炸保护",
}
ROMAN = {1: "I", 2: "II", 3: "III", 4: "IV", 5: "V",
         6: "VI", 7: "VII", 8: "VIII", 9: "IX", 10: "X"}


def snbt(ench=None, color=None, skull=None, name=None, name_color=None, attrs=None):
    parts = []
    if skull:
        parts.append(f'SkullOwner:"{skull}"')
    if ench:
        parts.append("Enchantments:[" + ",".join(f'{{id:"{e}",lvl:{l}}}' for e, l in ench) + "]")
    if attrs:
        parts.append("AttributeModifiers:[" + ",".join(attrs) + "]")
    disp = []
    if color is not None:
        disp.append(f"color:{color}")
    if name:
        disp.append("Name:'" + json.dumps({"text": name, "color": name_color or "white"},
                                          ensure_ascii=False, separators=(",", ":")) + "'")
    if disp:
        parts.append("display:{" + ",".join(disp) + "}")
    return "{" + ",".join(parts) + "}" if parts else None


def hover(iid, ench=None, color=None, skull=None, name=None, name_color=None, attrs=None, tag=None):
    d = {"id": iid, "Count": 1}
    t = snbt(ench, color, skull, name, name_color, attrs)
    if tag is not None:
        d["tag"] = tag
    elif t:
        d["tag"] = t
    return {"action": "show_item", "contents": d}


def enc_text(ench):
    return "、".join(f"{ENC_CN[e]} {ROMAN[l]}" for e, l in ench) if ench else "—"


def potion_tag(name, color, potion_color, effects=None):
    nm = json.dumps({"text": name, "color": color},
                    ensure_ascii=False, separators=(",", ":"))
    extra = ""
    if effects:
        extra = "CustomPotionEffects:[" + ",".join(effects) + "],"
    return f'{{{extra}Potion:"minecraft:awkward",CustomPotionColor:{potion_color},display:{{Name:\'{nm}\'}}}}'


# fisher 的盔甲/武器属性（与 kit/fisher.mcfunction 逐字一致）
F_TRIDENT_ATTRS = [
    '{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:6,Operation:0,UUID:[I;7,0,0,5],Slot:"mainhand"}',
    '{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-3,Operation:0,UUID:[I;7,0,0,6],Slot:"mainhand"}',
]
F_HEAD_ATTRS = ['{AttributeName:"generic.armor",Name:"generic.armor",Amount:2,Operation:0,UUID:[I;7,0,0,1],Slot:"head"}']
F_LEGS_ATTRS = ['{AttributeName:"generic.armor",Name:"generic.armor",Amount:4,Operation:0,UUID:[I;7,0,0,3],Slot:"legs"}']
F_FEET_ATTRS = ['{AttributeName:"generic.armor",Name:"generic.armor",Amount:2,Operation:0,UUID:[I;7,0,0,4],Slot:"feet"}']
A_LEGS_ATTRS = ['{AttributeName:"generic.armor",Name:"generic.armor",Amount:4,Operation:0,UUID:[I;5,0,0,3],Slot:"legs"}']
# 玩家基础值：攻击力 1 / 攻速 4 / 护甲 0。AttributeModifiers 是加法叠加在基础值上，
# 武器提示显示的也是"基础 + 修饰符"的合计 —— 所以实际要 8 就得写 7.0（见 04 §九）
P_AXE_ATTRS = [
    '{AttributeName:"minecraft:generic.attack_damage",Name:"kitpvp.pirate_axe_damage",Amount:7.0,Operation:0,UUID:[I;91,92,93,94],Slot:"mainhand"}',
    '{AttributeName:"minecraft:generic.attack_speed",Name:"kitpvp.pirate_axe_speed",Amount:-3.0,Operation:0,UUID:[I;91,92,93,95],Slot:"mainhand"}',
]
P_ROCKET_TAG = '{Fireworks:{Flight:1,Explosions:[{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b}]}}'

# 里·弓箭手的小锤40：实际伤害 4.4 / 攻速 1.3（基础值 1 / 4，故 3.4 / -2.7，见 04 §九）
T_AXE_ATTRS = [
    '{AttributeName:"minecraft:generic.attack_damage",Name:"kitpvp.tainted_axe_damage",Amount:3.4,Operation:0,UUID:[I;24,0,0,1],Slot:"mainhand"}',
    '{AttributeName:"minecraft:generic.attack_speed",Name:"kitpvp.tainted_axe_speed",Amount:-2.7,Operation:0,UUID:[I;24,0,0,2],Slot:"mainhand"}',
]
PROT = lambda lvl: ("minecraft:protection", lvl)

# 幽灵的金斧：去掉锋利 I 后靠修饰符补回实际伤害 8 / 攻速 1.1（基础值 1 / 4，故 7.0 / -2.9，见 04 §九）
G_AXE_ATTRS = [
    '{AttributeName:"minecraft:generic.attack_damage",Name:"kitpvp.ghost_axe_damage",Amount:7.0,Operation:0,UUID:[I;6,0,0,1],Slot:"mainhand"}',
    '{AttributeName:"minecraft:generic.attack_speed",Name:"kitpvp.ghost_axe_speed",Amount:-2.9,Operation:0,UUID:[I;6,0,0,2],Slot:"mainhand"}',
]

# 狼人的嗜血狼牙：实际伤害 5.5 / 攻速 1.4（基础值 1 / 4，故 4.5 / -2.6，见 04 §九）
W_AXE_ATTRS = [
    '{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:4.5,Operation:0,UUID:[I;18,0,0,1],Slot:"mainhand"}',
    '{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-2.6,Operation:0,UUID:[I;18,0,0,2],Slot:"mainhand"}',
]

# 水星的石剑：实际伤害 5 / 攻速 2.6，持有时最大生命 -10（基础值 1 / 4 / 20，见 04 §九）
M_SWORD_ATTRS = [
    '{AttributeName:"minecraft:generic.attack_damage",Name:"kitpvp.mercury_damage",Amount:4.0,Operation:0,UUID:[I;66,0,0,1],Slot:"mainhand"}',
    '{AttributeName:"minecraft:generic.attack_speed",Name:"kitpvp.mercury_attack_speed",Amount:-1.6,Operation:0,UUID:[I;66,0,0,2],Slot:"mainhand"}',
]

# 李朱俊泽的头颅：自带护甲 4 / 韧性 4，全靠 head 槽修饰符（与 kit/li_zhujunze.mcfunction 逐字一致）
L_HEAD_ATTRS = [
    '{AttributeName:"minecraft:generic.armor",Name:"kitpvp.li_armor",Amount:4,Operation:0,UUID:[I;88,0,0,1],Slot:"head"}',
    '{AttributeName:"minecraft:generic.armor_toughness",Name:"kitpvp.li_toughness",Amount:4,Operation:0,UUID:[I;88,0,0,2],Slot:"head"}',
]
# 僵尸的僵尸头：原版没有护甲值，那 1 点靠 head 槽修饰符补（与 kit/zombie.mcfunction 逐字一致）
Z_HEAD_ATTRS = [
    '{AttributeName:"minecraft:generic.armor",Name:"kitpvp.zombie_armor",Amount:1,Operation:0,UUID:[I;14,0,0,1],Slot:"head"}',
]

W = lambda iid, enc=None, attrs=None: hover(iid, enc, attrs=attrs)
FP = ("minecraft:fire_protection", 3)
UNB3 = ("minecraft:unbreaking", 3)
# 荆棘是原版附魔，最高 III；这里按车主指定写到 V（NBT 等级无上限，概率 = 15% × 等级）
THORNS5 = ("minecraft:thorns", 5)
BIND = ("minecraft:binding_curse", 1)

# 里·渔夫：装备与武器属性与 kit/tainted_fisher.mcfunction 逐字一致（UUID 段换成 29）
# 三叉戟实际伤害 5 / 攻速 1.0 ⇒ 写 4 / -3.0（基础值 1 / 4，见 04 §九）
TF_TRIDENT_ATTRS = [
    '{AttributeName:"generic.attack_damage",Name:"generic.attack_damage",Amount:4,Operation:0,UUID:[I;29,0,0,5],Slot:"mainhand"}',
    '{AttributeName:"generic.attack_speed",Name:"generic.attack_speed",Amount:-3.0,Operation:0,UUID:[I;29,0,0,6],Slot:"mainhand"}',
]
TF_FEET_ATTRS = ['{AttributeName:"generic.armor",Name:"generic.armor",Amount:2,Operation:0,UUID:[I;29,0,0,4],Slot:"feet"}']
# 鞘翅本身没有护甲值，那 2 点靠 chest 槽的修饰符补（UUID 与 kit/tainted_fisher.mcfunction 一致）
TF_CHEST_ATTRS = ['{AttributeName:"generic.armor",Name:"generic.armor",Amount:5,Operation:0,UUID:[I;29,0,0,2],Slot:"chest"}']
# 农夫的铁锄：实际伤害 5.5 / 攻速 2.0（基础值 1 / 4 ⇒ 写 4.5 / -2.0，见 04 §九）
F_HOE_ATTRS = [
    '{AttributeName:"generic.attack_damage",Name:"kitpvp.farmer_hoe",Amount:4.5,Operation:0,UUID:[I;13,0,0,1],Slot:"mainhand"}',
    '{AttributeName:"generic.attack_speed",Name:"kitpvp.farmer_hoe_speed",Amount:-2.0,Operation:0,UUID:[I;13,0,0,2],Slot:"mainhand"}',
]

# 里·战士的狂战士药水（与 kit/tainted_warrior.mcfunction 逐字一致）：力量 II 15 秒 = Id 5 / Amplifier 1 / 300 刻
_BERSERK_NAME = json.dumps({"text": "狂战士药水", "color": "red", "bold": True},
                           ensure_ascii=False, separators=(",", ":"))
W_POTION_TAG = ("{CustomPotionColor:9643043,CustomPotionEffects:[{Id:5b,Amplifier:1b,Duration:300}],"
                "display:{Name:'" + _BERSERK_NAME + "'}}")

KITS = [
    dict(id="warrior", name="战士", color="red", brief="铁甲冲锋的正面战士",
         dmg="6", spd="1.6", armor="15", tough="0", wname="铁剑", wenc=None,
         weapon=W("minecraft:iron_sword"),
         slots=[("头盔", "铁头盔", hover("minecraft:iron_helmet")),
                ("胸甲", "铁胸甲", hover("minecraft:iron_chestplate")),
                ("护腿", "铁护腿", hover("minecraft:iron_leggings")),
                ("靴子", "铁靴子", hover("minecraft:iron_boots"))],
         items=[("熟牛排 x24", hover("minecraft:cooked_beef")), ("金苹果 x1", hover("minecraft:golden_apple"))],
         passive="开局带 1 个金苹果", passiveCol="white",
         skill=("无", ""), cd=None, lives="3", livesCol="white", livesBold=False),

    dict(id="archer", name="弓箭手", color="aqua", brief="远程消耗的射手",
         dmg="5", spd="1.6", armor="11", tough="0", wname="石剑", wenc=None,
         weapon=W("minecraft:stone_sword"),
         slots=[("头盔", "皮革头盔", hover("minecraft:leather_helmet")),
                ("胸甲", "皮革胸甲", hover("minecraft:leather_chestplate")),
                ("护腿", "铁护腿", hover("minecraft:iron_leggings")),
                ("靴子", "铁靴子", hover("minecraft:iron_boots"))],
         items=[("弓", hover("minecraft:bow")), ("箭 x14", hover("minecraft:arrow")),
                ("熟牛排 x24", hover("minecraft:cooked_beef"))],
         passive="—", passiveCol="dark_gray",
         skill=("换弹", "丢出弓再捡回，箭数重置为 14"),
         cd="无（拾取即重置）", lives="3", livesCol="white", livesBold=False),

    dict(id="tank", name="坦克", color="yellow", brief="高护甲低速的肉盾",
         dmg="4", spd="1.6", armor="20", tough="0", wname="木剑", wenc=None,
         weapon=W("minecraft:wooden_sword"),
         slots=[("头盔", "钻石头盔", hover("minecraft:diamond_helmet")),
                ("胸甲", "钻石胸甲", hover("minecraft:diamond_chestplate")),
                ("护腿", "钻石护腿", hover("minecraft:diamond_leggings")),
                ("靴子", "钻石靴子", hover("minecraft:diamond_boots"))],
         items=[("熟牛排 x24", hover("minecraft:cooked_beef"))],
         passive="缓慢 I、挖掘疲劳 I", passiveCol="yellow",
         skill=("举盾", "右键「举盾」：获得 1 面 15 秒、耐久 80 的盾"),
         cd="30 秒", lives="3", livesCol="white", livesBold=False),

    dict(id="assassin", name="刺客", color="dark_purple", brief="高速突进的暗杀者",
         dmg="8", spd="1.6", armor="7", tough="0", wname="钻石剑",
         wenc=[("minecraft:sharpness", 1)],
         weapon=W("minecraft:diamond_sword", [("minecraft:sharpness", 1)]),
         slots=[("头盔", "皮革头盔（黑色）", hover("minecraft:leather_helmet", color=1908001)),
                ("胸甲", "皮革胸甲（黑色）", hover("minecraft:leather_chestplate", color=1908001)),
                ("护腿", "皮革护腿（黑色）", hover("minecraft:leather_leggings", color=1908001)),
                ("靴子", "皮革靴子（黑色）", hover("minecraft:leather_boots", color=1908001))],
         items=[("熟牛排 x24", hover("minecraft:cooked_beef"))],
         passive="永久 速度 I", passiveCol="white",
         skill=("隐匿", "右键「隐匿」：5 秒隐身 + 速度 III"),
         cd="30 秒", lives="3", livesCol="white", livesBold=False),

    dict(id="arsonist", name="纵火狂", color="gold", brief="把战场烧成灰烬的纵火者",
         dmg="5", spd="1.6", armor="10", tough="0", wname="石剑",
         wenc=[("minecraft:fire_aspect", 2)],
         weapon=W("minecraft:stone_sword", [("minecraft:fire_aspect", 2)]),
         slots=[("头盔", "皮革头盔（红色，火焰保护 III）", hover("minecraft:leather_helmet", [FP], color=11546150)),
                ("胸甲", "皮革胸甲（红色，火焰保护 III）", hover("minecraft:leather_chestplate", [FP], color=11546150)),
                ("护腿", "铁护腿（护甲 4，火焰保护 III）", hover("minecraft:iron_leggings", [FP], attrs=A_LEGS_ATTRS)),
                ("靴子", "铁靴子（火焰保护 III）", hover("minecraft:iron_boots", [FP]))],
         items=[("打火石", hover("minecraft:flint_and_steel")), ("熟牛排 x24", hover("minecraft:cooked_beef"))],
         passive="—", passiveCol="dark_gray",
         skill=("燃烧瓶", "投掷喷溅药水，落地生成 4x4 火焰，5 秒内无法手动熄灭"),
         cd="45 秒补 1（上限 2）", lives="3", livesCol="white", livesBold=False),

    dict(id="ghost", name="幽灵", color="dark_aqua", brief="只有一次生命，靠速度与隐身周旋的潜行者",
         dmg="8", spd="1.1", armor="5", tough="0", wname="金斧",
         wenc=None,
         weapon=W("minecraft:golden_axe", attrs=G_AXE_ATTRS),
         slots=[("头盔", "玩家头颅（保护 V）", hover("minecraft:player_head", [("minecraft:protection", 5)], skull="Ghost")),
                ("胸甲", "金胸甲", hover("minecraft:golden_chestplate")),
                ("护腿", "无", None),
                ("靴子", "无", None)],
         items=[("熟牛排 x24", hover("minecraft:cooked_beef"))],
         passive="永久 速度 I + 隐身 I；受到伤害时发光 1 秒", passiveCol="white",
         skill=("无", ""), cd=None, lives="1", livesCol="red", livesBold=True),

    dict(id="fisher", name="渔夫", color="blue", brief="以三叉戟与水流作战的猎手",
         dmg="7", spd="1.0", armor="8", tough="0", wname="三叉戟",
         wenc=[("minecraft:loyalty", 2)],
         weapon=W("minecraft:trident", [("minecraft:loyalty", 2)], attrs=F_TRIDENT_ATTRS),
         slots=[("头盔", "皮革头盔（护甲 2）", hover("minecraft:leather_helmet", attrs=F_HEAD_ATTRS)),
                ("胸甲", "鞘翅（保护 IV，无护甲值）", hover("minecraft:elytra", [("minecraft:protection", 4)])),
                ("护腿", "皮革护腿（护甲 4）", hover("minecraft:leather_leggings", attrs=F_LEGS_ATTRS)),
                ("靴子", "皮革靴子（护甲 2，深海探索者 III）",
                 hover("minecraft:leather_boots", [("minecraft:depth_strider", 3)], attrs=F_FEET_ATTRS))],
         items=[("鱼竿（击退 I）", hover("minecraft:fishing_rod", [("minecraft:knockback", 1)])),
                ("水桶", hover("minecraft:water_bucket")),
                ("熟牛排 x24", hover("minecraft:cooked_beef"))],
         passive="—", passiveCol="dark_gray",
         skill=("寻回三叉戟", "右键「寻戟」：找回三叉戟（离手 8 秒后）"),
         cd="30 秒", lives="3", livesCol="white", livesBold=False),

    dict(id="enderman", name="末影人", color="aqua", brief="瞬移作战的远程刺客",
         dmg="6", spd="1.6", armor="11", tough="0", wname="铁剑", wenc=None,
         weapon=W("minecraft:iron_sword"),
         slots=[("头盔", "皮革头盔（紫罗兰）", hover("minecraft:leather_helmet", color=8991416)),
                ("胸甲", "皮革胸甲（紫罗兰）", hover("minecraft:leather_chestplate", color=8991416)),
                ("护腿", "铁护腿", hover("minecraft:iron_leggings")),
                ("靴子", "铁靴子（摔落保护 III）", hover("minecraft:iron_boots", [("minecraft:feather_falling", 3)]))],
         items=[("紫颂果 x16", hover("minecraft:chorus_fruit")),
                ("末影珍珠 x3", hover("minecraft:ender_pearl")),
                ("熟牛排 x16", hover("minecraft:cooked_beef"))],
         passive="—", passiveCol="dark_gray",
         skill=("末影珍珠", "投出后自动补货，每 25 秒 1 颗、上限 3 颗"),
         cd="25 秒补 1（上限 3）", lives="3", livesCol="white", livesBold=False),

    dict(id="pirate", name="海盗", color="dark_blue", brief="依托斧头与手炮的强夺者",
         dmg="8", spd="1.0", armor="11", tough="0", wname="钻石斧", wenc=None,
         weapon=W("minecraft:diamond_axe", attrs=P_AXE_ATTRS),
         slots=[("头盔", "皮革头盔（深蓝）", hover("minecraft:leather_helmet", color=2302862)),
                ("胸甲", "皮革胸甲（深蓝）", hover("minecraft:leather_chestplate", color=2302862)),
                ("护腿", "铁护腿", hover("minecraft:iron_leggings")),
                ("靴子", "铁靴子", hover("minecraft:iron_boots"))],
         items=[("手炮", hover("minecraft:crossbow", name="手炮", name_color="dark_blue")),
                ("炮弹 x1", hover("minecraft:firework_rocket", tag=P_ROCKET_TAG)),
                ("熟牛排 x24", hover("minecraft:cooked_beef"))],
         passive="—", passiveCol="dark_gray",
         skill=("换弹", "丢出手炮并捡回，炮弹重置为 1 发"),
         cd="30 秒", lives="3", livesCol="white", livesBold=False),

    dict(id="slime", name="史莱姆", color="green", brief="灵活跳跃的杂耍者",
         dmg="5", spd="1.6", armor="13", tough="0", wname="石剑", wenc=None,
         weapon=W("minecraft:stone_sword"),
         slots=[("头盔", "铁头盔", hover("minecraft:iron_helmet")),
                ("胸甲", "绿色皮革胸甲", hover("minecraft:leather_chestplate", color=10079282)),
                ("护腿", "铁护腿", hover("minecraft:iron_leggings")),
                ("靴子", "钻石靴子（摔落保护 III）",
                 hover("minecraft:diamond_boots", [("minecraft:feather_falling", 3)]))],
         items=[("熟牛排 x24", hover("minecraft:cooked_beef"))],
         passive="永久 跳跃提升 III + 速度 I", passiveCol="green",
         skill=("无", ""), cd=None, lives="3", livesCol="white", livesBold=False),

    dict(id="tamer", name="驯兽师", color="green", brief="围绕动物的角色",
         dmg="5", spd="1.6", armor="11", tough="0", wname="石剑", wenc=None,
         weapon=W("minecraft:stone_sword"),
         slots=[("头盔", "锁链头盔（护甲 1）", hover("minecraft:chainmail_helmet")),
                ("胸甲", "锁链胸甲", hover("minecraft:chainmail_chestplate")),
                ("护腿", "锁链护腿", hover("minecraft:chainmail_leggings")),
                ("靴子", "锁链靴子", hover("minecraft:chainmail_boots"))],
         items=[("南瓜派 x24", hover("minecraft:pumpkin_pie")),
                ("骨头 x64", hover("minecraft:bone")),
                ("苹果 x32", hover("minecraft:apple")),
                ("鞍 x1", hover("minecraft:saddle")),
                ("狼蛋 x3", hover("minecraft:wolf_spawn_egg")),
                ("马蛋 x32", hover("minecraft:horse_spawn_egg")),
                ("鹦鹉蛋 x32", hover("minecraft:parrot_spawn_egg")),
                ("海豚蛋 x32", hover("minecraft:dolphin_spawn_egg")),
                ("狐狸蛋 x32", hover("minecraft:fox_spawn_egg")),
                ("青蛙蛋 x32", hover("minecraft:frog_spawn_egg")),
                ("蝌蚪蛋 x32", hover("minecraft:tadpole_spawn_egg")),
                ("海龟蛋 x32", hover("minecraft:turtle_spawn_egg")),
                ("山羊蛋 x32", hover("minecraft:goat_spawn_egg")),
                ("鲑鱼蛋 x32", hover("minecraft:salmon_spawn_egg"))],
         passive="—", passiveCol="dark_gray",
         skill=("唤狼", "每 30 秒获得 1 个狼蛋，右键放狼、用骨头驯服"),
         cd="30 秒补 1（上限 3）", lives="3", livesCol="white", livesBold=False),

    dict(id="alchemist", name="药剂师", color="dark_green", brief="用多种药水强化肉体的调配家",
         dmg="5", spd="1.6", armor="10", tough="0", wname="石剑", wenc=None,
         weapon=W("minecraft:stone_sword"),
         slots=[("头盔", "绿色皮革头盔", hover("minecraft:leather_helmet", color=3046706)),
                ("胸甲", "铁胸甲", hover("minecraft:iron_chestplate")),
                ("护腿", "绿色皮革护腿", hover("minecraft:leather_leggings", color=3046706)),
                ("靴子", "绿色皮革靴子", hover("minecraft:leather_boots", color=3046706))],
         items=[("迅捷药剂", hover("minecraft:splash_potion",
                                 tag=potion_tag("迅捷药剂", "aqua", 3394815))),
                ("再生药剂", hover("minecraft:splash_potion",
                                 tag=potion_tag("再生药剂", "light_purple", 16740264))),
                ("跳跃药剂", hover("minecraft:splash_potion",
                                 tag=potion_tag("跳跃药剂", "green", 9234010))),
                ("隐匿药剂", hover("minecraft:splash_potion",
                                 tag=potion_tag("隐匿药剂", "gray", 14211288))),
                ("抗火药水", hover("minecraft:potion",
                                 tag=potion_tag("抗火药水", "gold", 16751164))),
                ("力量药水", hover("minecraft:potion",
                                 tag=potion_tag("力量药水", "red", 12597547))),
                ("缓降药水", hover("minecraft:potion",
                                 tag=potion_tag("缓降药水", "aqua", 15263999))),
                ("神龟药水", hover("minecraft:potion",
                                 tag=potion_tag("神龟药水", "dark_green", 2600544))),
                ("熟牛排 x24", hover("minecraft:cooked_beef"))],
         passive="—", passiveCol="dark_gray",
         skills=[("药剂投掷",
                  "右键投出四瓶之一：速度 III / 再生 II / 隐身 I 各 20 秒，跳跃提升 X 10 秒；投出一瓶，其余同时收走",
                  "50 秒（补满一套）"),
                 ("本命秘药",
                  "右键饮下四瓶之一：抗火 3 分钟 / 力量 I 40 秒 / 缓降 90 秒 / 神龟（缓慢 IV + 抗性 III）40 秒；每条命一次",
                  "每条命一次（死亡重生后补满）")],
         lives="3", livesCol="white", livesBold=False),

    dict(id="farmer", name="农夫", color="yellow", brief="收获耕种果实的劳作者",
         dmg="5.5", spd="2.0", armor="11", tough="0", wname="铁锄", wenc=None,
         weapon=hover("minecraft:iron_hoe", attrs=F_HOE_ATTRS),
         slots=[("头盔", "皮革头盔", hover("minecraft:leather_helmet")),
                ("胸甲", "铁胸甲", hover("minecraft:iron_chestplate")),
                ("护腿", "皮革护腿", hover("minecraft:leather_leggings")),
                ("靴子", "铁靴子", hover("minecraft:iron_boots"))],
         items=[("工作台 x4", hover("minecraft:crafting_table")),
                ("熟牛排 x24", hover("minecraft:cooked_beef"))],
         passive="耕地或锄头命中：速度 II + 急迫 I 1 秒，并得 1 个麦种；种下麦种：50% 得 1 个小麦；吃下面包：生命恢复 II 5 秒 + 抗性提升 II 5 秒",
         passiveCol="yellow",
         skill=("无", ""), cd=None, lives="3", livesCol="white", livesBold=False),

    dict(id="zombie", name="僵尸", color="dark_green", brief="多一条血条的血牛",
         dmg="5", spd="1.6", armor="7", tough="0", wname="石剑", wenc=None,
         weapon=W("minecraft:stone_sword"),
         slots=[("头盔", "僵尸的头（无护甲）", hover("minecraft:zombie_head")),
                ("胸甲", "墨绿色皮革胸甲", hover("minecraft:leather_chestplate", color=3033902)),
                ("护腿", "墨绿色皮革护腿", hover("minecraft:leather_leggings", color=3033902)),
                ("靴子", "铁靴子", hover("minecraft:iron_boots"))],
         items=[("熟牛排 x24", hover("minecraft:cooked_beef"))],
         passive="最大生命 40（+20）；选择与每次复活获得 5 秒生命恢复 V", passiveCol="dark_green",
         skill=("无", ""), cd=None, lives="3", livesCol="white", livesBold=False),

    dict(id="werewolf", name="狼人", color="gray", brief="永不满足的嗜血追猎者",
         dmg="5.5", spd="1.4", armor="11", tough="0", wname="嗜血狼牙", wenc=None,
         weapon=hover("minecraft:stone_axe", name="嗜血狼牙", name_color="gray", attrs=W_AXE_ATTRS),
         slots=[("头盔", "灰色皮革头盔", hover("minecraft:leather_helmet", color=8421504)),
                ("胸甲", "锁链胸甲", hover("minecraft:chainmail_chestplate")),
                ("护腿", "灰色皮革护腿", hover("minecraft:leather_leggings", color=8421504)),
                ("靴子", "铁靴子", hover("minecraft:iron_boots"))],
         items=[("生羊排 x8", hover("minecraft:mutton")),
                ("嗅闻 x2", hover("minecraft:wolf_spawn_egg"))],
         passive="主武器击中玩家：饱和 I 2 刻（+2 饱食 +4 饱和），内置冷却 0.9 秒；击杀玩家：饱和 I 5 刻（+5 饱食 +10 饱和）+ 力量 I 10 秒",
         passiveCol="gray",
         skill=("嗅闻", "右键「嗅闻」：自身 5 秒速度 I；其他玩家发光 5 秒"),
         cd="40 秒补 1（上限 2）", lives="3", livesCol="white", livesBold=False),

    dict(id="bomber", name="炸弹兵", color="red", brief="以巧妙爆炸致命打击的破坏者",
         dmg="4", spd="1.6", armor="9", tough="0", wname="木剑", wenc=None,
         weapon=W("minecraft:wooden_sword"),
         slots=[("头盔", "铁头盔", hover("minecraft:iron_helmet")),
                ("胸甲", "鲜红皮革胸甲", hover("minecraft:leather_chestplate", color=16711680)),
                ("护腿", "鲜红皮革护腿", hover("minecraft:leather_leggings", color=16711680)),
                ("靴子", "铁靴子（爆炸保护 V）", hover("minecraft:iron_boots", [("minecraft:blast_protection", 5)]))],
         items=[("小炸弹", hover("minecraft:endermite_spawn_egg")),
                ("大炸弹 x2", hover("minecraft:cave_spider_spawn_egg")),
                ("假核弹", hover("minecraft:rabbit_spawn_egg")),
                ("跟踪炸弹", hover("minecraft:chicken_spawn_egg")),
                ("核弹 x4", hover("minecraft:axolotl_spawn_egg")),
                ("熟牛排 x24", hover("minecraft:cooked_beef"))],
         passive="—", passiveCol="dark_gray",
         skills=[("小炸弹", "在落点召唤瞬爆苦力怕（爆炸半径 1）", "10 秒补 1（上限 3）"),
                 ("大炸弹", "在落点召唤 0.5 秒后爆炸的苦力怕（半径 2）", "20 秒补 1（上限 2）"),
                 ("假核弹", "外观 / 提示 / 血量与核弹完全相同，只有爆炸半径是 0 —— 纯唬人", "25 秒补 1（上限 1）"),
                 ("跟踪炸弹", "在落点召唤隐形小僵尸骑着的苦力怕，6 秒后爆（半径 3）", "40 秒补 1（上限 1）"),
                 ("核弹", "在落点召唤 5 秒后爆炸的核弹（半径 63、40 血），全体聊天栏黄字提示；一次性 4 枚，不补货",
                  "无（用一枚少一枚）")],
         lives="3", livesCol="white", livesBold=False),

    dict(id="tainted_warrior", name="里·战士", cat="经典（里）", color="dark_red",
         brief="签订恶魔契约的狂暴战士",
         dmg="6", spd="1.6", armor="12", tough="0", wname="金剑",
         wenc=[("minecraft:sharpness", 3)],
         weapon=W("minecraft:golden_sword", [("minecraft:sharpness", 3)]),
         slots=[("头盔", "金头盔（耐久 III）", hover("minecraft:golden_helmet", [UNB3])),
                ("胸甲", "铁胸甲（耐久 III）", hover("minecraft:iron_chestplate", [UNB3])),
                ("护腿", "金护腿（耐久 III）", hover("minecraft:golden_leggings", [UNB3])),
                ("靴子", "金靴子（耐久 III）", hover("minecraft:golden_boots", [UNB3]))],
         items=[("熟牛排 x12", hover("minecraft:cooked_beef")),
                ("狂战士药水 x3", hover("minecraft:potion", tag=W_POTION_TAG))],
         passive="—", passiveCol="dark_gray",
         skill=("无", ""), cd=None, lives="3", livesCol="white", livesBold=False),

    dict(id="tainted_archer", name="里·弓箭手", cat="经典（里）", color="dark_red",
         brief="建立炮台摧毁敌人的射手工程师",
         dmg="4.4", spd="1.3", armor="7", tough="0", wname="小锤40", wenc=None,
         weapon=W("minecraft:stone_axe", attrs=T_AXE_ATTRS),
         slots=[("头盔", "皮革头盔（暗红，保护 II）", hover("minecraft:leather_helmet", [PROT(2)], color=11141120)),
                ("胸甲", "皮革胸甲（暗红，保护 II）", hover("minecraft:leather_chestplate", [PROT(2)], color=11141120)),
                ("护腿", "皮革护腿（暗红，保护 I）", hover("minecraft:leather_leggings", [PROT(1)], color=11141120)),
                ("靴子", "皮革靴子（暗红，保护 I）", hover("minecraft:leather_boots", [PROT(1)], color=11141120))],
         items=[("弓（换弹 4 支）", hover("minecraft:bow")), ("箭 x4", hover("minecraft:arrow")),
                ("熟牛排 x24", hover("minecraft:cooked_beef")),
                ("炮台", hover("minecraft:stray_spawn_egg")),
                ("熔火核心", hover("minecraft:blaze_spawn_egg"))],
         passive="石斧击打自家炮台可回血（每次 2 颗心，1 秒冷却）", passiveCol="green",
         skills=[("放置炮台", "右键「炮台」：落点部署骷髅炮台（20 血、免击退、力量 I 弓）；同时最多 3 座，第 4 座顶掉最旧的", "60 秒补 1（上限 3）"),
                 ("熔火核心", "右键「熔火核心」：7 格内自家炮台 30 秒熔火形态（岩浆头、金甲、抗性 IV、力量 II 火矢 II 弓）", "120 秒（上限 1）")],
         lives="3", livesCol="white", livesBold=False),

    dict(id="tainted_tank", name="里·坦克", cat="经典（里）", color="dark_red",
         brief="用荆棘反弹伤害的致命肉盾",
         dmg="4", spd="1.6", armor="20", tough="0", wname="木剑",
         wenc=[("minecraft:unbreaking", 3)],
         weapon=W("minecraft:wooden_sword", [UNB3]),
         slots=[("头盔", "钻石头盔（荆棘 V）", hover("minecraft:diamond_helmet", [THORNS5])),
                ("胸甲", "钻石胸甲（荆棘 V）", hover("minecraft:diamond_chestplate", [THORNS5])),
                ("护腿", "钻石护腿（荆棘 V）", hover("minecraft:diamond_leggings", [THORNS5])),
                ("靴子", "钻石靴子（荆棘 V）", hover("minecraft:diamond_boots", [THORNS5]))],
         items=[("熟牛排 x14", hover("minecraft:cooked_beef"))],
         passive="永久 缓慢 I + 挖掘疲劳 I；最大生命 10（常规 20 的一半）", passiveCol="yellow",
         skill=("无", ""), cd=None, lives="3", livesCol="white", livesBold=False),

    dict(id="tainted_arsonist", name="里·纵火狂", cat="经典（里）", color="dark_red",
         brief="将敌人无情点燃的消耗狂徒",
         dmg="4", spd="1.6", armor="7", tough="0", wname="木剑",
         wenc=[("minecraft:knockback", 2), ("minecraft:fire_aspect", 4)],
         weapon=W("minecraft:wooden_sword", [("minecraft:knockback", 2), ("minecraft:fire_aspect", 4)]),
         slots=[("头盔", "皮革头盔（红色，火焰保护 III）", hover("minecraft:leather_helmet", [FP], color=11546150)),
                ("胸甲", "皮革胸甲（红色，火焰保护 III）", hover("minecraft:leather_chestplate", [FP], color=11546150)),
                ("护腿", "皮革护腿（红色，火焰保护 III）", hover("minecraft:leather_leggings", [FP], color=11546150)),
                ("靴子", "皮革靴子（红色，火焰保护 III）", hover("minecraft:leather_boots", [FP], color=11546150))],
         items=[("打火石", hover("minecraft:flint_and_steel", tag="{Unbreakable:1b}")),
                ("熟牛排 x16", hover("minecraft:cooked_beef"))],
         passive="—", passiveCol="dark_gray",
         skill=("无", ""), cd=None, lives="3", livesCol="white", livesBold=False),

    dict(id="tainted_ghost", name="里·幽灵", cat="经典（里）", color="dark_red",
         brief="失明但强大的怨念化身",
         dmg="11.5", spd="1.0", armor="8", tough="2", wname="金斧",
         wenc=[("minecraft:sharpness", 8)],
         weapon=W("minecraft:golden_axe", [("minecraft:sharpness", 8)]),
         slots=[("头盔", "玩家头颅（保护 X，绑定诅咒）",
                 hover("minecraft:player_head", [PROT(10), BIND], skull="TaintedGhost")),
                ("胸甲", "钻石胸甲（保护 V，绑定诅咒）",
                 hover("minecraft:diamond_chestplate", [PROT(5), BIND])),
                ("护腿", "无", None),
                ("靴子", "无", None)],
         items=[("熟牛排 x10", hover("minecraft:cooked_beef"))],
         passive="永久 失明 I + 隐身 I + 速度 I", passiveCol="gray",
         skill=("无", ""), cd=None, lives="1", livesCol="red", livesBold=True),

    dict(id="tainted_tamer", name="里·驯兽师", cat="经典（里）", color="dark_red",
         brief="驱使亡灵与魔物作战的召唤者",
         dmg="5", spd="1.6", armor="11", tough="0", wname="石剑", wenc=None,
         weapon=W("minecraft:stone_sword"),
         slots=[("头盔", "锁链头盔（耐久 III，护甲 1）", hover("minecraft:chainmail_helmet", [UNB3])),
                ("胸甲", "锁链胸甲（耐久 III）", hover("minecraft:chainmail_chestplate", [UNB3])),
                ("护腿", "锁链护腿（耐久 III）", hover("minecraft:chainmail_leggings", [UNB3])),
                ("靴子", "锁链靴子（耐久 III）", hover("minecraft:chainmail_boots", [UNB3]))],
         items=[("亡灵仆从蛋", hover("minecraft:zombie_spawn_egg")),
                ("骸骨仆从蛋", hover("minecraft:skeleton_spawn_egg")),
                ("爆破仆从蛋", hover("minecraft:creeper_spawn_egg")),
                ("卫道仆从蛋", hover("minecraft:vindicator_spawn_egg")),
                ("巫祝仆从蛋", hover("minecraft:witch_spawn_egg")),
                ("怨灵仆从蛋", hover("minecraft:vex_spawn_egg")),
                ("灼炎仆从蛋", hover("minecraft:blaze_spawn_egg")),
                ("熟牛排 x20", hover("minecraft:cooked_beef"))],
         passive="—", passiveCol="dark_gray",
         skills=[("亡者召唤",
                  "右键投出三枚之一：僵尸（铁剑）/ 骷髅（弓）/ 苦力怕；用掉一枚，其余两枚同时收走",
                   "30 秒（补满整组）"),
                 ("魔物召唤",
                  "右键投出四枚之一：卫道士 16 / 女巫 25 / 恼鬼 20 / 烈焰人 30；用掉一枚，其余三枚同时收走",
                  "60 秒（补满整组）")],
         lives="3", livesCol="white", livesBold=False),

    dict(id="tainted_slime", name="里·史莱姆", cat="经典（里）", color="dark_red",
         brief="把跳跃蓄成一发火箭的弹跳者",
         dmg="5", spd="1.6", armor="13", tough="0", wname="石剑",
         wenc=[UNB3],
         weapon=W("minecraft:stone_sword", [UNB3]),
         slots=[("头盔", "铁头盔（耐久 III）", hover("minecraft:iron_helmet", [UNB3])),
                ("胸甲", "绿色皮革胸甲（耐久 III）", hover("minecraft:leather_chestplate", [UNB3], color=10079282)),
                ("护腿", "铁护腿（耐久 III）", hover("minecraft:iron_leggings", [UNB3])),
                ("靴子", "钻石靴子（摔落保护 III、耐久 III）",
                 hover("minecraft:diamond_boots", [("minecraft:feather_falling", 3), UNB3]))],
         items=[("熟牛排 x15", hover("minecraft:cooked_beef"))],
         passive="不在空中时按住 Shift 蓄力：跳跃提升每 4 刻升一级（I→XV），满 3 秒为 XV；起跳或松手立即归零",
         passiveCol="green",
         skill=("无", ""), cd=None, lives="3", livesCol="white", livesBold=False),

    dict(id="tainted_bomber", name="里·炸弹兵", cat="经典（里）", color="dark_red",
         brief="狂轰滥炸敌人的疯狂者",
         dmg="1", spd="4.0", armor="5", tough="0", wname="空手", wenc=None,
         weapon={"action": "show_text", "contents": [{"text": "空手：单次伤害 1，攻击速度 4.0", "color": "white"}]},
         slots=[("头盔", "无", None),
                ("胸甲", "鲜红皮革胸甲（爆炸保护 X）",
                 hover("minecraft:leather_chestplate", [("minecraft:blast_protection", 10)], color=16711680)),
                ("护腿", "纯黑皮革护腿（爆炸保护 X）",
                 hover("minecraft:leather_leggings", [("minecraft:blast_protection", 10)], color=0)),
                ("靴子", "无", None)],
         items=[("大炸弹 x4", hover("minecraft:cave_spider_spawn_egg")),
                ("跟踪炸弹 x2", hover("minecraft:chicken_spawn_egg")),
                ("核弹 x5", hover("minecraft:axolotl_spawn_egg")),
                ("熟牛排 x12", hover("minecraft:cooked_beef"))],
         passive="—", passiveCol="dark_gray",
         skills=[("大炸弹", "在落点召唤 0.5 秒后爆炸的苦力怕（半径 2）", "20 秒补 1（上限 4）"),
                 ("跟踪炸弹", "在落点召唤隐形小僵尸骑着的苦力怕，6 秒后爆（半径 3）", "20 秒补 1（上限 2）"),
                 ("核弹", "在落点召唤 5 秒后爆炸的核弹（半径 63、40 血），全体聊天栏黄字提示", "15 秒补 1（上限 5）")],
         lives="3", livesCol="white", livesBold=False),

    dict(id="tainted_fisher", name="里·渔夫", cat="经典（里）", color="dark_red",
         brief="用术式和领域掌控全场的水中猎手",
         dmg="5", spd="1.0", armor="7", tough="0", wname="三叉戟",
         wenc=[("minecraft:riptide", 1)],
         weapon=W("minecraft:trident", [("minecraft:riptide", 1)], attrs=TF_TRIDENT_ATTRS),
         slots=[("头盔", "无", None),
                ("胸甲", "鞘翅（保护 V，护甲 5）", hover("minecraft:elytra", [PROT(5)], attrs=TF_CHEST_ATTRS)),
                ("护腿", "无", None),
                ("靴子", "皮革靴子（护甲 2，深海探索者 X）",
                 hover("minecraft:leather_boots", [("minecraft:depth_strider", 10)], attrs=TF_FEET_ATTRS))],
         items=[("鱼竿（击退 I）", hover("minecraft:fishing_rod", [("minecraft:knockback", 1)])),
                ("熟鳕鱼 x24", hover("minecraft:cooked_cod")),
                ("「苍」", hover("minecraft:glow_squid_spawn_egg")),
                ("「领域展开」", hover("minecraft:squid_spawn_egg"))],
         passive="处于水中时获得 力量 I", passiveCol="aqua",
         skills=[("术式顺转·「苍」",
                  "右键「苍」：1.5 秒后在 10 格内最近敌人（无人则自己）处落半径 1 的水球（7 格，只替换空气）",
                  "45 秒"),
                 ("领域展开",
                  "右键「领域展开」：1 秒后转雨 60 秒、激流全图可用，期间力量 I；结束时停雨，自己虚弱 I + 缓慢 II 60 秒",
                  "240 秒")],
         lives="3", livesCol="white", livesBold=False),

    dict(id="sun", name="太阳", cat="星象", color="yellow", brief="免疫一切状态效果的恒星化身",
         dmg="4", spd="1.6", armor="10", tough="0", wname="金剑",
         wenc=[("minecraft:fire_aspect", 1)],
         weapon=W("minecraft:golden_sword", [("minecraft:fire_aspect", 1)]),
         slots=[("头盔", "金头盔（护甲 1）", hover("minecraft:golden_helmet")),
                ("胸甲", "金胸甲", hover("minecraft:golden_chestplate")),
                ("护腿", "金护腿", hover("minecraft:golden_leggings")),
                ("靴子", "金靴子", hover("minecraft:golden_boots"))],
         items=[("弓（火矢 I）", hover("minecraft:bow", [("minecraft:flame", 1)])),
                ("箭 x3", hover("minecraft:arrow")),
                ("熟鸡肉 x24", hover("minecraft:cooked_chicken")),
                ("太阳耀斑", hover("minecraft:bee_spawn_egg")),
                ("太阳黑子", hover("minecraft:bat_spawn_egg"))],
         passive="免疫一切状态效果（增益也一起免疫）", passiveCol="gold",
         skills=[("日冕物质抛射",
                  "丢出弓再捡回，箭数重置为 3 支；弓被别人捡走则 30 秒后归还",
                  "10 秒（拾取即重置）"),
                 ("太阳耀斑",
                  "右键「太阳耀斑」：11 格内其他玩家 5 秒通信干扰（满屏乱码）",
                  "15 秒"),
                 ("太阳黑子",
                  "右键「太阳黑子」：9 格内的其他玩家（不含自己）失明 10 秒",
                  "40 秒")],
         lives="3", livesCol="white", livesBold=False),

    dict(id="mercury", name="水星", cat="星象", color="aqua", brief="以极速与水流行动的青色行星化身",
         dmg="5", spd="2.4", armor="7", tough="0", wname="石剑", wenc=None,
         weapon=W("minecraft:stone_sword", attrs=M_SWORD_ATTRS),
         slots=[("头盔", "青色皮革头盔", hover("minecraft:leather_helmet", color=1481884)),
                ("胸甲", "青色皮革胸甲", hover("minecraft:leather_chestplate", color=1481884)),
                ("护腿", "青色皮革护腿", hover("minecraft:leather_leggings", color=1481884)),
                ("靴子", "青色皮革靴子（保护 III，深海探索者 X）",
                 hover("minecraft:leather_boots",
                       [("minecraft:protection", 3), ("minecraft:depth_strider", 10)], color=1481884))],
         items=[("水桶", hover("minecraft:water_bucket")),
                ("熟鳕鱼 x16", hover("minecraft:cooked_cod"))],
         passive="移动速度 +0.2；最大生命 13（比常规少 7）",
         passiveCol="aqua",
         skill=("无", ""), cd=None, lives="3", livesCol="white", livesBold=False),

    dict(id="venus", name="金星", cat="星象", color="gold", brief="带着舔狗作战的灼热行星化身",
         dmg="2.5", spd="1.0", armor="12", tough="0", wname="铁铲", wenc=None,
         weapon=W("minecraft:iron_shovel"),
         slots=[("头盔", "铁头盔", hover("minecraft:iron_helmet")),
                ("胸甲", "金胸甲", hover("minecraft:golden_chestplate")),
                ("护腿", "金护腿", hover("minecraft:golden_leggings")),
                ("靴子", "铁靴子", hover("minecraft:iron_boots"))],
         items=[("制冷模块", hover("minecraft:polar_bear_spawn_egg")),
                ("武装模块", hover("minecraft:evoker_spawn_egg")),
                ("自爆模块", hover("minecraft:silverfish_spawn_egg")),
                ("熟猪排 x16", hover("minecraft:cooked_porkchop"))],
         passive="开局获得一只自动驯服的舔狗（常驻 速度 I + 抗性提升 V，随死亡保留）",
         passiveCol="gold",         skills=[("制冷模块",
                  "右键「制冷模块」：舔狗 10 格内敌人每秒叠一层缓慢，5 秒到缓慢 V，离开后逐级回落",
                  "30 秒"),
                 ("武装模块",
                  "右键「武装模块」：舔狗获得 速度 II、力量 II、跳跃提升 V，持续 20 秒",
                  "60 秒"),
                 ("自爆模块",
                  "右键「自爆模块」：在舔狗脚下引爆一只苦力怕（正常爆炸、无前摇），"
                  "舔狗随后死亡，30 秒后在你身边复活",
                  "30 秒（与复活计时同步）")],
         lives="3", livesCol="white", livesBold=False),

    dict(id="tainted_farmer", name="里·农夫", cat="经典（里）", color="dark_green", brief="让耕作化作暴动的起义者",
         dmg="5.5", spd="1.0", armor="11", tough="0", wname="铁铲",
         wenc=[("minecraft:sharpness", 1)],
         weapon=W("minecraft:iron_shovel", [("minecraft:sharpness", 1)]),
         slots=[("头盔", "皮革头盔（耐久 III）", hover("minecraft:leather_helmet", [UNB3])),
                ("胸甲", "铁胸甲（耐久 III）", hover("minecraft:iron_chestplate", [UNB3])),
                ("护腿", "皮革护腿（耐久 III）", hover("minecraft:leather_leggings", [UNB3])),
                ("靴子", "铁靴子（耐久 III）", hover("minecraft:iron_boots", [UNB3]))],
         items=[("工作台 x4", hover("minecraft:crafting_table")),
                ("烤马铃薯 x24", hover("minecraft:baked_potato")),
                ("开始一场起义", hover("minecraft:mooshroom_spawn_egg")),
                ("召集农民", hover("minecraft:husk_spawn_egg"))],
         passive="与表农夫同款耕地被动：速度 II + 急迫 I 1 秒并得麦种；播种 50% 得 1 个小麦；吃面包再生 II 5 秒 + 抗性 II 5 秒",
         passiveCol="dark_green",
         skills=[("开始一场起义",
                  "召出 250 血的农民起义领袖（常驻力量 II + 速度 I），每 12 秒召一只石锄农民，"
                  "另有每 12 秒由随机一只石锄农民召一只木锄农民；上限 8 / 12",
                  "开局 1 个蛋，用掉不补"),
                 ("召集农民",
                  "随机把最多 10 只「农民」（地球召唤的同名农民也算）传送到落点",
                  "上限 1，60 秒冷却")],
         lives="3", livesCol="white", livesBold=False),

    dict(id="earth", name="地球", cat="星象", color="blue", brief="围绕地球的职业",
         dmg="3", spd="4.0", armor="13", tough="2", wname="工作台",
         wenc=[("minecraft:sharpness", 3)],
         weapon=W("minecraft:crafting_table", [("minecraft:sharpness", 3)]),
         slots=[("头盔", "铁头盔", hover("minecraft:iron_helmet")),
                ("胸甲", "高饱和蓝皮革胸甲（荆棘 II）",
                 hover("minecraft:leather_chestplate", [("minecraft:thorns", 2)], color=26367)),
                ("护腿", "钻石护腿", hover("minecraft:diamond_leggings")),
                ("靴子", "铁靴子", hover("minecraft:iron_boots"))],
         items=[("召唤生灵 x3", hover("minecraft:goat_spawn_egg")),
                ("熟猪排 x24", hover("minecraft:cooked_porkchop"))],
         passive="—", passiveCol="dark_gray",
         skills=[("召唤生灵",
                  "右键投出召唤蛋，随机召来一只友善生灵（33 种）；上限 3 个",
                  "15 秒补 1 个")],
         lives="3", livesCol="white", livesBold=False),

    dict(id="pluto", name="冥王星", cat="星象", color="dark_blue", brief="体积微小的遗弃行星化身",
         dmg="5", spd="1.6", armor="2", tough="0", wname="石剑", wenc=None,
         weapon=W("minecraft:stone_sword"),
         slots=[("头盔", "—", None),
                ("胸甲", "—", None),
                ("护腿", "皮革护腿", hover("minecraft:leather_leggings")),
                ("靴子", "—", None)],
         items=[("熟牛排 x24", hover("minecraft:cooked_beef"))],
         passive="永久隐身 + 抗性提升 V；鹦鹉分身「冥王星」一死，本体立刻跟着死", passiveCol="dark_blue",
         skill=("无", ""), cd=None, lives="3", livesCol="white", livesBold=False),

    dict(id="civil", name="文明小子", cat="抽象", color="light_purple", brief="惩奸除恶的板砖美猴王",
         dmg="4", spd="4.0", armor="14", tough="-1", wname="木棍",
         wenc=[("minecraft:sharpness", 5)],
         weapon=W("minecraft:stick", [("minecraft:sharpness", 5)]),
         slots=[("头盔", "高饱和绿皮革头盔", hover("minecraft:leather_helmet", color=65280)),
                ("胸甲", "铁胸甲", hover("minecraft:iron_chestplate")),
                ("护腿", "锁链护腿", hover("minecraft:chainmail_leggings")),
                ("靴子", "钻石靴子", hover("minecraft:diamond_boots"))],
         items=[("红砖（击退 II）", hover("minecraft:brick", [("minecraft:knockback", 2)])),
                ("口水 x3", hover("minecraft:splash_potion",
                                 tag=potion_tag("口水", "green", 11724960,
                                                ["{Id:9b,Amplifier:1b,Duration:400,ShowParticles:0b}"]))),
                ("恶魔形态令牌", hover("minecraft:strider_spawn_egg")),
                ("熟牛排 x24", hover("minecraft:cooked_beef"))],
         passive="—", passiveCol="dark_gray",
         skills=[("口水",
                  "右键投出口水：落地时 4 格内的玩家（含投掷者）获得反胃 II 20 秒；"
                  "持有上限 3 瓶，每 4 秒补 1 瓶",
                  "补货 4 秒 1 瓶（投出即开始计时，计时中再投不重置）"),
                 ("恶魔形态",
                  "右键「恶魔形态」令牌：60 秒内口水整套换成恶魔口水（反胃 II 20 秒 + 力量 7.5 秒）；"
                  "主武器换成烈焰棒（锋利 V + 火焰附加 I），红砖换成恶魔板砖（击退 III）；"
                  "永久失去锁链护腿",
                  "180 秒（持续 60 秒）")],
         lives="3", livesCol="white", livesBold=False),

    dict(id="li_zhujunze", name="李朱俊泽", cat="抽象", color="dark_purple",
         brief="围绕李朱俊泽的职业",
         dmg="6", spd="1.6", armor="4", tough="0", wname="大将军",
         wenc=[("minecraft:smite", 5), ("minecraft:bane_of_arthropods", 5)],
         weapon=W("minecraft:iron_sword", [("minecraft:smite", 5), ("minecraft:bane_of_arthropods", 5)]),
         slots=[("头盔", "玩家头颅（爆炸保护 10，护甲 4，韧性 4）",
                 hover("minecraft:player_head", [("minecraft:blast_protection", 100)],
                       skull="LiZhujunze", attrs=L_HEAD_ATTRS)),
                ("胸甲", "无", None),
                ("护腿", "无", None),
                ("靴子", "无", None)],
         items=[("iLsacuL 蛋 x5", hover("minecraft:pig_spawn_egg")),
                ("熟牛排 x24", hover("minecraft:cooked_beef"))],
         passive="—", passiveCol="dark_gray",
         skills=[("召唤 iLsacuL",
                  "右键放出一只 iLsacuL（20 血、不消失）；上限 3 个",
                  "补货 10 秒 1 个"),
                 ("iLsacuL 循环",
                  "只要该职业在场就每 12 秒转一圈：第 3 秒所有 iLsacuL 原地复制一只 200 血个体；"
                  "第 6 秒它们在原地以半径 5 自爆（苦力怕名为李朱俊泽）；第 9 秒无事；"
                  "第 12 秒若场上 iLsacuL ≥14 只，则每刻以半径 8 自爆直到一只不剩",
                  "自动（不占冷却）")],
         lives="3", livesCol="white", livesBold=False),
]

TOP = "┌──────────────────────────────"
BOT = "└──────────────────────────────"


def lbl(t):
    return {"text": t, "color": "gray"}


def line(*comps):
    return "tellraw @s " + json.dumps(list(comps), ensure_ascii=False, separators=(",", ":"))


# 把描述里的数值挑出来单独上色（车主 2026-11-10：高亮最直观的数值）
_NUM = re.compile(r"(\d+(?:\.\d+)?(?:%|秒|刻|格|点|个|次|颗|只|块|件|发|支|瓶|级|金币)?)")


def rich(text, color="white", num_color="gold"):
    out = []
    for seg in _NUM.split(text):
        if not seg:
            continue
        out.append({"text": seg, "color": num_color if _NUM.fullmatch(seg) else color})
    return out


def build(k):
    o = []
    o.append(line({"text": TOP, "color": "dark_gray"}))
    o.append(line(lbl("│ 职业名："), {"text": k["name"], "color": k["color"], "bold": True}))
    o.append(line(lbl("│ 分类："), {"text": k.get("cat", "经典（表）"), "color": "white"}))
    o.append(line(lbl("│ 简介："), {"text": k["brief"], "color": "white"}))

    num = {"text": k["dmg"], "color": "white", "hoverEvent": k["weapon"]}
    summary = (f"武器：{k['wname']}\n"
               f"单次伤害：{k['dmg']}    攻击速度：{k['spd']}\n"
               f"附魔：{enc_text(k['wenc'])}")
    hint = {"text": "（悬停查看详情）", "color": "dark_gray",
            "hoverEvent": {"action": "show_text", "contents": [{"text": summary, "color": "white"}]}}
    o.append(line(lbl("│ 武器单次伤害："), num, hint))
    o.append(line(lbl("│ 武器攻击速度："), {"text": k["spd"], "color": "white"}))
    o.append(line(lbl("│ 总护甲值："), {"text": k["armor"], "color": "white"}))
    # 韧性 0 是大多数职业的默认，没必要占一行（车主 2026-11-10 的要求）
    if str(k["tough"]).strip() not in ("0", "0.0"):
        o.append(line(lbl("│ 总护甲韧性："), {"text": k["tough"], "color": "white"}))

    for slot, text, h in k["slots"]:
        val = {"text": text, "color": "white" if h else "dark_gray"}
        if h:
            val["hoverEvent"] = h
        o.append(line(lbl(f"│ {slot}："), val))

    comps = [lbl("│ 物品：")]
    for i, (text, h) in enumerate(k["items"]):
        if i:
            comps.append({"text": "、"})
        it = {"text": text, "color": "white"}
        if h:
            it["hoverEvent"] = h
        comps.append(it)
    o.append(line(*comps))

    o.append(line(*([lbl("│ 被动：")] + rich(k["passive"], k["passiveCol"]))))
    skills = k.get("skills")
    if skills:
        for sname, sdesc, scd in skills:
            o.append(line(lbl("│ 技能："), {"text": sname, "color": "yellow"},
                          {"text": " —— " + sdesc, "color": "white"}))
            if scd:
                o.append(line(lbl("│ 技能冷却："), *rich(scd)))
    else:
        sname, sdesc = k["skill"]
        if sdesc:
            o.append(line(lbl("│ 技能："), {"text": sname, "color": "yellow"},
                          *rich(" —— " + sdesc)))
        else:
            o.append(line(lbl("│ 技能："), {"text": "无", "color": "white"}))
        if k["cd"]:
            o.append(line(lbl("│ 技能冷却："), *rich(k["cd"])))
    lives = {"text": k["lives"], "color": k["livesCol"]}
    if k["livesBold"]:
        lives["bold"] = True
    o.append(line(lbl("│ 命数："), lives))
    o.append(line({"text": BOT, "color": "dark_gray"}))
    o.append(line(
        {"text": "[ 确认选择 ]", "color": "green", "bold": True,
         "clickEvent": {"action": "run_command", "value": f"/function kitpvp:kit/{k['id']}"},
         "hoverEvent": {"action": "show_text", "contents": [{"text": f"以{k['name']}参战", "color": "gray"}]}},
        {"text": "  "},
        {"text": "[ 返回 ]", "color": "yellow",
         "clickEvent": {"action": "run_command", "value": "/function kitpvp:lobby/menu"},
         "hoverEvent": {"action": "show_text", "contents": [{"text": "回到主大厅菜单", "color": "gray"}]}}))
    return "\r\n".join(o) + "\r\n"


for k in KITS:
    with open(os.path.join(OUT, k["id"] + ".mcfunction"), "w", encoding="utf-8", newline="") as f:
        f.write(build(k))
print("wrote", len(KITS), "cards")

# 生成完顺手再做一遍数值高亮：模板里的 rich() 覆盖不到"总护甲值/韧性"和附魔等级（罗马数字），
# 这一步把 32 张卡（含手写的 炸弹兵 / 里职业系列）统一处理，规则见 tools/highlight_cards.py
try:
    import highlight_cards
    highlight_cards.main()
except Exception as exc:
    print("!! 高亮后处理失败:", exc)

