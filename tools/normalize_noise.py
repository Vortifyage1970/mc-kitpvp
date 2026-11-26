#!/usr/bin/env python3
"""规范化 skill/sun/noise/ 的 128 条干扰文案：修粘贴破损 + 换亮色配色。

用法：
    python tools/normalize_noise.py

只做三件事，**不动文案文字**：

1. **接回被裸换行折断的行**：粘贴时长文案里带了真回车，会把一行 JSON 折成两三行，
   整个 .mcfunction 在加载期被丢掉（见 04 §十）。折行处改写成 `\\n` 转义，聊天栏里照样换行。
2. **修两种粘贴破损**：`"text":` 后面漏开引号（如 `{"text":We're ...","color":"gray"}`）；
   文字里混进未转义的半角双引号。
3. **换配色**：按槽位轮换 6 套亮色（主标题加粗），替掉原来的 dark_gray。
4. **去掉文末多余空行**：修完折行后残留的尾换行（`\n` 后面什么都没有），聊天栏里只会多出一行空白。
5. **统一音量**：所有 `playsound` 的音量字段改成 `VOLUME`（改响度只改这一个常数）。

每改一处都会打印；改不了的会原样留着并报出来。改完建议跑 `python tools/check.py`。
"""
from __future__ import annotations

import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
NOISE = ROOT / "src" / "data" / "kitpvp" / "functions" / "skill" / "sun" / "noise"

# (主标题, 副标题, 行动栏, 长文, 菱形前缀)
SCHEMES = [
    ("gold", "yellow", "aqua", "white", "gold"),
    ("aqua", "light_purple", "yellow", "white", "aqua"),
    ("light_purple", "aqua", "gold", "white", "light_purple"),
    ("red", "gold", "yellow", "white", "red"),
    ("green", "yellow", "aqua", "white", "green"),
    ("yellow", "gold", "light_purple", "white", "yellow"),
]

# 所有 playsound 的音量统一到这里（响度只改这一个数）
VOLUME = 1.6

CMD = re.compile(r"^(?:title @s (?:title|subtitle|actionbar) |tellraw @s |playsound )")


def strip_tail(obj) -> int:
    """去掉文字结尾多余的空行（粘贴时留下的尾换行，聊天栏里只会多出一行空白）。"""
    n = 0
    if isinstance(obj, dict):
        t = obj.get("text")
        if isinstance(t, str) and t.rstrip("\n") != t:
            obj["text"] = t.rstrip("\n")
            n += 1
        for v in obj.values():
            n += strip_tail(v)
    elif isinstance(obj, list):
        for v in obj:
            n += strip_tail(v)
    return n


def repair(raw: str):
    """把一段文本组件 JSON 修成可解析的；返回 (新文本 或 None, 解析结果 或 None, 备注)。"""
    try:
        return raw, json.loads(raw), []
    except Exception:
        pass
    notes: list[str] = []

    def repl(m):
        inner = m.group(1)
        esc = re.sub(r'(?<!\\)"', r'\\"', inner)
        if esc != inner:
            notes.append("转义了文字里裸的半角引号")
        notes.append("补上了 text 的起始引号")
        return '"text":"' + esc + '"'

    fixed = re.sub(r'"text":(?!")([\s\S]*?)(")?(?=,"color"|})', repl, raw, count=1)
    try:
        return fixed, json.loads(fixed), notes
    except Exception:
        pass

    # 文字里混进裸半角引号（`{"text":"性别输入"男"...}`）——抓 text 到收尾引号，把里面的 " 全转义。
    # 必须非贪婪且只认 `","color"`：贪婪 + 允许 `"}` 会把组件尾巴（","color":"yellow）一起吞进文字里。
    def repl_quote(m):
        inner = re.sub(r'(?<!\\)"', r'\\"', m.group(1))
        notes.append("转义了文字里裸的半角引号")
        return '"text":"' + inner + '"'

    fixed = re.sub(r'"text":"([\s\S]*?)"(?=,"color")', repl_quote, raw, count=1)
    try:
        return fixed, json.loads(fixed), notes
    except Exception:
        return None, None, notes


def main() -> int:
    files = sorted(NOISE.glob("*.mcfunction"), key=lambda p: int(p.stem))
    total_join = total_fix = total_color = total_vol = 0
    for idx, path in enumerate(files, 1):
        raw = path.read_text(encoding="utf-8").replace("\r\n", "\n")

        # 1) 合并被裸换行折断的行：不以命令开头、也不是注释的行 → 接到上一行
        merged: list[str] = []
        joins: list[int] = []
        for line in raw.split("\n"):
            if not line.strip():
                continue
            if not merged or CMD.match(line):
                merged.append(line)
            else:
                merged[-1] = merged[-1] + "\\n" + line.strip()
                joins.append(len(merged))
        if joins:
            total_join += 1
            print("%3d 接回折行：第 %s 行" % (idx, ",".join(map(str, joins))))

        # 2) 逐行修 + 重新上色
        d = SCHEMES[(idx - 1) % len(SCHEMES)]
        out: list[str] = []
        for line in merged:
            m = re.match(r"^title @s (title|subtitle|actionbar)\s+(.*)$", line)
            if m:
                kind, raw_json = m.group(1), m.group(2)
                fixed, comp, notes = repair(raw_json)
                if comp is None:
                    print("%3d ！！修不好，原样保留：%s" % (idx, raw_json[:60]))
                    out.append(line)
                    continue
                for n in notes:
                    total_fix += 1
                    print("%3d %s：%s" % (idx, kind, n))
                if strip_tail(comp):
                    print("%3d %s：去掉文末多余空行" % (idx, kind))
                comp["color"] = {"title": d[0], "subtitle": d[1], "actionbar": d[2]}[kind]
                if kind == "title":
                    comp["bold"] = True
                out.append(
                    "title @s %s %s" % (kind, json.dumps(comp, ensure_ascii=False, separators=(",", ":")))
                )
                total_color += 1
                continue

            m = re.match(r"^tellraw @s\s+(.*)$", line)
            if m:
                fixed, comps, notes = repair(m.group(1))
                if comps is None:
                    print("%3d ！！修不好，原样保留：%s" % (idx, m.group(1)[:60]))
                    out.append(line)
                    continue
                for n in notes:
                    total_fix += 1
                    print("%3d tellraw：%s" % (idx, n))
                if strip_tail(comps):
                    print("%3d tellraw：去掉文末多余空行" % idx)
                if isinstance(comps, list) and len(comps) >= 2:
                    comps[0]["color"] = d[4]
                    comps[1]["color"] = d[3]
                out.append("tellraw @s " + json.dumps(comps, ensure_ascii=False, separators=(",", ":")))
                total_color += 1
                continue

            if line.startswith("playsound "):
                out.append(
                    re.sub(
                        r"^(playsound .*?~ ~ ~ )([0-9.]+)( .*)$",
                        lambda mm: mm.group(1) + ("%g" % VOLUME) + mm.group(3),
                        line,
                    )
                )
                total_vol += 1
                continue

            out.append(line)

        path.write_bytes(("\r\n".join(out) + "\r\n").encode("utf-8"))

    print("—— 完成：接回折行 %d 个文件，修复粘贴破损 %d 处，重新上色 %d 行，音量 %g 共 %d 行" % (total_join, total_fix, total_color, VOLUME, total_vol))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
