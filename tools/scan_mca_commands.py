#!/usr/bin/env python3
"""扫描 1.12.2 存档的 region 文件，导出命令方块与告示牌（只读，不改存档）。"""
from __future__ import annotations

import struct
import sys
import zlib
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "tools"))
from nbt_tool import Reader  # noqa: E402

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")


def parse_nbt(buf: bytes) -> dict:
    r = Reader(buf)
    t = r.u1()
    if t != 10:
        raise ValueError("root not compound: %d" % t)
    r.s()
    return r.tag(10)


def chunks_in_region(path: Path):
    raw = path.read_bytes()
    if len(raw) < 8192:
        return
    for i in range(1024):
        full = struct.unpack_from(">I", raw, i * 4)[0]
        sector_off = full >> 8
        sectors = full & 0xFF
        if sector_off == 0 or sectors == 0:
            continue
        pos = sector_off * 4096
        if pos + 5 > len(raw):
            continue
        length = struct.unpack_from(">I", raw, pos)[0]
        comp = raw[pos + 4]
        body = raw[pos + 5:pos + 4 + length]
        try:
            if comp == 1:
                import gzip
                data = gzip.decompress(body)
            elif comp == 2:
                data = zlib.decompress(body)
            elif comp == 3:
                data = body
            else:
                continue
            yield parse_nbt(data)
        except Exception as exc:  # noqa: BLE001
            print("chunk %d parse error: %s" % (i, exc))


def te_list(chunk: dict):
    lvl = chunk.get("Level")
    if not lvl:
        return []
    tes = lvl[1].get("TileEntities")
    if not tes:
        return []
    return tes[1]


def sign_text(d: dict) -> str:
    import json

    parts = []
    for i in range(1, 5):
        raw = d.get("Text%d" % i, "")
        if not raw:
            continue
        try:
            obj = json.loads(raw)
            if isinstance(obj, dict):
                txt = obj.get("text", "")
                if isinstance(txt, dict):
                    txt = txt.get("text", "")
                if not txt and "extra" in obj:
                    txt = "".join(e.get("text", "") for e in obj["extra"] if isinstance(e, dict))
                parts.append(str(txt))
            else:
                parts.append(str(obj))
        except Exception:  # noqa: BLE001
            parts.append(raw)
    return " | ".join(p for p in parts if p)


def main(argv):
    region = Path(argv[1])
    x0, x1 = int(argv[2]), int(argv[3])
    y0, y1 = int(argv[4]), int(argv[5])
    z0, z1 = int(argv[6]), int(argv[7])
    rows = []
    for chunk in chunks_in_region(region):
        for te in te_list(chunk):
            d = {k: v for k, (t, v) in te.items()}
            x, y, z = d.get("x", 0), d.get("y", 0), d.get("z", 0)
            if not (x0 <= x <= x1 and y0 <= y <= y1 and z0 <= z <= z1):
                continue
            tid = d.get("id", "")
            cmd = d.get("Command", "")
            extra = sign_text(d) if tid == "minecraft:sign" else ""
            rows.append((y, z, x, tid, cmd, extra))
    rows.sort()
    for y, z, x, tid, cmd, extra in rows:
        tail = cmd.replace("\n", "\\n") or extra
        print("%5d %5d %5d  %-30s  %s" % (x, y, z, tid, tail))
    print("total:", len(rows))


if __name__ == "__main__":
    main(sys.argv)
