#!/usr/bin/env python3
"""一条命令的"体检"脚本：函数引用断链 + JSON 合法性 + 注释统计。

用法：
    python tools/check.py

无依赖，只读 src/。退出码非 0 表示发现断链或非法 JSON。
"""
from __future__ import annotations

import json
import os
import re
import sys
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

ROOT = Path(__file__).resolve().parent.parent
SRC = ROOT / "src"
DATA = SRC / "data"

FUNC_CALL = re.compile(r"(?:^|\brun\s+)function\s+(kitpvp:[A-Za-z0-9_/]+)")
TEMPLATE_CALL = re.compile(r"\bplace template\s+(kitpvp:[A-Za-z0-9_/]+)")
SINGLE_ENTITY = re.compile(r"\bdata\s+(?:get|merge|modify)\s+entity\s+(\S+)")


def collect_functions() -> set[str]:
    out: set[str] = set()
    for dirpath, _dirs, files in os.walk(DATA):
        for name in files:
            if not name.endswith(".mcfunction"):
                continue
            rel = Path(dirpath, name).relative_to(DATA).as_posix().split("/")
            if len(rel) >= 3 and rel[0] == "kitpvp" and rel[1] == "functions":
                out.add("kitpvp:" + "/".join(rel[2:-1] + [name[: -len(".mcfunction")]]))
    return out


# 这些函数来自存档里的独立音乐数据包（rumbling），不在 src 里，属于合法跨包引用
EXTERNAL_PREFIXES = ("kitpvp:music/rumbling",)


def check_references(functions: set[str]) -> list[tuple[str, str]]:
    missing: list[tuple[str, str]] = []
    for dirpath, _dirs, files in os.walk(DATA):
        for name in files:
            if not name.endswith((".mcfunction", ".json")):
                continue
            path = Path(dirpath, name)
            for line in path.read_text(encoding="utf-8").splitlines():
                stripped = line.strip()
                if stripped.startswith("#"):
                    continue
                for m in FUNC_CALL.finditer(stripped):
                    if m.group(1).startswith(EXTERNAL_PREFIXES):
                        continue
                    if m.group(1) not in functions:
                        missing.append((path.relative_to(ROOT).as_posix(), m.group(1)))
    return sorted(set(missing))


def check_json() -> list[str]:
    bad: list[str] = []
    for dirpath, _dirs, files in os.walk(SRC):
        for name in files:
            if not name.endswith((".json", ".mcmeta")):
                continue
            path = Path(dirpath, name)
            try:
                json.loads(path.read_text(encoding="utf-8"))
            except (ValueError, UnicodeDecodeError) as exc:
                bad.append(f"{path.relative_to(ROOT).as_posix()}: {exc}")
    return bad


def iter_commands():
    """产出 (相对路径, 行号, 命令行)，跳过注释与空行。"""
    for dirpath, _dirs, files in os.walk(DATA):
        for name in files:
            if not name.endswith(".mcfunction"):
                continue
            path = Path(dirpath, name)
            for n, line in enumerate(
                path.read_text(encoding="utf-8").splitlines(), 1
            ):
                stripped = line.strip()
                if stripped and not stripped.startswith("#"):
                    yield path.relative_to(ROOT).as_posix(), n, stripped


def check_templates() -> list[str]:
    """place template 在加载期解析模板 id：模板不存在 ⇒ 整个 function 被丢弃。"""
    bad: list[str] = []
    for where, n, cmd in iter_commands():
        for m in TEMPLATE_CALL.finditer(cmd):
            rel = m.group(1).split(":", 1)[1]
            target = DATA / "kitpvp" / "structures" / (rel + ".nbt")
            if not target.exists():
                bad.append(f"{where}:{n}  ->  {m.group(1)}（缺 {target.relative_to(ROOT).as_posix()}）")
    return sorted(set(bad))


def check_single_entity() -> list[str]:
    """data get/merge/modify entity 要求选择器在加载期就能确定唯一，否则整个 function 被丢弃。"""
    bad: list[str] = []
    for where, n, cmd in iter_commands():
        m = SINGLE_ENTITY.search(cmd)
        if m and m.group(1).startswith("@e[") and "limit=1" not in m.group(1):
            bad.append(f"{where}:{n}  ->  {m.group(1)}")
    return sorted(set(bad))


TELLRAW = re.compile(r"^tellraw\s+(\S+)\s+(\{.*|\[.*)$")
TITLE = re.compile(r"^title\s+(\S+)\s+(title|subtitle|actionbar)\s+(\{.*|\[.*)$")


def check_inline_json() -> list[str]:
    """tellraw / title 的行内 JSON 也在加载期解析：写坏了 ⇒ 整个 function 被丢弃（静默不生效）。

    注意选择器里也有方括号，所以不能"找第一个 ["：tellraw 的目标是第一个空白分隔的 token。
    """
    bad: list[str] = []
    for where, n, cmd in iter_commands():
        payload = None
        m = TELLRAW.match(cmd)
        if m:
            payload = m.group(2)
        else:
            m = TITLE.match(cmd)
            if m:
                payload = m.group(3)
        if payload is None:
            continue
        try:
            json.loads(payload)
        except ValueError as exc:
            bad.append(f"{where}:{n}  ->  {exc}")
    return sorted(set(bad))


def comment_stats() -> tuple[int, int, int]:
    files = 0
    comments = 0
    zero = 0
    for dirpath, _dirs, names in os.walk(DATA):
        for name in names:
            if not name.endswith(".mcfunction"):
                continue
            files += 1
            count = sum(
                1
                for line in Path(dirpath, name).read_text(encoding="utf-8").splitlines()
                if line.lstrip().startswith("#")
            )
            comments += count
            if count == 0:
                zero += 1
    return files, comments, zero


def check_bom() -> list[str]:
    bad: list[str] = []
    for dirpath, _dirs, files in os.walk(SRC):
        for name in files:
            if not name.endswith((".mcfunction", ".json", ".mcmeta")):
                continue
            path = Path(dirpath, name)
            if path.read_bytes().startswith(b"\xef\xbb\xbf"):
                bad.append(path.relative_to(ROOT).as_posix())
    return bad


def check_advancements() -> list[str]:
    """advancement 里的 `blocks` 只认显式 id 数组。

    1.20.1 的 BlockPredicate 解析 `blocks` 时把每一项当 ResourceLocation：写成字符串（"#minecraft:buttons"）
       ⇒ Expected blocks to be a JsonArray；写成数组里带 `#tag` ⇒ Non [a-z0-9_.-] character in namespace。
    两种都是**加载期**失败：整份 advancement 被丢弃，按钮再点也不会触发（lobby_launch 踩过）。
    """
    bad: list[str] = []
    adv_dir = os.path.join(DATA, "kitpvp", "advancements")

    def walk(node, path: str, where: str):
        if isinstance(node, dict):
            for key, value in node.items():
                here = f"{path}.{key}"
                if key == "blocks":
                    if not isinstance(value, list):
                        bad.append(f"{where}  {here} 必须是数组，现在是个 {type(value).__name__}")
                    else:
                        for entry in value:
                            if isinstance(entry, str) and entry.startswith("#"):
                                bad.append(f"{where}  {here} 里不能用标签 {entry}（只能写显式 id）")
                walk(value, here, where)
        elif isinstance(node, list):
            for i, item in enumerate(node):
                walk(item, f"{path}[{i}]", where)

    for dirpath, _dirs, names in os.walk(adv_dir):
        for name in names:
            if not name.endswith(".json"):
                continue
            full = os.path.join(dirpath, name)
            try:
                data = json.load(open(full, encoding="utf-8"))
            except ValueError:
                continue  # check_json 已经报过
            walk(data, "", os.path.relpath(full, DATA))
    return sorted(set(bad))


GLUE = re.compile(
    r"#[^\n]*?(?<=[0-9\u4e00-\u9fff])"
    r"(?:scoreboard|execute|function|summon|give|kill|clear|tag|team|effect|"
    r"playsound|tellraw|title|data|item|tp|attribute|advancement|schedule|"
    r"gamerule|weather|bossbar|damage|ride|xp|spawnpoint|fill|setblock)\s"
)


def check_glued() -> list[str]:
    """注释行里粘上了命令（两行被接成一行）：命令会被整行注释掉，function 静默少一半。"""
    bad: list[str] = []
    for dirpath, _dirs, files in os.walk(DATA):
        for name in files:
            if not name.endswith(".mcfunction"):
                continue
            path = Path(dirpath, name)
            rel = path.relative_to(ROOT).as_posix()
            for i, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
                if not line.lstrip().startswith("#"):
                    continue
                if GLUE.search(line):
                    bad.append(f"{rel}:{i}  {line.strip()[:80]}")
    return bad


SIMPLE_CRITERIA = {
    "dummy", "trigger", "deathCount", "playerKillCount", "totalKillCount",
    "health", "food", "air", "armor", "xp", "level", "points",
}
STAT_TYPES = {
    "used", "dropped", "picked_up", "mined", "crafted", "broken",
    "killed", "killed_by", "custom",
}


def check_objectives() -> list[str]:
    """scoreboard objectives add 的 criteria 必须是合法判据。

    典型坑：写成 `minecraft.used:minecraft:minecraft:mooshroom_spawn_egg`（前缀重复）会在加载期抛
    `Non [a-z0-9/._-] character in path of location`，把整份 function 丢掉（load 掉了等于全包不初始化）。
    ⚠ 注意 `minecraft.dropped:minecraft.tripwire_hook` 这种**两个冒号**是合法的（参数本身带命名空间），
    所以不能简单按冒号数量判断，只拦「前缀重复」和白名单外的写法。
    """
    bad: list[str] = []
    for dirpath, _dirs, files in os.walk(DATA):
        for name in files:
            if not name.endswith(".mcfunction"):
                continue
            path = Path(dirpath, name)
            rel = path.relative_to(ROOT).as_posix()
            for i, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
                s = line.strip()
                if s.startswith("#") or not s.startswith("scoreboard objectives add "):
                    continue
                parts = s.split()
                if len(parts) < 5:
                    bad.append(f"{rel}:{i}  缺少 criteria 参数")
                    continue
                criteria = parts[4]
                if "minecraft:minecraft:" in criteria:
                    bad.append(f"{rel}:{i}  criteria 前缀重复: {criteria}")
                    continue
                if criteria in SIMPLE_CRITERIA:
                    continue
                if criteria.startswith(("teamkill.", "killedByTeam.")):
                    continue
                m = re.match(r"^minecraft\.([a-z_]+):minecraft[.:]([a-z0-9_./]+)$", criteria)
                if not m or m.group(1) not in STAT_TYPES:
                    bad.append(f"{rel}:{i}  criteria 看起来不合法: {criteria}")
    return bad


def check_cleanup() -> list[str]:
    """reset_entities 必须与"本包生成过的实体 tag"一致（漏了就是跨局残骸）。

    清单由 gen_cleanup.py 从 summon 的 Tags、刷怪蛋的 EntityTag、运行期 `tag @e add` 反推。
    """
    sys.path.insert(0, str(Path(__file__).resolve().parent))
    try:
        import gen_cleanup  # noqa: PLC0415
    except Exception as exc:  # noqa: BLE001
        return [f"无法导入 gen_cleanup（{exc}）"]
    tags = gen_cleanup.collect()
    want = gen_cleanup.render(tags)
    target = gen_cleanup.TARGET
    rel = target.relative_to(ROOT).as_posix()
    if not target.exists():
        return [f"缺少 {rel}（跑 tools/gen_cleanup.py）"]
    have_text = target.read_text(encoding="utf-8")
    if have_text == want:
        return []
    have = set(re.findall(r"kill @e\[tag=(kitpvp\.[a-z0-9_]+)\]", have_text))
    out = [f"{rel} 与 summon / EntityTag / tag add 不一致（跑 tools/gen_cleanup.py）"]
    for tag in sorted(set(tags) - have):
        out.append(f"  缺: {tag}")
    for tag in sorted(have - set(tags)):
        out.append(f"  多: {tag}（已不再生成，可能是手写的兜底，请确认）")
    return out


def main() -> int:
    functions = collect_functions()
    missing = check_references(functions)
    bad_json = check_json()
    bad_templates = check_templates()
    bad_single = check_single_entity()
    bad_inline = check_inline_json()
    bad_bom = check_bom()
    bad_adv = check_advancements()
    bad_glued = check_glued()
    bad_obj = check_objectives()
    bad_cleanup = check_cleanup()
    sys.path.insert(0, str(Path(__file__).resolve().parent))
    import invariants  # noqa: PLC0415
    inv = invariants.run()
    files, comments, zero = comment_stats()

    print(f"函数总数: {len(functions)}")
    if missing:
        print(f"\n[FAIL] 断链的函数引用 {len(missing)} 处:")
        for path, target in missing:
            print(f"  {path}  ->  {target}")
    else:
        print("[OK] 函数引用无断链")

    if bad_json:
        print(f"\n[FAIL] 非法 JSON {len(bad_json)} 个:")
        for item in bad_json:
            print(f"  {item}")
    else:
        print("[OK] 所有 JSON / mcmeta 可解析")

    if bad_templates:
        print(f"\n[FAIL] place template 引用了不存在的模板 {len(bad_templates)} 处（会让整个 function 不加载）:")
        for item in bad_templates:
            print(f"  {item}")
    else:
        print("[OK] place template 模板都存在")

    if bad_single:
        print(f"\n[FAIL] 单实体参数用了多实体选择器 {len(bad_single)} 处（会让整个 function 不加载）:")
        for item in bad_single:
            print(f"  {item}")
    else:
        print("[OK] 单实体参数的选择器都唯一")

    if bad_inline:
        print(f"\n[FAIL] tellraw / title 的行内 JSON 解析失败 {len(bad_inline)} 处（会让整个 function 不加载）:")
        for item in bad_inline:
            print(f"  {item}")
    else:
        print("[OK] tellraw / title 的行内 JSON 都可解析")

    if bad_bom:
        print(f"\n[FAIL] 文件带 UTF-8 BOM {len(bad_bom)} 个（BOM 会顶在首行前面，整份 function 不加载）:")
        for item in bad_bom:
            print(f"  {item}")
    else:
        print("[OK] 所有文件不带 BOM")

    if bad_adv:
        print(f"\n[FAIL] advancement 的 blocks 写法会让整份文件不加载 {len(bad_adv)} 处:")
        for item in bad_adv:
            print(f"  {item}")
    else:
        print("[OK] advancement 的 blocks 都是显式 id 数组")

    if bad_glued:
        print(f"\n[FAIL] 注释行里粘了命令 {len(bad_glued)} 处（该行命令会被整行注释掉）:")
        for item in bad_glued:
            print(f"  {item}")
    else:
        print("[OK] 注释行没有粘命令")

    if bad_obj:
        print(f"\n[FAIL] scoreboard objectives add 的 criteria 写法非法 {len(bad_obj)} 处（会让整个 function 不加载）:")
        for item in bad_obj:
            print(f"  {item}")
    else:
        print("[OK] objective 的 criteria 写法合法")

    if bad_cleanup:
        print(f"\n[FAIL] 清场清单与 summon 不一致 {len(bad_cleanup)} 条（会留下跨局残骸）:")
        for item in bad_cleanup:
            print(f"  {item}")
    else:
        print("[OK] reset_entities 覆盖了所有带 tag 的召唤物")

    inv_bad = 0
    print("—— 不变量 lint ——")
    for title, problems, _fatal in inv:
        if problems:
            inv_bad += len(problems)
            print(f"\n[FAIL] {title} ({len(problems)}):")
            for item in problems:
                print(f"  {item}")
        else:
            print(f"[OK] {title}")
    hints = invariants.hints_shared_eggs()
    if hints:
        print(f"\n[提示] 共用刷怪蛋 {len(hints)} 组（非致命，人工确认已按 tag/名字分流）:")
        for h in hints:
            print(f"  {h}")

    print(f"\n注释统计: {files} 个 .mcfunction，{comments} 行注释，{zero} 个文件零注释")
    return 1 if (missing or bad_json or bad_templates or bad_single or bad_inline or bad_bom or bad_adv or bad_glued or bad_obj or bad_cleanup or inv_bad) else 0


if __name__ == "__main__":
    sys.exit(main())
