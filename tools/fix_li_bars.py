#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""里·附魔师：把 li_s/li_a 这 16 条按玩家显示的 bossbar 纳管。

check.py 只认「reset 与 clear_player 里清了 players」的按人条，
所以这里补两处：
  game/reset.mcfunction        —— 16 条 players 清空（局末统一收条）
  util/clear_player.mcfunction —— 按 ench_slot 只收自己的那两条
幂等：重跑会先删掉旧块再插。
"""
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FUN = ROOT / "src/data/kitpvp/functions"

MARK_RESET = "# 里·附魔师：收回 16 条按人显示的双条"
MARK_CLEAR = "# 里·附魔师：按槽位收回自己那两条"


def reset_block() -> str:
    lines = [MARK_RESET]
    for i in range(1, 9):
        lines.append(f"bossbar set kitpvp:li_s{i} players")
        lines.append(f"bossbar set kitpvp:li_a{i} players")
        lines.append(f"bossbar set kitpvp:li_s{i} value 0")
        lines.append(f"bossbar set kitpvp:li_a{i} value 0")
    return "\n".join(lines) + "\n"


def clear_block() -> str:
    lines = [MARK_CLEAR]
    for i in range(1, 9):
        lines.append(
            "execute if score @s kitpvp.ench_slot matches %d "
            "run bossbar set kitpvp:li_s%d players" % (i, i)
        )
        lines.append(
            "execute if score @s kitpvp.ench_slot matches %d "
            "run bossbar set kitpvp:li_a%d players" % (i, i)
        )
    return "\n".join(lines) + "\n"


def insert_after(path: Path, mark: str, block: str, anchor: str) -> None:
    text = path.read_text(encoding="utf-8")
    # 幂等：先删掉旧块（mark 行到下一个空行前的内容）
    out, skipping = [], False
    for line in text.splitlines():
        if line.strip() == mark:
            skipping = True
            continue
        if skipping and line.strip() == "":
            skipping = False
            continue
        if skipping:
            continue
        out.append(line)
    text = "\n".join(out).rstrip("\n") + "\n"
    idx = text.find(anchor)
    assert idx >= 0, f"anchor missing in {path.name}: {anchor!r}"
    end = idx + len(anchor)
    assert text[end:end + 1] == "\n", f"anchor not end-of-line in {path.name}"
    text = text[:end + 1] + block + text[end + 1:]
    path.write_text(text, encoding="utf-8", newline="\n")


def main() -> None:
    reset = FUN / "game/reset.mcfunction"
    insert_after(reset, MARK_RESET, reset_block(),
                 "scoreboard players set @a kitpvp.stone_left -1")
    clear = FUN / "util/clear_player.mcfunction"
    insert_after(clear, MARK_CLEAR, clear_block(),
                 "scoreboard players set @s kitpvp.stone_left -1")
    print("li bars registered in reset/clear_player")


if __name__ == "__main__":
    main()
