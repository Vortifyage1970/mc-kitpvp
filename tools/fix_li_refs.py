#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""修 li_ench 里从表附魔师搬过来没改到位的调用，并把 kit 99 接进随机职业池。

1) fill_sw / fill_ap / ench_check 属于共用升级管线，仍在 skill/enchanter/ 下；
   li_ench 只是换名了 domain_* -> start/end/tick_domain，所以这几处要指回去。
2) kit/random.mcfunction：新职业要进全池映射（#pool_size +1 + 末尾一行）。
幂等：重跑不会重复插入。
"""
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parent.parent
FUN = ROOT / "src/data/kitpvp/functions"
LI = FUN / "skill/li_ench"

REPL = {
    "kitpvp:skill/li_ench/fill_sw": "kitpvp:skill/enchanter/fill_sw",
    "kitpvp:skill/li_ench/fill_ap": "kitpvp:skill/enchanter/fill_ap",
    "kitpvp:skill/li_ench/ench_check": "kitpvp:skill/enchanter/ench_check",
    "kitpvp:skill/li_ench/domain_start": "kitpvp:skill/li_ench/start",
    "kitpvp:skill/li_ench/domain_end": "kitpvp:skill/li_ench/end",
}


def fix_refs() -> int:
    n = 0
    for p in LI.rglob("*.mcfunction"):
        text = p.read_text(encoding="utf-8")
        out = text
        for old, new in REPL.items():
            out = out.replace(old, new)
        if out != text:
            p.write_text(out, encoding="utf-8", newline="\n")
            n += 1
    return n


def add_to_random() -> None:
    p = FUN / "kit/random.mcfunction"
    text = p.read_text(encoding="utf-8")
    if "kitpvp.kit 99" in text:
        return
    m = re.search(r"^scoreboard players set #pool_size kitpvp\.game (\d+)$", text, re.M)
    assert m, "pool_size line missing"
    old_size = int(m.group(1))
    text = text.replace(m.group(0),
                        "scoreboard players set #pool_size kitpvp.game %d" % (old_size + 1),
                        1)
    # 末尾追加映射（保持文件末尾换行）
    text = text.rstrip("\n") + (
        "\n# 里·附魔师（坐杀博徒），2026-11-28 加入全池\n"
        "execute if score @s kitpvp.rng matches %d run scoreboard players set @s kitpvp.kit 99\n"
        % old_size
    )
    p.write_text(text, encoding="utf-8", newline="\n")


def main() -> None:
    n = fix_refs()
    add_to_random()
    print("li refs fixed in %d files; kit 99 added to random pool" % n)


if __name__ == "__main__":
    main()
