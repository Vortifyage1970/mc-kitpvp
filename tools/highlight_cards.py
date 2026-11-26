#!/usr/bin/env python3
"""把 kit/info/*.mcfunction 里所有"数值"高亮成金色。

覆盖：
- 攻击伤害 / 攻速 / 护甲值 / 护甲韧性
- 文本里的阿拉伯数字（含 20 秒、5 格、x24 这类带单位的）
- 附魔等级（罗马数字 I..X，例如 保护 IV、锋利 III、击退 X）

做法：解析每条 tellraw 的 JSON，把 color=white 且文本里含数值/等级的成分拆成多段，
数值段改成 gold；原有 hoverEvent 等字段原样复制到每一段上（悬停行为不变）。

用法：
    python tools/highlight_cards.py            # 处理 src/.../kit/info/*.mcfunction
"""
from __future__ import annotations

import json
import os
import re
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
INFO_DIR = os.path.join(ROOT, "src", "data", "kitpvp", "functions", "kit", "info")

# 数值：带可选单位；等级：罗马数字 I..X（前后不能贴拉丁字母，避免误伤 x24 之类）
_NUM = r"\d+(?:\.\d+)?(?:%|秒|刻|格|点|个|次|颗|只|块|件|发|支|瓶|级|金币)?"
_ROMAN = r"(?:X|IX|VIII|VII|VI|V|IV|III|II|I)"
TOKEN = re.compile(rf"(?P<num>{_NUM})|(?<![A-Za-z])(?P<lvl>{_ROMAN})(?![A-Za-z])")


def split_text(c: dict) -> list[dict]:
    """把一个成分按数值/等级拆开；非 white 的保持原样。"""
    text = c.get("text")
    if not isinstance(text, str):
        return [c]
    if c.get("color", "white") != "white":
        return [c]
    out: list[dict] = []
    for seg in TOKEN.split(text):
        if not seg:
            continue
        part = dict(c)
        part["text"] = seg
        part["color"] = "gold" if TOKEN.fullmatch(seg) else c.get("color", "white")
        out.append(part)
    return out or [c]


def walk(node):
    """就地处理所有成分数组 / hoverEvent.contents。"""
    if isinstance(node, list):
        new = []
        for item in node:
            if isinstance(item, dict):
                item = walk(item)
                if isinstance(item, list):
                    new.extend(item)
                else:
                    new.append(item)
            else:
                walk(item)
                new.append(item)
        return new
    if isinstance(node, dict):
        if "hoverEvent" in node and isinstance(node["hoverEvent"], dict):
            hv = node["hoverEvent"]
            if "contents" in hv:
                hv["contents"] = walk(hv["contents"])
        if "text" in node and "color" in node:
            return split_text(node) if node["color"] == "white" else node
        for k, v in list(node.items()):
            if isinstance(v, (list, dict)):
                node[k] = walk(v)
        return node
    return node


def process(path: str) -> bool:
    lines = open(path, encoding="utf-8", newline="").read().split("\n")
    changed = False
    out = []
    for line in lines:
        if not line.startswith("tellraw "):
            out.append(line)
            continue
        head, payload = line.split(" ", 2)[1], line.split(" ", 2)[2]
        try:
            data = json.loads(payload)
        except ValueError:
            out.append(line)
            continue
        new = walk(data)
        text = json.dumps(new, ensure_ascii=False, separators=(",", ":"))
        out.append(f"tellraw {head} {text}")
        if text != payload:
            changed = True
    if changed:
        open(path, "w", encoding="utf-8", newline="").write("\n".join(out))
    return changed


def main() -> int:
    n = 0
    for name in sorted(os.listdir(INFO_DIR)):
        if not name.endswith(".mcfunction"):
            continue
        if process(os.path.join(INFO_DIR, name)):
            n += 1
    print(f"高亮更新 {n} 张职业卡")
    return 0


if __name__ == "__main__":
    sys.exit(main())
