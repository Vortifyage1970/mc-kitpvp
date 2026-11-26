#!/usr/bin/env python3
"""在 1.12.2 存档的所有 region 文件里搜索命令方块 / 告示牌文本（只读）。
用法: find_text.py <region_dir> <keyword> [<keyword2> ...]
"""
from __future__ import annotations
import struct, sys, zlib
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "tools"))
from nbt_tool import Reader  # noqa: E402

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")


def parse_nbt(buf: bytes) -> dict:
    r = Reader(buf); t = r.u1()
    if t != 10: raise ValueError("root not compound")
    r.s(); return r.tag(10)


def chunks_in_region(path: Path):
    raw = path.read_bytes()
    if len(raw) < 8192: return
    for i in range(1024):
        full = struct.unpack_from(">I", raw, i*4)[0]
        off, secs = full >> 8, full & 0xFF
        if off == 0 or secs == 0: continue
        pos = off*4096
        if pos+5 > len(raw): continue
        length = struct.unpack_from(">I", raw, pos)[0]
        comp = raw[pos+4]
        body = raw[pos+5:pos+4+length]
        try:
            if comp == 1:
                import gzip; data = gzip.decompress(body)
            elif comp == 2:
                data = zlib.decompress(body)
            elif comp == 3:
                data = body
            else: continue
            yield parse_nbt(data)
        except Exception:
            continue


def te_list(chunk):
    lvl = chunk.get("Level")
    if not lvl: return []
    tes = lvl[1].get("TileEntities")
    return tes[1] if tes else []


def sign_text(d):
    import json
    parts = []
    for i in range(1, 5):
        raw = d.get("Text%d" % i, "")
        if not raw: continue
        try:
            o = json.loads(raw)
            if isinstance(o, dict):
                txt = o.get("text", "")
                if isinstance(txt, dict): txt = txt.get("text", "")
                if not txt and "extra" in o:
                    txt = "".join(e.get("text","") for e in o["extra"] if isinstance(e, dict))
                parts.append(str(txt))
            else: parts.append(str(o))
        except Exception:
            parts.append(raw)
    return " | ".join(p for p in parts if p)


def main(argv):
    d = Path(argv[1]); kws = argv[2:]
    files = sorted(d.glob("*.mca"))
    hits = 0
    for f in files:
        try:
            for chunk in chunks_in_region(f):
                for te in te_list(chunk):
                    dd = {k: v for k, (t, v) in te.items()}
                    cmd = dd.get("Command", "") or sign_text(dd)
                    if not cmd: continue
                    if any(k in cmd for k in kws):
                        hits += 1
                        print("%s  %5d %5d %5d  %s" % (f.name, dd.get("x",0), dd.get("y",0), dd.get("z",0), cmd.replace("\n","\\n")))
        except Exception as e:
            pass
    print("hits:", hits)


if __name__ == "__main__":
    main(sys.argv)
