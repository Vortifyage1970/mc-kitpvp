#!/usr/bin/env python3
"""无损读写 .nbt（1.20.1 结构模板）的小工具。

用法：
    python tools/nbt_tool.py roundtrip <file.nbt>
        解析 → 重新序列化 → 与原文逐字节比较（验证读写器可靠）

    python tools/nbt_tool.py strip-paintings <file.nbt>
        把实体列表里的 minecraft:painting 全部删掉，其余字节保持不变

    python tools/nbt_tool.py emit-paintings <file.nbt> <out.mcfunction>
        从模板里生成逐幅 summon 的行（绝对 Tile 坐标），供 restore 精确重建

    python tools/nbt_tool.py emit-entities <file.nbt> <out.mcfunction> [--decor]
        把模板里的**所有实体**导出成一条条 summon（模板以后不带实体，靠它摆回来）；
        --decor 会顺手给挂件 / 盔甲架加 Invulnerable:1b 与 kitpvp.displayitem

    python tools/nbt_tool.py strip-entities <file.nbt>
        清空模板里的全部实体（新规范：模板只存方块）

设计要点：列表会显式记住元素类型（`_L(et, items)`），字符串用 surrogateescape
往返，因此"解析再写回"能保证与原文件字节一致——剥实体前先跑 roundtrip 自证。
"""
from __future__ import annotations

import gzip
import struct
import sys
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")


class _L:
    """NBT 列表：显式保存元素类型，否则元素全空/类型无法还原。"""
    __slots__ = ("et", "items")

    def __init__(self, et, items):
        self.et = et
        self.items = items

    def __len__(self):
        return len(self.items)

    def __getitem__(self, i):
        return self.items[i]

    def __iter__(self):
        return iter(self.items)


class Reader:
    def __init__(self, b):
        self.b, self.i = b, 0

    def u1(self):
        v = self.b[self.i]
        self.i += 1
        return v

    def u2(self):
        v = struct.unpack_from(">H", self.b, self.i)[0]
        self.i += 2
        return v

    def i4(self):
        v = struct.unpack_from(">i", self.b, self.i)[0]
        self.i += 4
        return v

    def s(self):
        n = self.u2()
        v = self.b[self.i:self.i + n].decode("utf-8", "surrogateescape")
        self.i += n
        return v

    def tag(self, t):
        if t == 1:
            v = struct.unpack_from(">b", self.b, self.i)[0]
            self.i += 1
            return v
        if t == 2:
            v = struct.unpack_from(">h", self.b, self.i)[0]
            self.i += 2
            return v
        if t == 3:
            return self.i4()
        if t == 4:
            v = struct.unpack_from(">q", self.b, self.i)[0]
            self.i += 8
            return v
        if t == 5:
            v = struct.unpack_from(">f", self.b, self.i)[0]
            self.i += 4
            return v
        if t == 6:
            v = struct.unpack_from(">d", self.b, self.i)[0]
            self.i += 8
            return v
        if t == 7:
            n = self.i4()
            v = self.b[self.i:self.i + n]
            self.i += n
            return v
        if t == 8:
            return self.s()
        if t == 9:
            et = self.u1()
            n = self.i4()
            return _L(et, [self.tag(et) for _ in range(n)])
        if t == 10:
            d = {}
            while True:
                tt = self.u1()
                if tt == 0:
                    return d
                k = self.s()
                d[k] = (tt, self.tag(tt))
        if t == 11:
            n = self.i4()
            v = struct.pack(">i", n) + self.b[self.i:self.i + 4 * n]
            self.i += 4 * n
            return v
        if t == 12:
            n = self.i4()
            v = struct.pack(">i", n) + self.b[self.i:self.i + 8 * n]
            self.i += 8 * n
            return v
        raise ValueError("未知 tag 类型 %d" % t)


class Writer:
    def __init__(self):
        self.out = bytearray()

    def u1(self, v):
        self.out.append(v & 0xFF)

    def u2(self, v):
        self.out += struct.pack(">H", v)

    def i4(self, v):
        self.out += struct.pack(">i", v)

    def s(self, v):
        b = v.encode("utf-8", "surrogateescape")
        if len(b) >= 65536:
            raise ValueError("字符串过长")
        self.u2(len(b))
        self.out += b

    def tag(self, t, v):
        if t == 1:
            self.out += struct.pack(">b", v)
        elif t == 2:
            self.out += struct.pack(">h", v)
        elif t == 3:
            self.out += struct.pack(">i", v)
        elif t == 4:
            self.out += struct.pack(">q", v)
        elif t == 5:
            self.out += struct.pack(">f", v)
        elif t == 6:
            self.out += struct.pack(">d", v)
        elif t == 7:
            self.i4(len(v))
            self.out += v
        elif t == 8:
            self.s(v)
        elif t == 9:
            self.u1(v.et)
            self.i4(len(v.items))
            for item in v.items:
                self.tag(v.et, item)
        elif t == 10:
            for k, (tt, tv) in v.items():
                self.u1(tt)
                self.s(k)
                self.tag(tt, tv)
            self.u1(0)
        elif t in (11, 12):
            self.out += v
        else:
            raise ValueError("未知 tag 类型 %d" % t)


def read_nbt(path: Path):
    r = Reader(gzip.open(path, "rb").read())
    t = r.u1()
    if t != 10:
        raise ValueError("根不是 compound")
    name = r.s()
    return name, r.tag(10)


def nbt_bytes(name: str, root: dict) -> bytes:
    w = Writer()
    w.u1(10)
    w.s(name)
    w.tag(10, root)
    return bytes(w.out)


def write_nbt(path: Path, name: str, root: dict) -> int:
    data = nbt_bytes(name, root)
    with gzip.open(path, "wb", compresslevel=6) as fh:
        fh.write(data)
    return len(data)


def cmd_roundtrip(path: Path) -> int:
    raw = gzip.open(path, "rb").read()
    name, root = read_nbt(path)
    again = nbt_bytes(name, root)
    ok = again == raw
    print("%s  roundtrip %s  (%d → %d bytes)" % (path.name, "逐字节一致" if ok else "不一致！", len(raw), len(again)))
    return 0 if ok else 1


def cmd_strip_paintings(path: Path) -> int:
    name, root = read_nbt(path)
    blocks_before = len(root["blocks"][1])
    ents = root["entities"][1]
    kept = [e for e in ents if e["nbt"][1].get("id", (0, ""))[1] != "minecraft:painting"]
    removed = len(ents) - len(kept)
    if removed == 0:
        print("%s  没有画，未改动" % path.name)
        return 0
    root["entities"] = (root["entities"][0], _L(root["entities"][1].et, kept))
    size = write_nbt(path, name, root)
    # 复核
    _, check = read_nbt(path)
    print("%s  去掉 %d 幅画；实体 %d → %d；方块 %d（不变：%s）；写出 %d bytes" % (
        path.name, removed, len(ents), len(check["entities"][1]),
        blocks_before, len(check["blocks"][1]) == blocks_before, size))
    return 0


def cmd_emit_paintings(path: Path, out: Path) -> int:
    _, root = read_nbt(path)
    lines = ["# 由 tools/nbt_tool.py 从 %s 生成：逐幅按绝对 Tile 坐标重建，不依赖模板解析" % path.name,
             "# summon <实体> <坐标> <NBT>：facing 是贴附方向（0 南 / 1 西 / 2 北 / 3 东），variant 决定尺寸"]
    n = 0
    for e in root["entities"][1]:
        nb = e["nbt"][1]
        if nb.get("id", (0, ""))[1] != "minecraft:painting":
            continue
        tx, ty, tz = nb["TileX"][1], nb["TileY"][1], nb["TileZ"][1]
        facing = nb["facing"][1]
        variant = nb["variant"][1]
        lines.append(
            'summon minecraft:painting %d %d %d {TileX:%d,TileY:%d,TileZ:%d,facing:%db,variant:"%s"}'
            % (tx, ty, tz, tx, ty, tz, facing, variant))
        n += 1
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print("%s  →  %s（%d 幅画）" % (path.name, out.as_posix(), n))
    return 0


def cmd_emit_entities(path: Path, out: Path, origin, decor: bool = False) -> int:
    """把一个模板里的所有实体导出成 summon 行。

    坐标 = 模板内的相对 pos/blockPos + **放置原点**（模板里的 Tile 与 NBT Pos 都是导出时的绝对值，
    用相对值加原点才对"以后换位置放置"也成立）。
    字段走白名单：不写 UUID / Motion / forge 属性这些运行时垃圾（UUID 重复会让 summon 直接失败）。
    """
    _, root = read_nbt(path)
    ox, oy, oz = origin
    lines = [
        "# 由 tools/nbt_tool.py 从 %s 生成（原点 %s %s %s）：模板只存方块，实体在这里一条条 summon 回来" % (
            path.name, ox, oy, oz),
        "# 坐标用模板相对 pos/blockPos + 原点；字段走白名单，不写 UUID/Motion/forge 属性",
    ]
    n = 0
    for e in root["entities"][1]:
        nb = dict(e["nbt"][1])
        eid = nb.get("id", (0, ""))[1]
        kept = _prepare_entity(nb, eid, decor)
        if eid in _HANGING and "blockPos" in e:
            bx, by, bz = e["blockPos"][1]
            coord = "%d %d %d" % (bx + ox, by + oy, bz + oz)
        else:
            px, py, pz = e["pos"][1]
            coord = "%s %s %s" % (_num(px + ox), _num(py + oy), _num(pz + oz))
        body = snbt(10, kept)
        lines.append("summon %s %s %s" % (eid, coord, body) if body != "{}" else
                     "summon %s %s" % (eid, coord))
        n += 1
    out.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print("%s  →  %s（%d 个实体%s）" % (
        path.name, out.as_posix(), n, "，已加 invulnerable/displayitem" if decor else ""))
    return 0


def cmd_strip_entities(path: Path) -> int:
    """把模板里的实体全部清空（新规范：模板只存方块）。"""
    name, root = read_nbt(path)
    ents = root["entities"][1]
    if len(ents) == 0:
        print("%s  本来就没有实体" % path.name)
        return 0
    blocks_before = len(root["blocks"][1])
    root["entities"] = (root["entities"][0], _L(ents.et, []))
    write_nbt(path, name, root)
    _, check = read_nbt(path)
    print("%s  清空实体 %d → %d；方块 %d（不变：%s）" % (
        path.name, len(ents), len(check["entities"][1]),
        blocks_before, len(check["blocks"][1]) == blocks_before))
    return 0


_HANGING = {"minecraft:painting", "minecraft:item_frame", "minecraft:glow_item_frame"}
_DECOR_IDS = _HANGING | {"minecraft:armor_stand"}

# 每个实体类型"值得写回去"的字段白名单；其余的（UUID/Motion/Air/OnGround/forge Attributes…）一律不写
_KEEP = {
    "minecraft:armor_stand": {"Pose", "Small", "ShowArms", "NoBasePlate", "Invisible", "Marker",
                              "DisabledSlots", "HandItems", "ArmorItems", "CustomName", "CustomNameVisible"},
    "minecraft:painting": {"TileX", "TileY", "TileZ", "facing", "variant"},
    "minecraft:item_frame": {"TileX", "TileY", "TileZ", "Facing", "Item", "ItemRotation",
                             "Invisible", "Fixed"},
    "minecraft:glow_item_frame": {"TileX", "TileY", "TileZ", "Facing", "Item", "ItemRotation",
                                  "Invisible", "Fixed"},
    "minecraft:boat": {"Type"},
    "minecraft:minecart": {"Type"},
    "minecraft:chest_minecart": {"Type", "Items"},
    "minecraft:item": {"Item", "PickupDelay", "Age"},
}
_KEY_OK = set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_+-.")


def _num(v) -> str:
    return "%.17g" % v


def _snbt_key(k: str) -> str:
    if k and all(c in _KEY_OK for c in k):
        return k
    return '"' + k.replace("\\", "\\\\").replace('"', '\\"') + '"'


def _snbt_str(s: str) -> str:
    return '"' + s.replace("\\", "\\\\").replace('"', '\\"') + '"'


def _snbt_float(v) -> str:
    s = "%.9g" % v
    if "." not in s and "e" not in s and "E" not in s and "n" not in s:
        s += ".0"
    return s + "f"


def _snbt_double(v) -> str:
    s = "%.17g" % v
    if "." not in s and "e" not in s and "E" not in s and "n" not in s:
        s += ".0"
    return s + "d"


def snbt(t, v):
    """写出 SNBT；返回 None 表示"这一项该省掉"。"""
    if t == 1:
        return "%db" % v
    if t == 2:
        return "%ds" % v
    if t == 3:
        return "%d" % v
    if t == 4:
        return "%dL" % v
    if t == 5:
        return _snbt_float(v)
    if t == 6:
        return _snbt_double(v)
    if t == 7:
        return "[B;" + ",".join("%db" % b for b in v) + "]"
    if t == 8:
        return _snbt_str(v)
    if t == 9:
        if len(v) == 0:
            return None
        return "[" + ",".join(x for x in (snbt(v.et, i) for i in v.items) if x is not None) + "]"
    if t == 10:
        parts = []
        for k, (tt, tv) in v.items():
            s = snbt(tt, tv)
            if s is None:
                continue
            parts.append(_snbt_key(k) + ":" + s)
        return "{" + ",".join(parts) + "}"
    if t == 11:
        n = struct.unpack_from(">i", v, 0)[0]
        vals = struct.unpack_from(">%di" % n, v, 4)
        return "[I;" + ",".join(str(i) for i in vals) + "]"
    if t == 12:
        n = struct.unpack_from(">i", v, 0)[0]
        vals = struct.unpack_from(">%dq" % n, v, 4)
        return "[L;" + ",".join("%dL" % i for i in vals) + "]"
    raise ValueError(t)


_COMMON = {"Tags", "CustomName", "CustomNameVisible", "NoGravity", "Silent"}


def _prepare_entity(nb: dict, eid: str, decor: bool) -> dict:
    """按白名单挑字段；装饰类按需补 Invulnerable:1b 与 kitpvp.displayitem。"""
    keep = _KEEP.get(eid, set()) | _COMMON
    out = {k: v for k, v in nb.items() if k in keep}
    if decor and eid in _DECOR_IDS:
        out["Invulnerable"] = (1, 1)
        tags = out.get("Tags")
        items = [] if tags is None else list(tags[1].items)
        if "kitpvp.displayitem" not in items:
            items.append("kitpvp.displayitem")
        out["Tags"] = (9, _L(8, items))
    return out


def main(argv) -> int:
    if len(argv) < 3:
        print(__doc__)
        return 2
    cmd, path = argv[1], Path(argv[2])
    if cmd == "roundtrip":
        return cmd_roundtrip(path)
    if cmd == "strip-paintings":
        return cmd_strip_paintings(path)
    if cmd == "strip-entities":
        return cmd_strip_entities(path)
    if cmd == "emit-paintings" and len(argv) >= 4:
        return cmd_emit_paintings(path, Path(argv[3]))
    if cmd == "emit-entities" and len(argv) >= 4:
        decor = "--decor" in argv[4:]
        origin = (0, 0, 0)
        if "--origin" in argv:
            i = argv.index("--origin")
            origin = (float(argv[i + 1]), float(argv[i + 2]), float(argv[i + 3]))
        return cmd_emit_entities(path, Path(argv[3]), origin, decor)
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv))
