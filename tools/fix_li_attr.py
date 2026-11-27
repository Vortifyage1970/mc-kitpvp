#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""里·附魔师两张攻击力卡与 tmp_expire 用了 1.20.1 不认的 attribute 写法，
导致整份函数加载失败（日志：Whilst parsing command on line 4: 无效的UUID）。
1.20.1 是 `modifier add <uuid> <name> <value> <operation>`，remove 只认 uuid。

draw.mcfunction 还用了 `run predicate` —— 1.20.1 没有独立的 /predicate，
必须写成 `execute store success ... if predicate ...`（同 cop_pick 那批的坑）。
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FUN = ROOT / "src/data/kitpvp/functions/skill/li_ench"
UUID = "00000000-0000-0000-0000-0000000000a1"


def fix_card(path: Path, value: str) -> None:
    text = path.read_text(encoding="utf-8")
    text = text.replace(
        "modifier remove kitpvp:tmp_sharp",
        "modifier remove %s" % UUID,
    )
    text = text.replace(
        "modifier add kitpvp:tmp_sharp kitpvp.tmp_sharp %s operation add" % value,
        "modifier add %s kitpvp.li_sharp %s add" % (UUID, value),
    )
    path.write_text(text, encoding="utf-8", newline="\n")
    print("patched", path.name)


def fix_expire() -> None:
    p = FUN / "tmp_expire.mcfunction"
    text = p.read_text(encoding="utf-8")
    text = text.replace("modifier remove kitpvp:tmp_sharp", "modifier remove %s" % UUID)
    p.write_text(text, encoding="utf-8", newline="\n")
    print("patched tmp_expire.mcfunction")


def fix_draw() -> None:
    p = FUN / "draw.mcfunction"
    text = p.read_text(encoding="utf-8")
    n = text.count("run predicate kitpvp:random/1in2")
    text = text.replace(
        "run predicate kitpvp:random/1in2",
        "if predicate kitpvp:random/1in2",
    )
    p.write_text(text, encoding="utf-8", newline="\n")
    print("draw.mcfunction: %d predicate calls fixed" % n)


def main() -> None:
    fix_card(FUN / "card/c12_sharp3.mcfunction", "2")
    fix_card(FUN / "card/c22_sharp5.mcfunction", "3")
    fix_expire()
    fix_draw()


if __name__ == "__main__":
    main()
