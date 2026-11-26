#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""1.20.1 存档 region 扫描：抽 block_entities（方块实体）。

1.20.1 的区块是「扁平」结构：root 下直接是 block_entities / sections …，
没有 1.12.2 的 Level 包装（旧扫描器因此什么都扫不到）。
用法：python out/scan_120.py <region.mca> [仅显示 id 含此子串]
"""
import struct
import sys
import zlib
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "tools"))
from nbt_tool import Reader  # noqa: E402

sys.stdout.reconfigure(encoding="utf-8")


def parse(buf):
    r = Reader(buf)
    if r.u1() != 10:
        return None
    r.s()
    return {k: v for k, (t, v) in r.tag(10).items()}


def chunks(path):
    raw = path.read_bytes()
    for i in range(1024):
        full = struct.unpack_from(">I", raw, i * 4)[0]
        off, secs = full >> 8, full & 0xFF
        if not off or not secs:
            continue
        pos = off * 4096
        if pos + 5 > len(raw):
            continue
        ln = struct.unpack_from(">I", raw, pos)[0]
        comp = raw[pos + 4]
        body = raw[pos + 5: pos + 4 + ln]
        try:
            data = zlib.decompress(body) if comp == 2 else (zlib.decompress(body, 16 + 15) if comp == 1 else None)
            if data is None:
                continue
            ch = parse(data)
        except Exception:
            continue
        if ch:
            yield ch


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        print('用法：python tools/scan_120.py <region.mca> [只显示 id 含此子串]')
        sys.exit(2)
    path = Path(sys.argv[1])
    filt = sys.argv[2] if len(sys.argv) > 2 else ""
    n = 0
    for ch in chunks(path):
        bes = ch.get("block_entities") or ch.get("TileEntities") or []
        for be in bes:
            d = {k: v for k, (t, v) in be.items()}
            bid = str(d.get("id", ""))
            if filt and filt not in bid:
                continue
            n += 1
            extra = ""
            if "structure_block" in bid:
                name = d.get("name", "")
                size = d.get("size", "")
                s_pos = d.get("pos", "")
                extra = " name=%-14s size=%s pos=%s metadata=%s" % (name, size, s_pos, d.get("metadata", ""))
            print("%-32s x=%-8s y=%-5s z=%-8s%s" % (bid, d.get("x"), d.get("y"), d.get("z"), extra))
    print("hits:", n)


if __name__ == "__main__":
    main()