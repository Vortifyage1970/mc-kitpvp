#!/usr/bin/env python3
"""混沌战士（kit 45）武器池 v2 —— 生成所有相关函数。

机制（2026-11-12 与车主敲定）：
- 主手永远只有一把"耗材"武器：真实耐久（方案 B）负责耐久条演出 + 记分板负责真判定。
  发出来时 Damage 已经贴到 max-(次数+2)，所以条子一直是"快断了"，但不会真碎——
  数到 0 时 clear 主手、播损坏音、立刻发下一把（无缝，不会有空手窗口）。
- 计数来源：
  · 近战/方块类：advancement（player_hurt_entity）→ kit/chaos_hit
  · 弓 / 弩 / 三叉戟：minecraft.used:<item> 涨了 → kit/chaos_shot_*
- 被动写在武器自身（AttributeModifiers / 附魔）；只有"隐身"没法用属性，走 tick 挂 effect。
- lore 在 display.Lore，一行一条。

扩池子：往 WEAPONS 加一条 dict，重跑本脚本。
"""
from __future__ import annotations

import json
import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
KIT = os.path.join(ROOT, "src", "data", "kitpvp", "functions", "kit")

MAX_DURA = {
    "minecraft:iron_sword": 250, "minecraft:diamond_sword": 1561, "minecraft:diamond_axe": 1561,
    "minecraft:stone_sword": 131, "minecraft:wooden_sword": 59,
    "minecraft:golden_sword": 32, "minecraft:iron_axe": 250,
    "minecraft:stone_axe": 131, "minecraft:golden_axe": 32,
    "minecraft:wooden_axe": 59, "minecraft:trident": 250,
    "minecraft:iron_shovel": 250, "minecraft:shears": 238,
    "minecraft:iron_hoe": 250,
    "minecraft:bow": 384, "minecraft:crossbow": 465,
}

# kind: melee / bow / xbow / tri
WEAPONS = [
    dict(item="minecraft:iron_sword", uses=3, kind="melee", dmg=5, spd=-2.4,
         lore=["默认并不代表着弱小。", "相反，它们故意使其强大，为了盛宴的传播与喝采。"]),
    dict(item="minecraft:diamond_sword", uses=2, kind="melee", dmg=6, spd=-2.4,
         ench=[("minecraft:sharpness", 1)], extra=[("generic.movement_speed", 0.2, 2)],
         lore=["熟练，锐利。他们是佼佼者，身后是无名的尸体。",
               "耗材一般的他们这么想着，永远刺不穿那虚无的隔层。"]),
    dict(item="minecraft:bow", uses=3, kind="bow", arrows=3,
         lore=["瞬息万变的世界不会容许片刻犹豫。",
               "拉弓搭箭的那刻，他们曾想过真正属于他们的战场会是这样的吗？"]),
    dict(name="水星剑", custom=True, item="minecraft:stone_sword", uses=2, kind="melee", dmg=4, spd=-1.6,
         extra=[("generic.max_health", -7, 0), ("generic.movement_speed", 2.0, 2)],
         lore=["以为速度可以逃离一切的它没有注意到插入心脏的熟悉利刃。"]),
    dict(item="minecraft:stone_sword", uses=3, kind="melee", dmg=4, spd=-2.4,
         ench=[("minecraft:fire_aspect", 1)],
         lore=["混乱与癫狂支配着他们，意味着他们绝对无法想象真正的混沌。"]),
    dict(item="minecraft:stone_sword", uses=4, kind="melee", dmg=4, spd=-2.4,
         lore=["这不过是一场游戏而已。", "如此认为的他们并未如预想中陷入劣势。"]),
    dict(item="minecraft:diamond_axe", uses=1, kind="melee", dmg=7, spd=-3.0,
         lore=["他们最先习惯了世界的变革。", "毕竟予取予求者不用思考来处，只须打开来路。"]),
    dict(item="minecraft:golden_sword", uses=3, kind="melee", dmg=3, spd=-2.4,
         ench=[("minecraft:fire_aspect", 1)],
         lore=["它每天都在升起，没有人问过它是否愿意。"]),
    dict(item="minecraft:bow", uses=2, kind="bow", arrows=2,
         ench=[("minecraft:flame", 1)],
         lore=["权柄。别无所需。"]),
    dict(name="大型手炮", custom=True, item="minecraft:crossbow", uses=1, kind="xbow",
         ench=[("minecraft:multishot", 1)], charged_firework=True,
         lore=["“人人为我......后半句怎么说来着？”"]),
    dict(item="minecraft:wooden_sword", uses=1, kind="melee", dmg=3, spd=-2.4,
         ench=[("minecraft:fire_aspect", 4), ("minecraft:knockback", 2)],
         lore=["“让火焰烬化一切！”"]),
    dict(name="小锤40", custom=True, item="minecraft:stone_axe", uses=3, kind="melee", dmg=5, spd=-3.0,
         name_color="dark_red",
         lore=["“Build them up, break them down.”"]),
    dict(name="嗜血狼牙", custom=True, item="minecraft:stone_axe", uses=3, kind="melee", dmg=4.5, spd=-2.6,
         werewolf=True, name_color="dark_red",
         lore=["离群者而不是害群之马。", "这是他们回归的唯一机会。"]),
    dict(item="minecraft:trident", uses=4, kind="tri", dmg=7, spd=-3.1,
         ench=[("minecraft:loyalty", 2)],
         lore=["淳朴的他们大多不理解现状。",
               "但当那长度与他们不相称的兵器飞回时，他们都熟习地接在手中。"]),
    dict(item="minecraft:trident", uses=4, kind="tri", dmg=4, spd=-3.1,
         ench=[("minecraft:riptide", 1)],
         lore=["“我的学生们还在看着我呢，再让我耍会帅吧”"]),
    dict(item="minecraft:iron_shovel", uses=3, kind="melee", dmg=3.5, spd=-3.0,
         lore=["它们一致认为它会使仪式变得无趣。", "沥沥流出的鲜血是它最后无力的辩驳。"]),
    dict(item="minecraft:golden_axe", uses=4, kind="melee", dmg=7, spd=-2.9,
         invisible=True,
         lore=["他早已死过一次，所以现在只是重复动作。"]),
    dict(item="minecraft:crafting_table", uses=3, kind="melee",
         ench=[("minecraft:sharpness", 3)],
         lore=["无数悲叹的灵魂徘徊在其掌心。", "无法带来乐趣之人会被回收。"]),
    dict(name="诅咒剑", custom=True, item="minecraft:golden_sword", uses=5, kind="melee", dmg=1, spd=-2.4,
         ench=[("minecraft:unbreaking", 3)], curse=True,
         lore=["人们总是幻想电信号的集合可以轻易地改变世界。",
               "诅咒，破坏，恶咒。真正落到自己头上的，却是真切有形的战斧。"]),
    dict(name="大将军", custom=True, item="minecraft:iron_sword", uses=3, kind="melee", dmg=5, spd=-2.4,
         ench=[("minecraft:smite", 5), ("minecraft:bane_of_arthropods", 5)],
         lore=["不想成为那个身份的他令人失望。", "他的扮演者们是跳梁小丑，从来不懂真正的尊严。"]),
    dict(item="minecraft:iron_hoe", uses=4, kind="melee", dmg=4.5, spd=-2.0,
         lore=["种瓜得瓜，种豆得豆。",
               "劳作真正化为成果那一刻，他们立即断绝了对原来世界的念想。"]),
]

U = "45,0,0,"
KIND_TAG = {"melee": "ChaosMelee", "bow": "ChaosBow", "xbow": "ChaosXbow", "tri": "ChaosTri"}
FIREWORK = ('{id:"minecraft:firework_rocket",Count:1b,tag:{Fireworks:{Flight:1,Explosions:['
            '{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b}]}}}')


def item_snbt(index: int, w: dict) -> str:
    item = w["item"]
    uses = w["uses"]
    maxd = MAX_DURA.get(item, 0)
    tags = ["ChaosBlade:1b", f"ChaosId:{index}b", f"ChaosUses:{uses}b", KIND_TAG[w["kind"]] + ":1b"]
    if maxd:
        # 斧类每次攻击消耗 2 点耐久（原版行为），预埋时按 cost 放大，保证计数没到 0 之前武器不会真碎
        cost = 2 if item.endswith("_axe") else 1
        # 会不会"碎"完全交给记分板 chaos_uses；Unbreakable 防止多重射击 / 斧类多耗耐久把武器提前打没
        tags.append("Unbreakable:1b")
        tags.append("Damage:%ds" % max(0, maxd - uses * cost - 2))
    if w.get("werewolf"):
        tags.append("KitWerewolfAxe:1b")
    if w.get("curse"):
        tags.append("ChaosCurse:1b")
    if w.get("invisible"):
        tags.append("ChaosInvisible:1b")
    attrs = []
    if "dmg" in w:
        attrs.append('{AttributeName:"minecraft:generic.attack_damage",Name:"kit.damage",Amount:%s,Operation:0,UUID:[I;%s1],Slot:"mainhand"}' % (w["dmg"], U))
    if "spd" in w:
        attrs.append('{AttributeName:"minecraft:generic.attack_speed",Name:"kit.speed",Amount:%s,Operation:0,UUID:[I;%s2],Slot:"mainhand"}' % (w["spd"], U))
    for i, (attr, amount, op) in enumerate(w.get("extra", []), start=3):
        attrs.append('{AttributeName:"minecraft:%s",Name:"kit.x%d",Amount:%s,Operation:%d,UUID:[I;%s%d],Slot:"mainhand"}' % (attr, i, amount, op, U, i))
    body = list(tags)
    if attrs:
        body.append("AttributeModifiers:[" + ",".join(attrs) + "]")
    display = []
    if w.get("custom"):
        display.append("Name:'" + json.dumps({"text": w["name"], "color": w.get("name_color", "dark_purple"), "italic": False}, ensure_ascii=False) + "'")
    if w["lore"]:
        display.append("Lore:[" + ",".join(
            "'" + json.dumps({"text": line, "color": "dark_purple", "italic": False}, ensure_ascii=False) + "'"
            for line in w["lore"]) + "]")
    if display:
        body.append("display:{" + ",".join(display) + "}")
    if w.get("charged_firework"):
        body.append("Charged:1b")
        body.append("ChargedProjectiles:[" + FIREWORK + "]")
    if w.get("ench"):
        body.append("Enchantments:[" + ",".join(
            '{id:"minecraft:%s",lvl:%ds}' % (e[0].split(":")[1], e[1]) for e in w["ench"]) + "]")

    return item + "{" + ",".join(body) + "}"


def give_block(index: int, w: dict) -> list[str]:
    item = item_snbt(index, w)
    # 主手空着才写主手；主手拿着别的东西（牛排、望远镜）就 give，绝不覆盖
    # 只用 give：绝不 item replace（主手可能是牛排/望远镜），也避免"先 replace 后 give"那种一次两把
    out = ["give @s %s 1" % item,
           "scoreboard players set @s kitpvp.chaos_uses %d" % w["uses"]]
    # 三叉戟扔出去时主手已经空了，只能靠这个 tag 记住"当前这把会飞回来"
    out.append("tag @s add kitpvp.chaos_tri" if w["kind"] == "tri" else "tag @s remove kitpvp.chaos_tri")
    if w.get("arrows"):
        out.append("give @s minecraft:arrow %d" % w["arrows"])
    if w.get("rocket"):
        out.append("give @s minecraft:firework_rocket{KitPirateRocket:1b,Fireworks:{Flight:1,Explosions:[{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b},{Type:1,Colors:[I;13158],Trail:1b}]}} %d" % w["rocket"])
    return out


def main() -> int:
    n = len(WEAPONS)
    # 清场函数：每行都带 if data 守卫（clear 匹配 0 个会中止整份函数）
    items = sorted({w["item"] for w in WEAPONS})
    wipe = ["# 由 tools/gen_chaos.py 生成：清掉玩家身上所有混沌武器（任何格子），望远镜不碰",
            "tag @s remove kitpvp.chaos_tri",
            "# 每行先用 if data 守卫：clear 匹配到 0 个会让整份函数中止，没有守卫时后面的清不掉",
            "# clear 不写 maxCount（默认清全部）"]
    for it in items:
        wipe.append('execute if data entity @s Inventory[{tag:{ChaosBlade:1b},id:"%s"}] run clear @s %s{ChaosBlade:1b}' % (it, it))
    # 忠诚三叉戟扔出去后是一个独立实体：武器用尽时它也得清掉，否则会飞回来变成白嫖的第二把
    # 1.20.1 里飞行中的三叉戟把物品存在 Trident 字段（不是 Item）
    wipe.append('execute at @s run kill @e[type=minecraft:trident,nbt={Trident:{tag:{ChaosBlade:1b}}},distance=..96]')
    open(os.path.join(KIT, "chaos_wipe.mcfunction"), "w", encoding="utf-8", newline="\n").write("\n".join(wipe) + "\n")

    open(os.path.join(KIT, "chaos_start.mcfunction"), "w", encoding="utf-8", newline="\n").write(
        "# 混沌战士：开局/重生发第一把「默认」\nfunction kitpvp:kit/chaos_wipe\n" + "\n".join(give_block(1, WEAPONS[0])) + "\n")

    lines = ["# 武器用尽：随机发下一把（池子大小由 tools/gen_chaos.py 写出）",
             "# 发之前先把带 ChaosBlade 标签的武器全清掉（任何格子），杜绝叠刀",
             "function kitpvp:kit/chaos_wipe",
             "scoreboard players set @s kitpvp.rng 0"]
    for bit in (1, 2, 4, 8, 16, 32, 64):
        lines.append("execute if predicate kitpvp:random/1in2 run scoreboard players add @s kitpvp.rng %d" % bit)
    lines.append("scoreboard players set #chaos_pool kitpvp.game %d" % n)
    lines.append("scoreboard players operation @s kitpvp.rng %= #chaos_pool kitpvp.game")
    for i in range(n):
        lines.append("execute if score @s kitpvp.rng matches %d run function kitpvp:kit/chaos_give_%d" % (i, i + 1))
    open(os.path.join(KIT, "chaos_next.mcfunction"), "w", encoding="utf-8", newline="\n").write("\n".join(lines) + "\n")

    for i, w in enumerate(WEAPONS, start=1):
        open(os.path.join(KIT, "chaos_give_%d.mcfunction" % i), "w", encoding="utf-8", newline="\n").write(
            "\n".join(give_block(i, w)) + "\n")

    open(os.path.join(KIT, "chaos_use.mcfunction"), "w", encoding="utf-8", newline="\n").write(
"""# 消耗一次：数到 0 就碎（记分板是权威，武器耐久条只是演出）
scoreboard players remove @s kitpvp.chaos_uses 1
execute unless score @s kitpvp.chaos_uses matches 1.. run function kitpvp:kit/chaos_break
""")
    open(os.path.join(KIT, "chaos_break.mcfunction"), "w", encoding="utf-8", newline="\n").write(
"""# 武器损坏：不改主手（主手可能是牛排/望远镜），只按 tag 清混沌武器再发下一把
playsound minecraft:entity.item.break master @s ~ ~ ~ 1.0 1.0
function kitpvp:kit/chaos_next
""")
    open(os.path.join(KIT, "chaos_hit.mcfunction"), "w", encoding="utf-8", newline="\n").write(
"""# 打到人（advancement 触发）：只对近战类武器计数
advancement revoke @s only kitpvp:player/chaos_hit
# 诅咒剑：先判定（chaos_use 可能在第五次命中时就换掉手里的武器）
execute if score @s kitpvp.kit matches 45 if data entity @s SelectedItem.tag.ChaosCurse run function kitpvp:skill/mars/target
execute if score @s kitpvp.kit matches 45 if data entity @s SelectedItem.tag.ChaosMelee run function kitpvp:kit/chaos_use
""")
    for kind, obj in (("bow", "chaos_bow"), ("xbow", "chaos_xbow"), ("tri", "chaos_tri")):
        cond = ("tag=kitpvp.chaos_tri" if kind == "tri" else None)
        if kind == "tri":
            body = """# 三叉戟扔出去那一刻手上已经空了（而且忠诚会飞回来），所以只能按"当前武器是三叉戟"的 tag 判定
scoreboard players operation @s kitpvp.%s_last = @s kitpvp.%s_used
execute if entity @s[tag=kitpvp.chaos_tri] run function kitpvp:kit/chaos_use
""" % (obj, obj)
        else:
            body = """# 弓/弩用了一次：推进快照，若手上是对应类武器就扣一次
scoreboard players operation @s kitpvp.%s_last = @s kitpvp.%s_used
execute if data entity @s SelectedItem.tag.%s run function kitpvp:kit/chaos_use
""" % (obj, obj, KIND_TAG[kind])
        open(os.path.join(KIT, "chaos_shot_%s.mcfunction" % kind), "w", encoding="utf-8", newline="\n").write(body)

    open(os.path.join(KIT, "chaos.mcfunction"), "w", encoding="utf-8", newline="\n").write(
"""# 混沌战士（kit = 45）：铁盔 + 锁链胸甲 + 锁链护腿 + 锁链靴（合计护甲 12）
# 手上永远一把"耗材"：耐久 2~5 次，用完记分板清零 → 清主手、播损坏音、无缝发下一把（见 kit/chaos_use）
function kitpvp:util/clear_player

scoreboard players set @s kitpvp.kit 45
tag @s add kitpvp.selected
scoreboard players set @s kitpvp.alive 1

item replace entity @s armor.head with minecraft:iron_helmet{Unbreakable:1b}
item replace entity @s armor.chest with minecraft:chainmail_chestplate{Unbreakable:1b}
item replace entity @s armor.legs with minecraft:chainmail_leggings{Unbreakable:1b}
item replace entity @s armor.feet with minecraft:chainmail_boots{Unbreakable:1b}
scoreboard players set @s kitpvp.lives 3
function kitpvp:kit/chaos_start

give @s minecraft:cooked_beef 13
give @s minecraft:spyglass{ChaosToken:1b,Unbreakable:1b,display:{Name:'{"text":"混沌重铸","color":"dark_purple","italic":false}',Lore:['{"text":"右键：清掉手上的武器，随机重铸一把（冷却 30 秒）","color":"dark_purple","italic":false}']}} 1
tellraw @s [{"text":"已选择 ","color":"gray"},{"text":"混沌战士","color":"dark_purple","bold":true}]
playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2
""")
    print("weapons:", n)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
