#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""抽卡的两个坑：

1) #dom_p 只掷了 4 位（0..15），而卡牌区间是 0..127 —— 结果永远落在第一张
   （普通永远是「磨刀」，稀有永远是「精修」），六张卡里另外五张根本抽不到。
   这里补齐 16/32/64 三位，让 #dom_p 真正是 0..127。
2) 自测只打「进度零头」，看不出点数；补一行点数输出，方便区分
   「零头没涨」和「零头已换成点数」。
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FUN = ROOT / "src/data/kitpvp/functions"

BITS = [(16, "8"), (32, "16"), (64, "32")]
ANCHOR = ("execute store success score #dom_b kitpvp.game run predicate kitpvp:random/1in2\n"
          "execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_p kitpvp.game 8\n")


def widen_p() -> None:
    p = FUN / "skill/li_ench/draw.mcfunction"
    text = p.read_text(encoding="utf-8")
    if "#dom_p kitpvp.game 64" in text:
        print("dom_p already 7 bits")
        return
    assert ANCHOR in text
    extra = ""
    for val, _ in BITS:
        extra += ("execute store success score #dom_b kitpvp.game run predicate kitpvp:random/1in2\n"
                  "execute if score #dom_b kitpvp.game matches 1 run scoreboard players add #dom_p kitpvp.game %d\n"
                  % val)
    text = text.replace(ANCHOR, ANCHOR + extra, 1)
    p.write_text(text, encoding="utf-8", newline="\n")
    print("dom_p widened to 7 bits")


def extend_test() -> None:
    p = FUN / "debug/li_draw_test.mcfunction"
    text = p.read_text(encoding="utf-8")
    if "点数" in text:
        return
    text = text.rstrip("\n") + (
        '\ntellraw @s [{"text":"[自测] 剑点数=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_sw"}},'
        '{"text":" 甲点数=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_ap"}},'
        '{"text":"   （3 点 = 1 级，剑要拿在主手才升级）","color":"dark_gray"}]\n'
    )
    p.write_text(text, encoding="utf-8", newline="\n")
    print("draw test extended")


def main() -> None:
    widen_p()
    extend_test()


if __name__ == "__main__":
    main()
