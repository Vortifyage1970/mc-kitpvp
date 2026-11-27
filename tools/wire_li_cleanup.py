#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""把里·附魔师的收尾清理接进玩家清空与终局重置。

之前只有 kit/tainted_enchanter 里自己清几项，死了/终局掉线复活的玩家会留着
attack_damage 修饰符（利刃/锋利）和 ench_domain 标签，下一局白嫖伤害或直接
开着领域上场。
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FUN = ROOT / "src/data/kitpvp/functions"


def append_once(path: Path, anchor: str, addition: str) -> None:
    text = path.read_text(encoding="utf-8")
    if addition.strip() in text:
        print("already wired:", path.name)
        return
    assert anchor in text, "anchor not found in %s" % path
    text = text.replace(anchor, anchor + addition, 1)
    path.write_text(text, encoding="utf-8", newline="\n")
    print("wired:", path.name)


def main() -> None:
    append_once(
        FUN / "util/clear_player.mcfunction",
        "attribute @s minecraft:generic.armor_toughness base set 0\n",
        "function kitpvp:skill/li_ench/cleanup_one\n",
    )
    append_once(
        FUN / "game/reset.mcfunction",
        "bossbar set kitpvp:li_a8 value 0\n",
        "execute as @a run function kitpvp:skill/li_ench/cleanup_one\n",
    )


if __name__ == "__main__":
    main()
