#!/usr/bin/env python3
"""
KitPvP 数据包静态检查
用法: python tools/lint.py
退出码: 0=通过, 1=有错误
"""
import json
import re
import sys
import pathlib

ROOT = pathlib.Path(__file__).resolve().parent.parent / "src"
NS = "kitpvp"          # 命名空间，改名时改这里

errors = []
warns = []


# ---------- 1. pack.mcmeta ----------
mcmeta = ROOT / "pack.mcmeta"
if not mcmeta.exists():
    errors.append("[pack] 缺少 pack.mcmeta")
else:
    try:
        data = json.loads(mcmeta.read_text("utf-8"))
        fmt = data.get("pack", {}).get("pack_format")
        if fmt != 15:
            errors.append(f"[pack] pack_format 应为 15（1.20.1），当前是 {fmt}")
    except Exception as e:
        errors.append(f"[pack] pack.mcmeta JSON 非法: {e}")


# ---------- 2. 所有 JSON 合法性 ----------
for p in ROOT.rglob("*.json"):
    if p.name == "pack.mcmeta":
        continue
    try:
        json.loads(p.read_text("utf-8"))
    except Exception as e:
        errors.append(f"[JSON] {p.relative_to(ROOT)}: {e}")


# ---------- 3. load/tick 标签 ----------
for tag in ("load", "tick"):
    f = ROOT / f"data/minecraft/tags/functions/{tag}.json"
    if not f.exists():
        warns.append(f"[tag] 缺少 {tag}.json（数据包不会自动{tag}）")
        continue
    try:
        vals = json.loads(f.read_text("utf-8")).get("values", [])
        for v in vals:
            if v.endswith(".mcfunction"):
                errors.append(f"[tag] {tag}.json 里的 '{v}' 多了 .mcfunction 后缀")
    except Exception:
        pass


# ---------- 4. 收集已定义的函数 ----------
defined = set()
for p in ROOT.rglob("*.mcfunction"):
    # data/<ns>/functions/<path>.mcfunction  →  <ns>:<path>
    try:
        rel = p.relative_to(ROOT / "data")
    except ValueError:
        continue
    parts = rel.parts
    if len(parts) < 3 or parts[1] != "functions":
        errors.append(f"[结构] {p.relative_to(ROOT)} 不在 functions/ 目录下")
        continue
    ns = parts[0]
    name = "/".join(parts[2:])[:-len(".mcfunction")]
    defined.add(f"{ns}:{name}")


# ---------- 5. 1.20.1 版本红线 ----------
BANNED = [
    (re.compile(r'^\s*\$'),                       "宏函数 $() 是 1.20.2+ 才有"),
    (re.compile(r'^\s*return\b'),                 "return 命令是 1.20.2+ 才有"),
    (re.compile(r'\bexecute\s+if\s+items\b'),     "execute if items 是 1.20.5+ 才有"),
    (re.compile(r'\bexecute\s+unless\s+items\b'), "execute unless items 是 1.20.5+ 才有"),
    (re.compile(r'\benchantments\s*:'),           "小写 enchantments 是 1.20.5+ 才有，用 Enchantments"),
    (re.compile(r'\bclick_event\b'),              "click_event 是 1.21.5+ 才有，用 clickEvent"),
    (re.compile(r'\bhover_event\b'),              "hover_event 是 1.21.5+ 才有，用 hoverEvent"),
    (re.compile(r'\bfunction\s+\S+\s+with\b'),    "function ... with 是 1.20.2+ 才有"),
    (re.compile(r'^\s*function\s+#'),             "function #tag 是 1.20.2+ 才有"),
    (re.compile(r'^\s*random\b'),                 "random 命令是 1.20.2+ 才有"),
    (re.compile(r'^\s*tick\b'),                   "tick 命令是 1.20.2+ 才有"),
    (re.compile(r'\bcomponents\s*:'),             "components 是 1.20.5+ 才有"),
    (re.compile(r'"action"\s*:\s*"show_text"\s*,\s*"value"'),
                                                  "hoverEvent 用 contents，不是 value"),
]

# ---------- 6. 扫描每个 .mcfunction ----------
CALL_RE = re.compile(r'^\s*function\s+([a-z0-9_]+:[a-z0-9_/]+)')

for p in ROOT.rglob("*.mcfunction"):
    lines = p.read_text("utf-8").splitlines()
    for i, line in enumerate(lines, 1):
        raw = line
        # 跳过注释
        if raw.lstrip().startswith("#"):
            continue

        for rx, msg in BANNED:
            if rx.search(raw):
                errors.append(f"[红线] {p.relative_to(ROOT)}:{i}  {msg}\n         {raw.strip()}")

        m = CALL_RE.match(raw)
        if m:
            target = m.group(1)
            if target not in defined:
                warns.append(f"[缺失] {p.relative_to(ROOT)}:{i}  调用了未定义的 {target}")


# ---------- 7. 输出 ----------
for e in errors:
    print("❌", e)
for w in warns:
    print("⚠️ ", w)

print()
print(f"定义函数 {len(defined)} 个")
print(f"{len(errors)} 错误 / {len(warns)} 警告")

if errors:
    sys.exit(1)