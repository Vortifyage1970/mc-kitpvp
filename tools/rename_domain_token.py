#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""把里·附魔师的令牌改名成「领域展开：坐杀博徒」。

命名对齐里·渔夫的令牌（那个就叫「领域展开」），只改显示名与说明文字，
NBT 判据（KitDomain / 蝙蝠蛋）一个字节都不动。
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FUN = ROOT / "src/data/kitpvp/functions"

REPL = [
    # 物品名
    ('"text":"坐杀博徒·入场券"', '"text":"领域展开：坐杀博徒"'),
    # 物品 Lore 第一行
    ('右键使用：展开领域「坐杀博徒」', '右键使用：领域展开「坐杀博徒」'),
    # 职业卡：物品行
    ('、「坐杀博徒·入场券」', '、「领域展开：坐杀博徒」'),
    # 职业卡：技能行
    ('：右键入场券展开 60 秒赌场', '：右键「领域展开」开 60 秒赌场'),
    # 选职业提示 / 命中提示
    ('常态不能蓄力：用「坐杀博徒·入场券」开场', '常态不能蓄力：用「领域展开：坐杀博徒」开场'),
    ('用「坐杀博徒·入场券」开赌场', '用「领域展开：坐杀博徒」开赌场'),
    # 注释
    ('右键「坐杀博徒·入场券」（蝙蝠蛋）', '右键「领域展开：坐杀博徒」（蝙蝠蛋）'),
    ('坐杀博徒入场券使用次数', '领域展开：坐杀博徒 使用次数'),
]


def main() -> None:
    total = 0
    for p in FUN.rglob("*.mcfunction"):
        text = p.read_text(encoding="utf-8")
        out = text
        for old, new in REPL:
            out = out.replace(old, new)
        if out != text:
            p.write_text(out, encoding="utf-8", newline="\n")
            total += 1
            print("patched", p.relative_to(FUN))
    print("files touched:", total)
    left = [p for p in FUN.rglob("*.mcfunction")
            if "坐杀博徒·入场券" in p.read_text(encoding="utf-8")]
    print("remaining old name:", [str(p.name) for p in left])


if __name__ == "__main__":
    main()
