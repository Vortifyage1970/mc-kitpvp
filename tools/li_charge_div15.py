#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""四档蓄力最终值：0／1／2／3 档 = 10／20／30／40 格（原值 1/15）。
逐档重写，避免连锁替换把中间档吃掉。"""
import re
from pathlib import Path

P = Path(__file__).resolve().parent.parent / "src/data/kitpvp/functions/skill/li_ench/pull_charge.mcfunction"
FILL = {0: 10, 1: 20, 2: 30, 3: 40}
TEXT = {0: "+0.03 点", 1: "+0.07 点", 2: "+0.1 点", 3: "+0.13 点"}


def main() -> None:
    out = []
    for line in P.read_text(encoding="utf-8").splitlines():
        m = re.search(r"#li_x kitpvp\.game matches (\d) run scoreboard players add @s kitpvp\.(ench_sw_fill|ench_ap_fill) \d+", line)
        if m:
            tier, obj = int(m.group(1)), m.group(2)
            line = "execute if score #li_x kitpvp.game matches %d run scoreboard players add @s kitpvp.%s %d" % (tier, obj, FILL[tier])
        m = re.search(r"#li_x kitpvp\.game matches (\d) run title @s actionbar", line)
        if m:
            tier = int(m.group(1))
            line = ('execute if score #li_x kitpvp.game matches %d run title @s actionbar '
                    '[{"text":"◆ 蓄力 %s","color":"light_purple"},{"text":"（剑与甲）","color":"gray"}]'
                    % (tier, TEXT[tier]))
        out.append(line)
    P.write_text("\n".join(out) + "\n", encoding="utf-8", newline="\n")
    print("rewrote", P.name)


if __name__ == "__main__":
    main()
