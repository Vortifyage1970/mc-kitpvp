#!/usr/bin/env python3
"""从 kit/*.mcfunction 生成职业选择大厅的展示架、压力板和 pad_enter 坐标表。

用法：
    python tools/gen_lobby.py

生成（直接写进 src/data/kitpvp/functions/lobby/）：
    build_pads.mcfunction    压力板 setblock
    build_stands.mcfunction  展示架 summon（先清 kitpvp.kit_stand）
    build.mcfunction         先铺板再摆架（进游戏跑这一条）
    pad_enter.mcfunction     踩板弹职业卡的坐标表

为什么生成而不是手摆：31 个职业的装备里带 display.color / Enchantments / Kit* 私有 tag /
AttributeModifiers（会显示在悬停提示里），手抄一次就会和 kit/ 漂移。这里把 kit/ 当唯一数据源。
新增职业时：在 ROWS 里加一行、在 POSES 里补一个姿势，重跑本脚本。
"""
from __future__ import annotations

import json
import os
import re
import struct
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
KIT_DIR = os.path.join(ROOT, "src", "data", "kitpvp", "functions", "kit")
OUT_DIR = os.path.join(ROOT, "src", "data", "kitpvp", "functions", "lobby")

# ---------------------------------------------------------------- 装备解析

SLOT_TO_ARMOR = {"armor.feet": 0, "armor.legs": 1, "armor.chest": 2, "armor.head": 3}
GEAR = re.compile(r"item replace entity @s (armor\.[a-z]+|weapon\.(?:mainhand|offhand)|hotbar\.(\d+)) with (\S+)")
# 有些职业的"手上那把"是 give 出去的（弓 / 钓竿 / 金苹果 / 金斧），盔甲也有 give 头盔的：
# 按 id 后缀认一下，只取第一个空槽，避免把牛排、箭、刷怪蛋塞进架子手里。
GIVE = re.compile(r"^give @s (\S+)", re.M)
HELD_SUFFIX = ("_sword", "_axe", "_pickaxe", "_shovel", "_hoe", "bow", "crossbow", "trident",
               "fishing_rod", "shield", "golden_apple", "potion")
ARMOR_SUFFIX = ("helmet", "chestplate", "leggings", "boots", "_head", "_skull")


def split_item(token: str):
    """minecraft:iron_helmet{...} -> ("minecraft:iron_helmet", "{...}" / None)"""
    if "{" in token:
        i = token.index("{")
        return token[:i], token[i:]
    return token, None


def kit_gear(name: str) -> dict:
    """读出职业的头/胸/腿/脚、主手、副手（缺的槽位返回 None）。"""
    path = os.path.join(KIT_DIR, name + ".mcfunction")
    text = open(path, encoding="utf-8").read()
    armor = [None, None, None, None]  # feet, legs, chest, head
    hands = [None, None]
    hotbar = []
    for m in GEAR.finditer(text):
        slot, bar, token = m.group(1), m.group(2), m.group(3)
        item = split_item(token)
        if slot in SLOT_TO_ARMOR:
            armor[SLOT_TO_ARMOR[slot]] = item
        elif slot == "weapon.mainhand":
            hands[0] = item
        elif slot == "weapon.offhand":
            hands[1] = item
        elif bar is not None:
            hotbar.append((int(bar), item))
    # 快捷栏里的东西按槽位顺序补进空着的手（0 号先算主手，其次副手）；
    # 只认"能拿在手上展示"的 id，别把牛排 / 南瓜派塞进架子手里
    def held(item):
        item_id = item[0].replace("minecraft:", "")
        return any(item_id.endswith(sfx) for sfx in HELD_SUFFIX)

    for _idx, item in sorted(hotbar):
        if not held(item):
            continue
        if hands[0] is None:
            hands[0] = item
        elif hands[1] is None:
            hands[1] = item
    for m in GIVE.finditer(text):
        item = split_item(m.group(1))
        item_id = item[0].replace("minecraft:", "")
        if any(item_id.endswith(sfx) for sfx in ARMOR_SUFFIX):
            order = [3, 2, 1, 0] if item_id.endswith(("helmet", "_head", "_skull")) else \
                    [2] if item_id.endswith("chestplate") else \
                    [1] if item_id.endswith("leggings") else [0]
            for slot in order:
                if armor[slot] is None:
                    armor[slot] = item
                    break
        elif any(item_id.endswith(sfx) for sfx in HELD_SUFFIX):
            if hands[0] is None:
                hands[0] = item
            elif hands[1] is None:
                hands[1] = item
    return {"armor": armor, "hands": hands}


def item_nbt(item) -> str:
    if not item:
        return "{}"
    item_id, tag = item
    if tag:
        return '{id:"%s",Count:1b,tag:%s}' % (item_id, tag)
    return '{id:"%s",Count:1b}' % item_id


# ---------------------------------------------------------------- 布点表
# kit 名 → (压力板 x, 压力板 y, 压力板 z, 架子 x, 架子 y, 架子 z, 朝向, DisabledSlots)
# 架子统一放在板正后方半格：表 A 排朝北(180)、表 B 排与里翼朝南(0)。

ROWS = [
    {
        "name": "经典 A 排",
        "pads": [(-226 - 4 * i, 71, 98) for i in range(9)],
        "stand_dz": 1.5,
        "rot": 180.0,
        "slots": 0,
        "kits": ["warrior", "archer", "tank", "assassin", "arsonist",
                 "ghost", "pirate", "enderman", "slime"],
    },
    {
        "name": "经典 B 排",
        "pads": [(-226 - 4 * i, 71, 90) for i in range(6)],
        "stand_dz": -0.5,
        "rot": 0.0,
        "slots": 0,
        "kits": ["alchemist", "tamer", "fisher", "zombie", "bomber", "werewolf"],
    },
    {
        "name": "里翼 1 排",
        "pads": [(227 + 4 * i, 68, 93) for i in range(8)],
        "stand_dz": -0.5,
        "rot": 0.0,
        "slots": 2039552,
        "kits": ["tainted_warrior", "tainted_archer", "tainted_tank", "tainted_arsonist",
                 "tainted_ghost", "tainted_slime", "tainted_tamer", "tainted_fisher"],
    },
    {
        "name": "里翼 2 排",
        "pads": [(227 + 4 * i, 68, 101) for i in range(2)],
        "stand_dz": 0.5,
        "rot": 180.0,
        "slots": 2039552,
        "kits": ["tainted_bomber", "tainted_enderman"],
    },
]

# 重建前先清掉这四排壁龛里的旧架子（含手动摆的、只带 kitpvp.displayitem 的那批）。
# 盒子精确框在壁龛里，别扩到别处去。
SWEEP = [
    ("x=-259,y=71,z=99,dx=35,dy=3,dz=1", "经典 A 排壁龛"),
    ("x=-259,y=71,z=88,dx=35,dy=3,dz=1", "经典 B 排壁龛"),
    ("x=226,y=68,z=92,dx=30,dy=3,dz=1", "里翼 1 排壁龛"),
    ("x=226,y=68,z=101,dx=30,dy=3,dz=1", "里翼 2 排壁龛"),
]

# ---------------------------------------------------------------- 姿势表
# 每个职业一套 Pose（度）。已有 11 个照抄存档里的原值，其余按职业气质新写。
# 数值可以随便改：改完重跑脚本即可。

POSE = {
    # ---- 表·经典 A 排（原样保留） ----
    "warrior":        dict(Head=(0, 0, 0),   Body=(0, 0, 0),    RightArm=(-120, 0, 0),   LeftArm=(10, 0, 0),    RightLeg=(0, 0, 0),   LeftLeg=(0, 0, 0)),
    "archer":         dict(Head=(0, 0, 0),   Body=(0, 0, 0),    RightArm=(-90, 0, -40),  LeftArm=(-90, 0, 0),   RightLeg=(0, 0, 0),   LeftLeg=(0, 0, 0)),
    "tank":           dict(Head=(5, 0, 0),   Body=(0, 0, 0),    RightArm=(-40, 0, -15),  LeftArm=(90, 100, 25), RightLeg=(0, 0, 0),   LeftLeg=(0, 0, 0)),
    "assassin":       dict(Head=(20, 0, 0),  Body=(30, 0, 0),   RightArm=(-80, 0, -15),  LeftArm=(40, 0, 20),   RightLeg=(-40, 0, 0), LeftLeg=(40, 0, 0)),
    "arsonist":       dict(Head=(20, 0, 25), Body=(10, 0, -15), RightArm=(-150, 0, 20),  LeftArm=(-100, 0, -70), RightLeg=(15, 0, 0), LeftLeg=(-15, 0, 0)),
    "pirate":         dict(Head=(0, 0, 0),   Body=(0, 0, 0),    RightArm=(-90, -30, 0),  LeftArm=(-75, 0, 15),  RightLeg=(15, 0, 0),  LeftLeg=(-15, 0, 0)),
    "enderman":       dict(Head=(0, 0, 0),   Body=(0, 0, 0),    RightArm=(20, 0, 10),    LeftArm=(-110, 0, -10), RightLeg=(-30, 0, 0), LeftLeg=(30, 0, 0)),
    "slime":          dict(Head=(-10, 0, 0), Body=(15, 0, 0),   RightArm=(90, 0, -30),   LeftArm=(-120, 0, 30), RightLeg=(-60, 0, 0), LeftLeg=(30, 0, 0)),
    # ---- 表·幽灵（空手前倾，像在飘） ----
    "ghost":          dict(Head=(-10, 0, 0), Body=(-5, 0, 0),   RightArm=(-30, 0, -20),  LeftArm=(-30, 0, 20),  RightLeg=(8, 0, 0),   LeftLeg=(-8, 0, 0)),
    # ---- 表·经典 B 排（新写） ----
    "alchemist":      dict(Head=(10, 0, 0),  Body=(0, 0, 0),    RightArm=(-120, 0, -20), LeftArm=(-70, 0, 20),  RightLeg=(5, 0, 0),   LeftLeg=(-5, 0, 0)),
    "tamer":          dict(Head=(10, 0, 0),  Body=(25, 0, 0),   RightArm=(-95, 0, -10),  LeftArm=(-40, 0, 30),  RightLeg=(-45, 0, 0), LeftLeg=(45, 0, 0)),
    "fisher":         dict(Head=(10, 0, 0),  Body=(10, 0, 0),   RightArm=(-70, 0, -20),  LeftArm=(-90, 0, 30),  RightLeg=(10, 0, 0),  LeftLeg=(-10, 0, 0)),
    "zombie":         dict(Head=(0, 0, 0),   Body=(0, 0, 0),    RightArm=(-90, 0, 0),    LeftArm=(-90, 0, 0),   RightLeg=(0, 0, 0),   LeftLeg=(0, 0, 0)),
    "bomber":         dict(Head=(15, 0, 0),  Body=(5, 0, 0),    RightArm=(-110, 0, 10),  LeftArm=(-20, 0, -10), RightLeg=(8, 0, 0),   LeftLeg=(-8, 0, 0)),
    "werewolf":       dict(Head=(-20, 0, 0), Body=(40, 0, 0),   RightArm=(-40, 0, -45),  LeftArm=(-40, 0, 45),  RightLeg=(-15, 0, 0), LeftLeg=(15, 0, 0)),
    # ---- 里翼（前 3 个照抄存档，其余按"更极端"新写） ----
    "tainted_warrior": dict(Head=(10, 0, 15), Body=(20, 0, -10), RightArm=(-150, 0, -15), LeftArm=(-40, 0, 50), RightLeg=(-25, 0, 0), LeftLeg=(25, 0, 0)),
    "tainted_archer":  dict(Head=(5, 15, 0), Body=(10, 0, -8),  RightArm=(-130, -25, 15), LeftArm=(-75, 0, -45), RightLeg=(-25, 0, 0), LeftLeg=(20, 0, 0)),
    "tainted_tank":    dict(Head=(-15, 0, 0), Body=(-15, 0, 0), RightArm=(-30, 0, 60),   LeftArm=(-30, 0, -60), RightLeg=(-10, 0, 15), LeftLeg=(10, 0, -15)),
    # 里·纵火狂：木剑刚挥出去，人已经扭头在跑
    "tainted_arsonist": dict(Head=(0, 170, 0), Body=(-10, 0, 25), RightArm=(-125, 0, -35), LeftArm=(-60, 0, 40), RightLeg=(30, 0, 0), LeftLeg=(-40, 0, 0)),
    # 里·幽灵：双臂张开、头歪着飘
    "tainted_ghost":   dict(Head=(10, 0, 30), Body=(10, 0, 0),  RightArm=(-150, 0, -30), LeftArm=(-60, 0, 40), RightLeg=(10, 0, 0),  LeftLeg=(-10, 0, 0)),
    # 里·史莱姆：深蹲蓄力，准备火箭跳
    "tainted_slime":   dict(Head=(-25, 0, 0), Body=(10, 0, 0),  RightArm=(35, 0, -15),   LeftArm=(35, 0, 15),  RightLeg=(-20, 0, 10), LeftLeg=(-20, 0, -10)),
    # 里·驯兽师：指着前方，指挥仆从大军
    "tainted_tamer":   dict(Head=(-5, 0, 0),  Body=(5, 0, 0),   RightArm=(-88, 0, 0),    LeftArm=(10, 0, 20),  RightLeg=(10, 0, 0),  LeftLeg=(-10, 0, 0)),
    # 里·渔夫：三叉戟高举要砸下来
    "tainted_fisher":  dict(Head=(-10, 0, 0), Body=(15, 0, 0),  RightArm=(-160, 0, 10),  LeftArm=(-120, 0, -40), RightLeg=(15, 0, 0), LeftLeg=(-15, 0, 0)),
    # 里·末影人：举着传送枪平瞄，另一只手向后
    "tainted_enderman": dict(Head=(0, 0, 0),  Body=(5, 0, -8),  RightArm=(-86, 0, -6),  LeftArm=(15, 0, -30),  RightLeg=(12, 0, 0),  LeftLeg=(-12, 0, 0)),
    # 里·炸弹兵：彻底疯掉——双臂上扬外翻、头歪、后仰、两腿岔开
    "tainted_bomber":  dict(Head=(-20, 0, 40), Body=(-20, 0, 0), RightArm=(-160, 0, -60), LeftArm=(-160, 0, 60), RightLeg=(10, 0, 20), LeftLeg=(10, 0, -20)),
}

DEFAULT_POSE = dict(Head=(0, 0, 0), Body=(0, 0, 0), RightArm=(-90, 0, 0),
                    LeftArm=(-90, 0, 0), RightLeg=(0, 0, 0), LeftLeg=(0, 0, 0))
PARTS = ("Head", "Body", "RightArm", "LeftArm", "RightLeg", "LeftLeg")


def pose_nbt(kit: str) -> str:
    pose = POSE.get(kit, DEFAULT_POSE)
    body = ",".join("%s:[%sf,%sf,%sf]" % (p, float(pose.get(p, (0, 0, 0))[0]),
                                          float(pose.get(p, (0, 0, 0))[1]),
                                          float(pose.get(p, (0, 0, 0))[2])) for p in PARTS)
    return "{" + body + "}"


# ---------------------------------------------------------------- 生成

def main() -> int:
    stands, pads, enters = [], [], []
    for row in ROWS:
        kits = row["kits"]
        assert len(kits) == len(row["pads"]), row["name"]
        for kit, (px, py, pz) in zip(kits, row["pads"]):
            gear = kit_gear(kit)
            sx, sy, sz = px + 0.5, py, pz + row["stand_dz"]
            armor = ",".join(item_nbt(i) for i in gear["armor"])
            hands = ",".join(item_nbt(i) for i in gear["hands"])
            stands.append(
                "# %s  板(%d,%d,%d)" % (kit, px, py, pz)
                + "\nsummon minecraft:armor_stand %s %s %s {Tags:[\"kitpvp.kit_stand\"],Rotation:[%.1ff,0.0f],"
                  "ShowArms:1b,Invulnerable:1b,DisabledSlots:%d,"
                  "Attributes:[{Name:\"minecraft:generic.knockback_resistance\",Base:1.0}],"
                  "ArmorItems:[%s],HandItems:[%s],Pose:%s}"
                % (sx, sy, sz, row["rot"], row["slots"], armor, hands, pose_nbt(kit))
            )
            pads.append("setblock %d %d %d minecraft:light_weighted_pressure_plate" % (px, py, pz))
            enters.append("execute if entity @s[x=%d,y=%d,z=%d,dx=1,dy=1,dz=1] run function kitpvp:kit/info/%s"
                          % (px, py, pz, kit))

    head = "# 本文件由 tools/gen_lobby.py 生成，别手改（改生成器里的 ROWS / POSE 后重跑）\n"
    sweep = "".join(
        "# %s\nkill @e[type=minecraft:armor_stand,%s]\n" % (why, box)
        for box, why in SWEEP
    )
    open(os.path.join(OUT_DIR, "build_stands.mcfunction"), "w", encoding="utf-8", newline="\n").write(
        head + "# 清掉上一版（只清自己这套，别碰地图里的装饰架子）\n"
        "kill @e[tag=kitpvp.kit_stand]\n"
        "# 再清掉四排壁龛里手动摆的旧架子（框死在壁龛里）\n"
        + sweep
        + "\n" + "\n".join(stands) + "\n")
    open(os.path.join(OUT_DIR, "build_pads.mcfunction"), "w", encoding="utf-8", newline="\n").write(
        head + "\n".join(pads) + "\n")
    open(os.path.join(OUT_DIR, "build.mcfunction"), "w", encoding="utf-8", newline="\n").write(
        head + "function kitpvp:lobby/build_pads\n"
        "function kitpvp:lobby/build_stands\n"
        "say [大厅] 职业展示已重建（%d 个架子 / %d 块压力板）\n" % (len(stands), len(pads)))
    open(os.path.join(OUT_DIR, "pad_enter.mcfunction"), "w", encoding="utf-8", newline="\n").write(
        "# 压力板 → 职业介绍分流：x/y/z 是压力板方块自身的坐标，dx=dy=dz=1 恰好覆盖该方块。\n"
        "# 本文件由 tools/gen_lobby.py 生成：坐标表来自生成器的 ROWS，别再手抄（会和压力板漂移）。\n"
        "tag @s add kitpvp.on_pad\n\n" + "\n".join(enters) + "\n")

    print("架子 %d / 压力板 %d / pad_enter %d 行" % (len(stands), len(pads), len(enters)))
    missing = [kit for row in ROWS for kit in row["kits"] if kit not in POSE]
    if missing:
        print("!! 没写姿势，用默认：", ", ".join(missing))
    return 0


if __name__ == "__main__":
    sys.exit(main())
