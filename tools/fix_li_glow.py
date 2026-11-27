#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""里·附魔师两处修补：

1) 领域期间不该给玩家挂 glowing —— 那行是从表附魔师「读书发光」照搬时带过来的，
   打开领域就等于给自己挂了个 60 秒透视标记。
2) 加两条自测：直接连抽 5 张卡（跳过 PvP 判定），用来区分「抽卡管线坏」还是
   「没打中人所以没抽」。
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FUN = ROOT / "src/data/kitpvp/functions"

GLOW = "effect give @s minecraft:glowing 2 0 true"

DRAW_TEST = """# 里·附魔师自测：连抽 5 张（不需要真打到人）
tellraw @s [{"text":"[自测] 连抽 5 张卡，看聊天栏/进度条","color":"yellow"}]
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
function kitpvp:skill/li_ench/draw
tellraw @s [{"text":"[自测] 剑进度=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_sw_fill"}},{"text":" 甲进度=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_ap_fill"}},{"text":" 剑级=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_sword"}},{"text":" 甲级=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.ench_armor"}}]
"""

HIT_TEST = """# 里·附魔师自测：模拟一次「命中玩家」（走 advancement 奖励函数的那段 kit=99 分支）
tellraw @s [{"text":"[自测] 模拟一次命中：领域内应该抽一张卡","color":"yellow"}]
execute if entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/li_ench/draw
execute unless entity @s[tag=kitpvp.ench_domain] run tellraw @s [{"text":"[自测] 你还没展开领域，先右键令牌","color":"red"}]
"""


def strip_glow() -> None:
    p = FUN / "skill/li_ench/tick_domain.mcfunction"
    lines = [l for l in p.read_text(encoding="utf-8").splitlines() if l.strip() != GLOW]
    text = "\n".join(lines) + "\n"
    text = text.replace("# 领域每刻：倒计时、发光、脚下金粉",
                        "# 领域每刻：倒计时、脚下金粉（不给发光——那会让对手隔着墙看到你）")
    p.write_text(text, encoding="utf-8", newline="\n")
    print("glow removed from tick_domain")


def write_debug() -> None:
    d = FUN / "debug"
    (d / "li_draw_test.mcfunction").write_text(DRAW_TEST, encoding="utf-8", newline="\n")
    (d / "li_hit_test.mcfunction").write_text(HIT_TEST, encoding="utf-8", newline="\n")
    print("debug written")


def main() -> None:
    strip_glow()
    write_debug()


if __name__ == "__main__":
    main()
