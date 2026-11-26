#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""加职业脚手架：一条命令生成「七处同步」+ 分类菜单项 + 卡片，并自动跑 check.py。

用法：
    python tools/new_kit.py --id 90 --file scaffold_test --name 脚手架测试 --cat abstract --brief 自检用
    python tools/new_kit.py --id 26 --file tainted_assassin --name 里·刺客 --cat tainted --brief 潜行刺杀

做的事（缺一即报错退出，不会半写）：
  1. kit/<file>.mcfunction        职业定义（占位装备，技能待补）
  2. kit/info/<file>.mcfunction   职业卡片
  3. kit/list/<分类>.mcfunction   菜单加一行（插在 [返回] 之前）
  4. util/give_kit                末尾加分派行
  5. kit/random                   全职业池：pool_size+1、加一行映射
  6. kit/random_<分类>            （表/里/星象）分类池：同理
  7. 跑 tools/check.py 自证没漏
技能逻辑 / objective / tick 钩子属于"具体职业"，脚手架不臆造，只在末尾提示你去补。
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
F = ROOT / "src/data/kitpvp/functions"
KIT = F / "kit"

# cat -> (list 文件名, 返回用的 list 名, 分类池 random_xxx 或 None, 默认颜色, 中文分类)
CATS = {
    "classic":  ("classic",         "classic",         "random_classic", "red",          "经典（表）"),
    "tainted":  ("classic_tainted", "classic_tainted", "random_tainted", "dark_green",   "经典（里）"),
    "chaos":    ("classic_chaos",   "classic_chaos",   None,             "dark_purple",  "经典（混沌）"),
    "astral":   ("astral",          "astral",          "random_astral",  "gold",         "星象"),
    "abstract": ("meme",            "meme",            None,             "light_purple", "抽象"),
    "career":   ("operator",        "operator",        None,             "aqua",         "职业职业"),
    "history":  ("history",         "history",         None,             "gold",         "历史"),
}


def read(p: Path) -> list[str]:
    return p.read_text(encoding="utf-8").splitlines()


def write(p: Path, lines: list[str]) -> None:
    with open(p, "w", encoding="utf-8", newline="\n") as fh:
        fh.write("\n".join(lines) + "\n")


def existing_ids() -> set[int]:
    ids = set()
    for p in KIT.glob("*.mcfunction"):
        if p.stem.startswith("random"):
            continue
        for line in read(p):
            m = re.search(r"scoreboard players set @s kitpvp\.kit (\d+)", line)
            if m:
                ids.add(int(m.group(1)))
    return ids


def j(obj) -> str:
    return json.dumps(obj, ensure_ascii=False, separators=(",", ":"))


def kit_file(fid: int, name: str, color: str, catcn: str, brief: str) -> str:
    return "\n".join([
        f"# {name}（kit = {fid}，{catcn}）：脚手架占位，装备 / 技能待补",
        "function kitpvp:util/clear_player",
        f"scoreboard players set @s kitpvp.kit {fid}",
        "tag @s add kitpvp.selected",
        "scoreboard players set @s kitpvp.alive 1",
        "scoreboard players set @s kitpvp.lives 3",
        "",
        "item replace entity @s armor.head with minecraft:iron_helmet{Unbreakable:1b}",
        "item replace entity @s armor.chest with minecraft:iron_chestplate{Unbreakable:1b}",
        "item replace entity @s armor.legs with minecraft:iron_leggings{Unbreakable:1b}",
        "item replace entity @s armor.feet with minecraft:iron_boots{Unbreakable:1b}",
        "item replace entity @s weapon.mainhand with minecraft:iron_sword{Unbreakable:1b}",
        "give @s minecraft:cooked_beef 24",
        "",
        "tellraw @s " + j([{"text": "已选择 ", "color": "gray"}, {"text": name, "color": color, "bold": True}]),
        "playsound minecraft:ui.button.click master @s ~ ~ ~ 1 1.2",
    ])


def info_file(fid: int, file: str, name: str, color: str, catcn: str, brief: str, back: str) -> str:
    L = [
        j([{"text": "┌──────────────────────────────", "color": "dark_gray"}]),
        j([{"text": "│ 职业名：", "color": "gray"}, {"text": name, "color": color, "bold": True}]),
        j([{"text": "│ 分类：", "color": "gray"}, {"text": catcn, "color": "white"}]),
        j([{"text": "│ 简介：", "color": "gray"}, {"text": brief, "color": "white"}]),
        j([{"text": "│ 装备 / 技能：", "color": "gray"}, {"text": "脚手架占位，待补", "color": "dark_gray"}]),
        j([{"text": "│ 命数：", "color": "gray"}, {"text": "3", "color": "gold"}]),
        j([{"text": "└──────────────────────────────", "color": "dark_gray"}]),
        j([
            {"text": "[ 确认选择 ]", "color": "green", "bold": True,
             "clickEvent": {"action": "run_command", "value": f"/function kitpvp:kit/{file}"},
             "hoverEvent": {"action": "show_text", "contents": [{"text": f"以{name}参战", "color": "gray"}]}},
            {"text": "  "},
            {"text": "[ 返回 ]", "color": "yellow",
             "clickEvent": {"action": "run_command", "value": f"/function kitpvp:kit/list/{back}"},
             "hoverEvent": {"action": "show_text", "contents": [{"text": "回到分类列表", "color": "gray"}]}},
        ]),
    ]
    return "\n".join("tellraw @s " + x for x in L)


def list_entry(file: str, name: str, color: str, brief: str) -> str:
    comp = [
        {"text": f"[{name}] ", "color": color, "bold": True,
         "clickEvent": {"action": "run_command", "value": f"/function kitpvp:kit/info/{file}"},
         "hoverEvent": {"action": "show_text", "contents": [{"text": brief, "color": "gray"}]}},
        {"text": brief, "color": "dark_gray"},
    ]
    return "tellraw @s " + j(comp)


def add_to_pool(p: Path, fid: int) -> None:
    lines = read(p)
    idx = None
    give_i = None
    for i, line in enumerate(lines):
        m = re.search(r"#pool_size kitpvp\.game (\d+)", line)
        if m:
            idx = int(m.group(1))
        if line.strip() == "function kitpvp:util/give_kit":
            give_i = i
    if idx is None or give_i is None:
        raise SystemExit(f"[abort] {p.name} 找不到 #pool_size 或 give_kit 锚点，拒绝半写")
    lines[give_i:give_i] = [f"execute if score @s kitpvp.rng matches {idx} run scoreboard players set @s kitpvp.kit {fid}"]
    for i, line in enumerate(lines):
        if re.search(r"#pool_size kitpvp\.game \d+", line):
            lines[i] = re.sub(r"(#pool_size kitpvp\.game )\d+", rf"\g<1>{idx + 1}", line)
    write(p, lines)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--id", type=int, required=True)
    ap.add_argument("--file", required=True, help="英文文件名/give_kit 函数名，如 tainted_assassin")
    ap.add_argument("--name", required=True)
    ap.add_argument("--cat", required=True, choices=list(CATS))
    ap.add_argument("--brief", default="（待补简介）")
    ap.add_argument("--color", default=None)
    a = ap.parse_args()

    list_file, back, pool, def_color, catcn = CATS[a.cat]
    color = a.color or def_color

    # ---- 写前全量校验（缺任何一处直接退出，不半写）----
    problems = []
    if a.id in existing_ids():
        problems.append(f"编号 {a.id} 已被占用")
    kit_p = KIT / f"{a.file}.mcfunction"
    info_p = KIT / "info" / f"{a.file}.mcfunction"
    list_p = KIT / "list" / f"{list_file}.mcfunction"
    give_p = F / "util" / "give_kit.mcfunction"
    all_pool = KIT / "random.mcfunction"
    fam_pool = KIT / f"{pool}.mcfunction" if pool else None
    for tag, p in [("kit", kit_p), ("info", info_p), ("give_kit", give_p), ("random", all_pool)] + ([("fam", fam_pool)] if fam_pool else []):
        if p.exists() if tag in ("kit", "info") else (not p.exists()):
            problems.append(f"{tag} 文件 {'已存在' if tag in ('kit','info') else '缺失'}: {p.relative_to(ROOT)}")
    if not list_p.exists():
        problems.append(f"list 文件缺失: {list_p.relative_to(ROOT)}")
    elif not any("[返回]" in ln for ln in read(list_p)):
        problems.append(f"{list_p.name} 里没有 [返回] 锚点")
    if not any(re.search(r"#pool_size kitpvp\.game \d+", ln) for ln in read(all_pool)):
        problems.append("random.mcfunction 缺 #pool_size 锚点")
    if problems:
        print("[abort] 校验未通过，未写任何文件：")
        for x in problems:
            print("  -", x)
        return 2

    # ---- 写 ----
    write(kit_p, kit_file(a.id, a.name, color, catcn, a.brief).splitlines())
    write(info_p, info_file(a.id, a.file, a.name, color, catcn, a.brief, back).splitlines())

    g = read(give_p)
    g.append(f"execute if score @s kitpvp.kit matches {a.id} run function kitpvp:kit/{a.file}")
    write(give_p, g)

    lst = read(list_p)
    out, done = [], False
    for ln in lst:
        if not done and "[返回]" in ln:
            out.append(list_entry(a.file, a.name, color, a.brief))
            done = True
        out.append(ln)
    if not done:
        raise SystemExit("[abort] list 插入失败")
    write(list_p, out)

    add_to_pool(all_pool, a.id)
    if fam_pool:
        add_to_pool(fam_pool, a.id)

    print("[ok] 已生成：")
    print(f"  kit/{a.file}.mcfunction, kit/info/{a.file}.mcfunction")
    print(f"  kit/list/{list_file}.mcfunction  (+1 菜单项)")
    print("  util/give_kit  (+1 分派)")
    print(f"  kit/random  (#pool_size+1, +1 映射)")
    if fam_pool:
        print(f"  kit/{pool}.mcfunction  (#pool_size+1, +1 映射)")
    print("提醒：装备 / 技能 / （若需要）load objective + tick 钩子 仍需你按 06/REVIEW 清单补齐；本工具不臆造。")

    r = subprocess.run([sys.executable, str(ROOT / "tools" / "check.py")], cwd=str(ROOT))
    if r.returncode != 0:
        print("\n[warning] check.py 未通过，请按上面报错补齐后再提交。")
    else:
        print("\n[check.py] 全部通过。")
    return r.returncode


if __name__ == "__main__":
    sys.exit(main())
