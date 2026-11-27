#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""给所有职业的盔甲加 1.20.1 纹饰（Trim）。纯视觉，零属性。

设计：材质 = 阵营色（远处分阵营），图案 = 职业原型（近处分职业）。
表 / 里 的同一原型共用同一图案 —— 一眼能看出"里·战士"是"战士"的腐化版。

用法：
    python tools/gen_trims.py [--dry]
幂等：重跑会先摘掉已有 Trim 再重塞，改分配只需改下面的 ASSIGN。
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
KIT = ROOT / "src/data/kitpvp/functions/kit"

# ---- 阵营 → 材质（trims 材质白名单里的取值）----
FACTION_MAT = {
    "classic": "quartz",      # 表：月白
    "tainted": "redstone",    # 里：暗红
    "chaos": "netherite",     # 混沌：黑金
    "astral": "amethyst",     # 星象：紫晶
    "meme": "copper",         # 抽象：橙铜
    "history": "gold",        # 历史：金
    "guild": "emerald",       # 职业职业：翠
}

# ---- kit 文件 → (阵营, 图案) ----
ASSIGN = {
    # ===== 表 classic =====
    "warrior":         ("classic", "sentry"),      # 哨兵：制式
    "archer":          ("classic", "dune"),        # 沙丘：斜纹像箭羽
    "tank":            ("classic", "ward"),        # 守望：护心镜
    "assassin":        ("classic", "silent"),      # 寂静：若隐若现
    "arsonist":        ("classic", "raiser"),      # 上扬：火苗
    "ghost":           ("classic", "vex"),         # 恼鬼：飘
    "fisher":          ("classic", "tide"),        # 潮汐
    "pirate":          ("classic", "coast"),       # 海岸
    "enderman":        ("classic", "host"),        # 宿主：虚空寄体
    "slime":           ("classic", "shaper"),      # 塑形：软块
    "tamer":           ("classic", "snout"),       # 鼻：野兽
    "alchemist":       ("classic", "wild"),        # 荒野：草药
    "farmer":          ("classic", "rib"),         # 肋骨：田垄
    "zombie":          ("classic", "eye"),         # 眼：发光的眼
    "werewolf":        ("classic", "wayfinder"),   # 寻路：追猎
    "bomber":          ("classic", "spire"),       # 尖塔：爆裂的尖刺

    # ===== 里 classic_tainted（与表一一对应）=====
    "tainted_warrior":   ("tainted", "sentry"),
    "tainted_archer":    ("tainted", "dune"),
    "tainted_tank":      ("tainted", "ward"),
    "tainted_arsonist":  ("tainted", "raiser"),
    "tainted_ghost":     ("tainted", "vex"),
    "tainted_fisher":    ("tainted", "tide"),
    "tainted_tamer":     ("tainted", "snout"),
    "tainted_slime":     ("tainted", "shaper"),
    "tainted_bomber":    ("tainted", "spire"),
    "tainted_enderman":  ("tainted", "host"),
    "tainted_farmer":    ("tainted", "rib"),

    # ===== 混沌 =====
    "chaos":        ("chaos", "sentry"),
    "chaos_archer": ("chaos", "dune"),

    # ===== 星象 =====
    "sun":     ("astral", "raiser"),   # 日冕上扬
    "mercury": ("astral", "tide"),     # 水银流动
    "venus":   ("astral", "shaper"),   # 爱与美
    "earth":   ("astral", "host"),     # 生命宿主
    "halley":  ("astral", "dune"),     # 彗尾斜扫
    "mars":    ("astral", "spire"),    # 战争尖刺
    "pluto":   ("astral", "silent"),   # 隐身

    # ===== 抽象 =====
    "civil":       ("meme", "wild"),
    "burger":      ("meme", "snout"),
    "li_zhujunze": ("meme", "ward"),   # 只有玩家头，实际不会上纹饰

    # ===== 历史 =====
    "zhuzhiwu": ("history", "ward"),

    # ===== 职业职业 =====
    "zhanshishi": ("guild", "host"),    # 陷阱：寄体
    "enchanter":  ("guild", "vex"),
    "tainted_enchanter": ("tainted", "vex"),   # 里·附魔师：同附魔     # 附魔：神秘
    "poisoner":   ("guild", "eye"),     # 斩杀：凝视
}

# 能上纹饰的只有这 6 种材质的 4 个部位；elytra / 头 / air 一律跳过
TRIMMABLE = re.compile(
    r"^minecraft:(leather|iron|golden|chainmail|diamond|netherite)_(helmet|chestplate|leggings|boots)$"
)
TRIM_RE = re.compile(r",?Trim:\{[^{}]*\}")

LINE_RE = re.compile(
    r"^(?P<prefix>item replace entity @s armor\.(?:head|chest|legs|feet) with )"
    r"(?P<item>minecraft:[a-z_]+)(?P<nbt>\{.*?\})?(?P<cnt> \d+)?$"
)
GIVE_RE = re.compile(
    r"^(?P<prefix>give @s )(?P<item>minecraft:[a-z_]+)(?P<nbt>\{.*?\})?(?P<cnt> \d+)?$"
)


def apply(line: str, mat: str, pat: str) -> tuple[str, bool]:
    for rx in (LINE_RE, GIVE_RE):
        m = rx.match(line)
        if not m:
            continue
        prefix, item = m.group("prefix"), m.group("item")
        nbt, cnt = m.group("nbt") or "", m.group("cnt") or ""
        if not TRIMMABLE.match(item):
            return line, False
        nbt = TRIM_RE.sub("", nbt)
        trim = 'Trim:{material:"minecraft:%s",pattern:"minecraft:%s"}' % (mat, pat)
        if nbt:
            assert nbt.endswith("}")
            nbt = nbt[:-1] + ("," if not nbt.endswith("{") else "") + trim + "}"
        else:
            nbt = "{" + trim + "}"
        return prefix + item + nbt + cnt, True
    return line, False


def main() -> None:
    dry = "--dry" in sys.argv
    files = lines_ = 0
    missing = []
    for stem, (fac, pat) in sorted(ASSIGN.items()):
        p = KIT / (stem + ".mcfunction")
        if not p.exists():
            missing.append(stem)
            continue
        mat = FACTION_MAT[fac]
        src = p.read_text(encoding="utf-8").splitlines()
        out, n = [], 0
        for line in src:
            if line.strip().startswith("#"):
                out.append(line)
                continue
            new, changed = apply(line, mat, pat)
            out.append(new)
            n += 1 if changed else 0
        if n:
            files += 1
            lines_ += n
            print("%-20s %-8s %-8s %-11s %d" % (stem, fac, mat, pat, n))
            if not dry:
                open(p, "w", encoding="utf-8", newline="\n").write("\n".join(out) + "\n")
    print("\n合计 %d 个职业 / %d 行%s" % (files, lines_, "（dry run）" if dry else ""))
    if missing:
        print("未找到:", ", ".join(missing))


if __name__ == "__main__":
    main()