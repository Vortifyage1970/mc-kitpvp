#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""修里·附魔师「右键令牌只蹦出一只蝙蝠」：快照分没初始化。

player_tick 的派发是 `if score used > score last`。
`minecraft.used:*_spawn_egg` 由游戏自己递增，`*_last` 只能我们写；
但代码里除了 cast/redraw 自己推进，没有任何地方给过初值 ——
1.20.1 里「比较一个不存在的分数」恒为假，所以第一次用就没触发，
之后 last 永远缺失，永远不触发（死锁）。
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FUN = ROOT / "src/data/kitpvp/functions"

INIT = [
    "scoreboard players set @s kitpvp.ench_domain_last 0",
    "scoreboard players set @s kitpvp.ench_egg_last 0",
]
ANCHOR = "scoreboard players set @s kitpvp.ench_domain_ready 0"

DEBUG = """# 里·附魔师状态自检（右键令牌没反应时先跑这个）
say ——— 里·附魔师自检 ———
tellraw @s [{"text":"kit=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.kit"}},{"text":"  alive=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.alive"}},{"text":"  对局状态=","color":"gray"},{"score":{"name":"#state","objective":"kitpvp.game"}}]
tellraw @s [{"text":"领域标记：","color":"gray"},{"text":"（有就是展开中）","color":"gray"}]
execute if entity @s[tag=kitpvp.ench_domain] run tellraw @s [{"text":"  领域展开中","color":"green"}]
execute unless entity @s[tag=kitpvp.ench_domain] run tellraw @s [{"text":"  未展开","color":"red"}]
tellraw @s [{"text":"剩余刻=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_t"}},{"text":"  冷却=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_cd"}},{"text":"  免冷却次数=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_ready"}}]
tellraw @s [{"text":"令牌 used=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_used"}},{"text":"  last=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_domain_last"}}]
tellraw @s [{"text":"赌徒蛋 used=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_egg_used"}},{"text":"  last=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_egg_last"}}]
tellraw @s [{"text":"剑等级=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_sword"}},{"text":"  甲等级=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_armor"}}]
"""


def patch_pick() -> None:
    p = FUN / "kit/tainted_enchanter.mcfunction"
    lines = p.read_text(encoding="utf-8").splitlines()
    if INIT[0] in lines:
        print("pick already initialised")
        return
    out = []
    for line in lines:
        out.append(line)
        if line.strip() == ANCHOR:
            out.extend(INIT)
    p.write_text("\n".join(out) + "\n", encoding="utf-8", newline="\n")
    print("pick initialised")


def write_debug() -> None:
    p = FUN / "debug/li_ench_state.mcfunction"
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(DEBUG, encoding="utf-8", newline="\n")
    print("debug written", p.name)


def main() -> None:
    patch_pick()
    write_debug()


if __name__ == "__main__":
    main()
