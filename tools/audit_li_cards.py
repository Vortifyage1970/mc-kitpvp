#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""逐张核对坐杀博徒的 18 张卡：能不能被抽到、引用的函数/计分项/属性/效果是否都存在。

不做运行时验证（那要进游戏），只做静态检查，把「写了但不存在」的东西挖出来。
"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FUN = ROOT / "src/data/kitpvp/functions"
LI = FUN / "skill/li_ench"
CARDS = sorted((LI / "card").glob("*.mcfunction"))

VALID_EFFECTS = {
    "strength", "speed", "resistance", "haste", "instant_health", "regeneration",
    "weakness", "slowness", "glowing", "invisibility", "absorption", "jump_boost",
    "fire_resistance", "water_breathing", "saturation", "blindness", "darkness",
    "poison", "wither", "slow_falling", "levitation", "night_vision", "luck",
    "unluck", "mining_fatigue", "nausea", "hunger", "health_boost",
}
UUID_RE = re.compile(r"^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")


def load_text(p: Path) -> str:
    return p.read_text(encoding="utf-8")


def existing_objectives() -> set:
    names = set()
    for line in load_text(FUN / "load.mcfunction").splitlines():
        m = re.match(r"scoreboard objectives add (\S+) ", line)
        if m:
            names.add(m.group(1))
    return names


def existing_functions() -> set:
    out = set()
    for p in FUN.rglob("*.mcfunction"):
        out.add("kitpvp:" + p.relative_to(FUN).as_posix()[:-len(".mcfunction")])
    return out


def dispatched() -> dict:
    text = load_text(LI / "draw.mcfunction")
    counts = {}
    for m in re.finditer(r"run function kitpvp:skill/li_ench/card/(\w+)", text):
        counts[m.group(1)] = counts.get(m.group(1), 0) + 1
    return counts


def main() -> None:
    objs = existing_objectives()
    funcs = existing_functions()
    disp = dispatched()
    problems = []

    for card in CARDS:
        name = card.stem
        lines = [l for l in load_text(card).splitlines() if l.strip() and not l.strip().startswith("#")]
        if disp.get(name, 0) != 1:
            problems.append("%s: draw 里出现 %d 次（应为 1）" % (name, disp.get(name, 0)))

        effect_count = 0
        for line in lines:
            for m in re.finditer(r"scoreboard players (?:add|set|remove|operation) @s (kitpvp\.\w+)", line):
                if m.group(1) not in objs:
                    problems.append("%s: 未定义的计分项 %s" % (name, m.group(1)))
            for m in re.finditer(r"scoreboard players (?:set|add) #(\w+) (kitpvp\.\w+)", line):
                if m.group(2) not in objs:
                    problems.append("%s: 未定义的计分项 %s" % (name, m.group(2)))
            for m in re.finditer(r"function (kitpvp:[\w/]+)", line):
                if m.group(1) not in funcs:
                    problems.append("%s: 不存在的函数 %s" % (name, m.group(1)))
            for m in re.finditer(r"effect give @s minecraft:(\w+)", line):
                effect_count += 1
                if m.group(1) not in VALID_EFFECTS:
                    problems.append("%s: 未知效果 %s" % (name, m.group(1)))
            for m in re.finditer(r"attribute @s (\S+) modifier (add|remove) (\S+)", line):
                if not UUID_RE.match(m.group(3)):
                    problems.append("%s: 属性修饰符 UUID 非法 %s" % (name, m.group(3)))

        # 每张卡至少要有一个「动作」：效果 / 计分 / 给物品 / 调函数
        acts = sum(
            1 for line in lines
            if ("effect give" in line or "scoreboard players" in line or "give @s" in line
                or "function kitpvp:" in line or "attribute " in line)
        )
        tag = "OK " if acts else "!! "
        print("%s%-16s 动作 %2d 条%s" % (tag, name, acts, "  效果 %d 个" % effect_count if effect_count else ""))

    print()
    if problems:
        print("发现问题 %d 条：" % len(problems))
        for p in problems:
            print("  -", p)
    else:
        print("18 张卡静态检查全部通过：都能被抽到、引用的函数与计分项都存在、属性 UUID 合法。")


if __name__ == "__main__":
    main()
