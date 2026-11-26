#!/usr/bin/env python3
"""重新扫描 src/，把目录树写回 ai-content/01-file-structure.md 的代码块。

用法：
    python tools/gen_structure.py

只替换文件里第一个 ``` 代码块的内容，其余文字（标题、说明）保持不变。
"""
from __future__ import annotations

import os
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "src"
DOC = ROOT / "ai-content" / "01-file-structure.md"


def tree_lines(dirpath: Path, prefix: str = "") -> list[str]:
    entries = sorted(
        os.listdir(dirpath),
        key=lambda n: (not os.path.isdir(dirpath / n), n.lower()),
    )
    lines: list[str] = []
    for i, name in enumerate(entries):
        last = i == len(entries) - 1
        lines.append(prefix + ("└─" if last else "├─") + name)
        if os.path.isdir(dirpath / name):
            lines.extend(tree_lines(dirpath / name, prefix + ("    " if last else "│   ")))
    return lines


def build_tree() -> list[str]:
    body = ["D:\\MC-KITPVP\\SRC", "│  pack.mcmeta"]
    body += [line for line in tree_lines(SRC) if line.strip() != "pack.mcmeta"]
    return body


HEADER = [
    "# 数据包目录结构（1.20.1）",
    "",
    "> 本文件由每次改动后重新扫描 `src/` 生成，是**唯一的函数/文件清单权威**。",
    "> 任何新增、改名的函数或数据文件，都必须重新扫描后更新本文件。",
    "> 只写目录树，不写解释。找不到的文件 = 不存在，不要假设。",
    ">",
    "> ⚠ `skill/sun/noise/` 是**纯文案池**（128 个 .mcfunction，每份 = 4 行文本 + 1 行 playsound）。",
    "> **不要读里面的内容**——它只为「随机刷屏」存在，读它纯粹浪费 token；要确认文件在不在，看本目录树就够。",
    "",
    "## 目录树",
    "",
]


def main() -> int:
    if not SRC.exists():
        print(f"找不到 {SRC}")
        return 1

    content = HEADER + ["```"] + build_tree() + ["```"]
    DOC.write_bytes(("\r\n".join(content) + "\r\n").encode("utf-8"))
    print(f"已重建 {DOC.name}：{len(content)} 行")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
