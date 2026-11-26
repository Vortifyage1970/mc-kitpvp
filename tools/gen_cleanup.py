#!/usr/bin/env python3
"""从 summon 里的 Tags 反推"本包生成过哪些实体"，生成 game/reset_entities.mcfunction。

用法：
    python tools/gen_cleanup.py            # 重新生成
    python tools/gen_cleanup.py --check    # 只报告，不写盘（check.py 也用它做校验）
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
FUNCS = ROOT / "src/data/kitpvp/functions"
TARGET = FUNCS / "game/reset_entities.mcfunction"

SUMMON_RE = re.compile(r"(?:^|\brun )summon\s+\S+")
EGG_RE = re.compile(r"EntityTag:\{")
TAGS_RE = re.compile(r"Tags:\[([^\]]*)\]")
TAG_RE = re.compile(r'"(kitpvp\.[a-z0-9_]+)"')
# 运行期才打上的实体 tag（只认 @e 目标：@s / @a 那些是玩家 tag，绝不能被当实体清场目标）
TAGADD_RE = re.compile(r"^\s*(?:execute[^\n]*?)\btag\s+@e\S*\s+add\s+(kitpvp\.[a-z0-9_]+)\s*$")

# 这些 tag 不进清理表：
#   _new 结尾的只在"刚召出那一 tick"存在，由各自函数当刻摘掉
#   displayitem 是装饰实体的保护标记（load 打上），清掉它等于删掉地图装饰
#   kit_stand 是大厅职业展台（build 模式手搭），跨局保留
EXEMPT_SUFFIX = ("_new",)
EXEMPT = {"kitpvp.displayitem", "kitpvp.kit_stand"}

# 必须先删的：守卫 / 时钟要排在本体前面，本体一消失守卫会走"战死"分支
ORDER_FIRST = [
    ("kitpvp.earth_threshold_guard", "守卫：先删守卫，再让本体消失，否则会触发 threshold_death"),
    ("kitpvp.earth_hydrator_guard", "守卫：同上（hydrator_death）"),
    ("kitpvp.earth_leaker_clock", "时钟：先删时钟，本体消失后不再续播报"),
]

HEADER = [
    "# 由 tools/gen_cleanup.py 从所有 summon 的 Tags 自动生成 —— 不要手改，改完跑一次工具。",
    "# 每新增一种带 tag 的召唤物，重跑本工具即可；check.py 会拦「忘了重跑」的情况。",
]


def collect() -> dict[str, list[str]]:
    """tag -> 出现在哪些文件（只记文件名，报错时好定位）"""
    found: dict[str, list[str]] = {}
    for path in FUNCS.rglob("*.mcfunction"):
        rel = path.relative_to(ROOT).as_posix()
        for line in path.read_text(encoding="utf-8").splitlines():
            if line.lstrip().startswith("#"):
                continue
            if not (SUMMON_RE.search(line) or EGG_RE.search(line)):
                m_add = TAGADD_RE.search(line)
                if m_add:
                    tag = m_add.group(1)
                    if tag not in EXEMPT and not tag.endswith(EXEMPT_SUFFIX):
                        found.setdefault(tag, []).append(rel)
                continue
            for group in TAGS_RE.findall(line):
                for tag in TAG_RE.findall(group):
                    if tag in EXEMPT or tag.endswith(EXEMPT_SUFFIX):
                        continue
                    found.setdefault(tag, []).append(rel)
    return found


def render(tags: dict[str, list[str]]) -> str:
    lines = list(HEADER)
    first = [t for t, _why in ORDER_FIRST if t in tags]
    if first:
        lines.append("")
        lines.append("# ---- 必须先删（顺序有意义，见每行后面的理由）----")
        for tag in first:
            why = dict(ORDER_FIRST)[tag]
            lines.append(f"# {why}")
            lines.append(f"kill @e[tag={tag}]")
    rest = [t for t in sorted(tags) if t not in first]
    lines.append("")
    lines.append(f"# ---- 其余按 tag 清（{len(rest)} 个；来源写在每行上面的注释里）----")
    for tag in rest:
        src = sorted(set(tags[tag]))
        short = ", ".join(sorted({Path(s).stem for s in src}))
        lines.append(f"# {tag}  <- {short}")
        lines.append(f"kill @e[tag={tag}]")
    return "\n".join(lines) + "\n"


def main(argv: list[str]) -> int:
    tags = collect()
    text = render(tags)
    if "--check" in argv:
        current = TARGET.read_text(encoding="utf-8") if TARGET.exists() else ""
        if current != text:
            print(f"[FAIL] {TARGET.relative_to(ROOT).as_posix()} 与 summon 里的 Tags 不一致，跑 tools/gen_cleanup.py")
            old = {m for m in re.findall(r"kill @e\[tag=(kitpvp\.[a-z0-9_]+)\]", current)}
            new = set(tags)
            for tag in sorted(new - old):
                print(f"  缺: {tag}  <- {', '.join(sorted(set(tags[tag])))}")
            for tag in sorted(old - new):
                print(f"  多: {tag}（reset_entities 里有，但 summon 里已不再出现）")
            return 1
        print(f"[OK] reset_entities 与 summon 的 Tags 一致（{len(tags)} 个 tag）")
        return 0
    with open(TARGET, "w", encoding="utf-8", newline="\n") as fh:
        fh.write(text)
    print(f"写入 {TARGET.relative_to(ROOT).as_posix()}：{len(tags)} 个 tag")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
