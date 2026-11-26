#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""读 1.20.1 结构模板的 size / 实体数 / 调色板大小 / DataVersion。"""
import gzip
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "tools"))
from nbt_tool import Reader  # noqa: E402

sys.stdout.reconfigure(encoding="utf-8")


def read(path):
    raw = path.read_bytes()
    data = gzip.decompress(raw) if raw[:2] == b"\x1f\x8b" else raw
    r = Reader(data)
    t = r.u1()
    if t != 10:
        raise ValueError("root not compound")
    r.s()
    return {k: v for k, (tt, v) in r.tag(10).items()}


if len(sys.argv) < 2:
    print("用法：python tools/nbt_info.py <装有 *.nbt 的目录>")
    sys.exit(2)

for p in sorted(Path(sys.argv[1]).glob("*.nbt")):
    d = read(p)
    size = d.get("size", [0, 0, 0])
    blocks = d.get("blocks", [])
    pal = d.get("palette", [])
    ents = d.get("entities", [])
    dv = d.get("DataVersion", "?")
    kinds = {}
    for e in ents:
        ed = {k: v for k, (t, v) in e.items()}
        nbt = {k: v for k, (t, v) in ed.get("nbt", {}).items()}
        idv = nbt.get("id", "?")
        kinds[idv] = kinds.get(idv, 0) + 1
    print("%-12s size=%-10s blocks=%-5d palette=%-4d entities=%-3d %s DataVersion=%s"
          % (p.name, size, len(blocks), len(pal), len(ents), kinds if kinds else "", dv))