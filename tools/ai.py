#!/usr/bin/env python3
"""
KitPvP AI 助手（终端 Markdown 渲染版）

- 启动时自动读取 ai-content/ 下所有 .md（递归）
- /files    列出 src/ 下所有文件
- /read     读取指定文件进上下文（支持编号 / 相对路径 / 文件名 / 模糊匹配）
- /reload   重新读取 ai-content（改了 md 不用重启）
- /context  查看当前已加载的上下文摘要
- /clear    清空对话历史（保留 system 与上下文）
- /help     查看命令
- exit      退出

【关于复制粘贴】
1. 输入：使用 prompt_toolkit，支持括号粘贴 / 多行输入 / 历史记录，
   粘贴多行文本不会再被拆成一条条命令。
   - Enter 提交；Alt+Enter 或 Esc+Enter 插入换行。
2. 输出：AI 每次回复都会自动落盘到 out/ 目录，
   - 代码块        → 按代码块上方标注的路径写出（如 out/src/.../foo.mcfunction）
   - 完整回复原文  → out/_last_reply.md
   这样长行不会被终端折行破坏，直接从文件里复制即可，不会报错。

依赖: pip install rich openai python-dotenv prompt_toolkit
"""

from __future__ import annotations

import os
import re
import sys
import time
import shlex
import pathlib
from typing import Optional

from dotenv import load_dotenv
from openai import OpenAI
from rich.console import Console
from rich.markdown import Markdown
from rich.live import Live

# ---------------------------------------------------------------- 路径与全局

ROOT = pathlib.Path(__file__).resolve().parent.parent
CTX  = ROOT / "ai-content"
SRC  = ROOT / "src"
OUT  = ROOT / "out"

load_dotenv(ROOT / ".env")

console = Console()

MODEL = os.getenv("DEEPSEEK_MODEL", "deepseek-flash")

SYSTEM = """你是 Minecraft 1.20.1 数据包专家。
严格遵守 <上下文> 中的版本红线，任何违反红线的语法都不要输出。
当你不确定某个语法在 1.20.1 是否存在时，必须明确说"不确定，请用 /help 验证"，不许猜。

【输出文件内容的规则】
当输出 .mcfunction 或 .json 文件内容时：
- 用代码块包裹，标注正确语言：```mcfunction 或 ```json
- 代码块内部只放文件内容本身：
  - 不带行号
  - 不带任何解释性文字
  - 不带 "以下是..." 之类的引导
- 代码块外可以有简短说明（哪个文件、做什么）
- 一个文件一个代码块，代码块前一行写明文件路径
  （例如：src/data/kitpvp/function/foo.mcfunction）
- 代码块内的每一行都必须完整，禁止为了排版而人为换行

【mcfunction 规则】
- # 开头的行是注释
- 每行一条命令，不加分号
- 不输出行号
"""


# ---------------------------------------------------------------- 上下文加载

def load_context() -> tuple[str, list[str]]:
    """读取 ai-content 下所有 .md（递归），返回 (拼接内容, 文件列表)。"""
    if not CTX.exists():
        console.print(f"[yellow]⚠️  未找到目录: {CTX}[/yellow]")
        return "", []

    files = sorted(CTX.rglob("*.md"))
    if not files:
        console.print(f"[yellow]⚠️  {CTX} 下没有 .md 文件[/yellow]")
        return "", []

    parts, names = [], []
    for p in files:
        rel = p.relative_to(CTX)
        try:
            text = p.read_text("utf-8")
        except UnicodeDecodeError:
            console.print(f"[yellow]⚠️  {rel} 不是 UTF-8 编码，跳过[/yellow]")
            continue
        parts.append(f"===== {rel} =====\n{text}")
        names.append(f"{rel} ({len(text)} 字符)")

    return "\n\n".join(parts), names


def list_src_files() -> list[pathlib.Path]:
    """列出 src/ 下所有文件。"""
    if not SRC.exists():
        return []
    return sorted(p for p in SRC.rglob("*") if p.is_file())


def read_file_into_msgs(p: pathlib.Path, msgs: list) -> None:
    """把一个文件读进对话历史。"""
    try:
        txt = p.read_text("utf-8")
    except UnicodeDecodeError:
        console.print(f"[yellow]⚠️  {p.name} 不是 UTF-8 编码[/yellow]")
        return
    except OSError as e:
        console.print(f"[yellow]⚠️  读取 {p.name} 失败: {e}[/yellow]")
        return
    msgs.append({
        "role": "user",
        "content": f"【当前文件 {p.relative_to(ROOT)}】\n```\n{txt}\n```",
    })
    console.print(f"已载入 [green]{p.relative_to(ROOT)}[/green] ({len(txt)} 字符)")


def resolve_read(tokens: list[str], files: list[pathlib.Path]) -> list[pathlib.Path]:
    """把 /read 的参数解析成一堆文件路径。
    支持：编号、精确相对路径、唯一文件名、子串模糊匹配。
    """
    results: list[pathlib.Path] = []
    for tok in tokens:
        # 1) 纯数字 -> 编号
        if tok.isdigit():
            idx = int(tok)
            if 1 <= idx <= len(files):
                results.append(files[idx - 1])
            else:
                console.print(f"[yellow]⚠️  编号超出范围: {tok}[/yellow]")
            continue

        # 2) 精确相对路径
        p = (ROOT / tok).resolve()
        try:
            p.relative_to(ROOT)
            if p.is_file():
                results.append(p)
                continue
        except (ValueError, OSError):
            pass

        # 3) 文件名唯一匹配
        name_hits = [f for f in files if f.name == tok]
        if len(name_hits) == 1:
            results.append(name_hits[0])
            continue
        if len(name_hits) > 1:
            console.print(f"[yellow]⚠️  {tok!r} 匹配到多个文件，用编号指定：[/yellow]")
            for f in name_hits:
                console.print(f"    {f.relative_to(ROOT)}")
            continue

        # 4) 子串模糊匹配
        sub_hits = [f for f in files
                    if tok.lower() in str(f.relative_to(ROOT)).lower()]
        if len(sub_hits) == 1:
            results.append(sub_hits[0])
        elif not sub_hits:
            console.print(f"[yellow]⚠️  没找到匹配 {tok!r} 的文件[/yellow]")
        else:
            console.print(f"[yellow]⚠️  {tok!r} 有 {len(sub_hits)} 个候选，用编号指定：[/yellow]")
            for f in sub_hits:
                console.print(f"    {f.relative_to(ROOT)}")
    return results


# ---------------------------------------------------------------- 回复落盘

CODE_BLOCK_RE = re.compile(r"```([^\n`]*)\r?\n(.*?)```", re.DOTALL)

KNOWN_EXT = {
    ".mcfunction", ".json", ".md", ".txt", ".toml",
    ".yml", ".yaml", ".mcmeta", ".lang", ".properties", ".snbt",
}

LANG_EXT = {
    "mcfunction": "mcfunction", "json": "json", "python": "py", "py": "py",
    "bash": "sh", "sh": "sh", "shell": "sh", "yaml": "yml", "yml": "yml",
    "toml": "toml", "javascript": "js", "js": "js", "text": "txt", "": "txt",
}


def _guess_path(head_text: str) -> Optional[str]:
    """从代码块上方的文本里猜文件路径（取最后一行非空内容）。"""
    lines = [l for l in head_text.splitlines() if l.strip()]
    if not lines:
        return None

    cand = lines[-1].strip()
    cand = cand.strip("`'\"")                                  # 首尾反引号/引号
    cand = re.sub(r"^[\s>*_#\-—–]+", "", cand)                 # 列表/标题装饰
    cand = re.sub(r"[\s*_`]+$", "", cand).strip()
    cand = cand.strip("`'\"：: ")
    cand = re.sub(r"^(?:文件|路径|file|path)\s*[:：]\s*", "", cand, flags=re.I)

    if not cand or len(cand) > 200:
        return None
    if any(ch in cand for ch in " \t<>|\"?*"):
        return None
    if pathlib.PurePosixPath(cand).suffix.lower() not in KNOWN_EXT:
        return None
    return cand


def export_reply(text: str) -> list[str]:
    """把回复里的代码块落盘到 out/，并保存一份完整原文。
    返回写出的、相对 ROOT 的路径列表。
    """
    written: list[str] = []
    if not text.strip():
        return written

    out_root = OUT.resolve()
    blocks = list(CODE_BLOCK_RE.finditer(text))

    if blocks:
        OUT.mkdir(parents=True, exist_ok=True)

    for i, m in enumerate(blocks, 1):
        lang = m.group(1).strip().lower()
        body = m.group(2)
        if body.endswith("\n"):
            body = body[:-1]

        rel = _guess_path(text[:m.start()])
        if rel is None:
            rel = f"block{i}.{LANG_EXT.get(lang, 'txt')}"

        p = (OUT / rel).resolve()
        try:
            p.relative_to(out_root)
        except ValueError:                      # 防目录穿越
            p = OUT / f"block{i}.txt"

        try:
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_text(body + "\n", encoding="utf-8")
        except OSError as e:
            console.print(f"[yellow]⚠️  写入 {p} 失败: {e}[/yellow]")
            continue
        written.append(str(p.relative_to(ROOT)))

    # 完整原文：方便 Ctrl+A 全选后复制
    try:
        OUT.mkdir(parents=True, exist_ok=True)
        raw = OUT / "_last_reply.md"
        raw.write_text(text, encoding="utf-8")
        written.append(str(raw.relative_to(ROOT)))
    except OSError:
        pass

    return written


# ---------------------------------------------------------------- 流式渲染

def fit_markdown(text: str, console: Console, max_lines: int) -> str:
    """返回一个尾部子串，保证 Markdown 渲染后行数 <= max_lines。
    用 Rich 实际渲染来测量，不靠估算。
    """
    if max_lines <= 0:
        return ""

    def height(s: str) -> int:
        if not s.strip():
            return 0
        return len(console.render_lines(Markdown(s), console.options))

    lines = text.split("\n")
    # 廉价剪枝：行数远超时先砍开头，避免每次测量都渲染整段
    if len(lines) > max_lines * 4:
        lines = lines[-max_lines * 4:]

    if height("\n".join(lines)) <= max_lines:
        return "\n".join(lines)

    # 二分：找最长的、能塞进 max_lines 的后缀
    lo, hi = 1, len(lines)
    while lo < hi:
        mid = (lo + hi + 1) // 2
        if height("\n".join(lines[-mid:])) <= max_lines:
            lo = mid
        else:
            hi = mid - 1
    return "\n".join(lines[-lo:])


# ---------------------------------------------------------------- 输入器

def make_reader():
    """构建一个支持多行粘贴 / 历史的输入器；没有 prompt_toolkit 时返回 None。"""
    try:
        from prompt_toolkit import PromptSession
        from prompt_toolkit.history import FileHistory
        from prompt_toolkit.key_binding import KeyBindings
    except ImportError:
        return None

    kb = KeyBindings()

    @kb.add("enter")
    def _submit(event):                       # Enter 直接提交
        event.current_buffer.validate_and_handle()

    @kb.add("escape", "enter")
    def _newline(event):                      # Alt+Enter / Esc+Enter 换行
        event.current_buffer.insert_text("\n")

    try:
        history = FileHistory(str(ROOT / ".ai_history"))
    except Exception:
        from prompt_toolkit.history import InMemoryHistory
        history = InMemoryHistory()

    return PromptSession(
        multiline=True,
        key_bindings=kb,
        history=history,
        prompt_continuation=lambda width, line_number, is_soft_wrap: " " * width,
    )


# ---------------------------------------------------------------- 对话历史

MAX_HISTORY = 30       # 保留的对话条数（不含 system）


def trim_msgs(msgs: list) -> None:
    """历史太长会撑爆上下文窗口，只保留最近 MAX_HISTORY 条。"""
    while len(msgs) - 1 > MAX_HISTORY:
        del msgs[1]


# ---------------------------------------------------------------- 主程序

HELP_TEXT = """[bold]可用命令[/bold]
  [cyan]/files[/cyan]              列出 src/ 下所有文件
  [cyan]/read[/cyan]               列出可读文件（带编号）
  [cyan]/read 3 7[/cyan]           按编号读取多个文件进上下文
  [cyan]/read foo.mcfunction[/cyan] 按文件名 / 相对路径 / 模糊匹配读取
  [cyan]/reload[/cyan]             重新读取 ai-content/ 下的 .md
  [cyan]/context[/cyan]            查看当前已加载的上下文与历史条数
  [cyan]/clear[/cyan]              清空对话历史（保留 system 与上下文）
  [cyan]/help[/cyan]               显示本帮助
  [cyan]exit[/cyan] / [cyan]quit[/cyan]  退出

[bold]输入技巧[/bold]
  Enter 提交；Alt+Enter（或 Esc+Enter）在输入中插入换行。
  直接粘贴多行文本不会被拆成多条命令。

[bold]输出落盘[/bold]
  每次回复都会写入 [cyan]out/[/cyan]：代码块按标注路径写出，完整原文写入
  [cyan]out/_last_reply.md[/cyan]。长行被终端折行时，从文件复制即可。
"""


def main():
    client = None
    api_key = os.getenv("DEEPSEEK_API_KEY")
    if not api_key:
        console.print("[red]⚠️  未找到 DEEPSEEK_API_KEY。[/red]")
        console.print(f"[red]   请在 {ROOT / '.env'} 里写一行：[/red]")
        console.print("[red]   DEEPSEEK_API_KEY=sk-xxxxxxxx[/red]")
        return 1
    client = OpenAI(api_key=api_key, base_url="https://api.deepseek.com")

    context, names = load_context()

    console.rule("[bold]KitPvP AI 助手[/bold]")
    if names:
        console.print(f"已加载上下文：[green]{len(names)}[/green] 个文件")
        for n in names:
            console.print(f"  [green]✓[/green] {n}")
    else:
        console.print("[yellow]⚠️  上下文为空！AI 不知道 1.20.1 版本红线。[/yellow]")
    console.print(f"模型: [cyan]{MODEL}[/cyan]    输出目录: [cyan]{OUT.relative_to(ROOT)}/[/cyan]")
    console.rule()
    console.print("命令: [cyan]/files[/cyan] | [cyan]/read[/cyan] | "
                  "[cyan]/reload[/cyan] | [cyan]/context[/cyan] | "
                  "[cyan]/clear[/cyan] | [cyan]/help[/cyan] | [cyan]exit[/cyan]")

    msgs = [{"role": "system", "content": SYSTEM + "\n\n<上下文>\n" + context}]

    reader = make_reader()
    if reader is None:
        console.print("[yellow]提示: 未安装 prompt_toolkit，多行粘贴可能异常。"
                      "建议 pip install prompt_toolkit[/yellow]")

    while True:
        # ---------- 读取输入 ----------
        try:
            if reader is not None:
                q = reader.prompt("你> ").strip()
            else:
                q = console.input("\n[bold blue]你>[/bold blue] ").strip()
        except (EOFError, KeyboardInterrupt):
            console.print()
            break

        if not q:
            continue
        if q in ("exit", "quit"):
            break

        # ---------- 命令分发 ----------
        if q.startswith("/"):
            parts = q.split(maxsplit=1)
            cmd = parts[0].lower()
            arg = parts[1].strip() if len(parts) > 1 else ""

            if cmd == "/help":
                console.print(HELP_TEXT)

            elif cmd == "/files":
                if not SRC.exists():
                    console.print("[yellow]⚠️  src/ 不存在[/yellow]")
                    continue
                found = False
                for p in sorted(SRC.rglob("*")):
                    if p.is_file():
                        console.print(f"  {p.relative_to(ROOT)}")
                        found = True
                if not found:
                    console.print("  (空)")

            elif cmd == "/reload":
                context, names = load_context()
                msgs[0]["content"] = SYSTEM + "\n\n<上下文>\n" + context
                console.print(f"已重新加载 [green]{len(names)}[/green] 个上下文文件")
                for n in names:
                    console.print(f"  [green]✓[/green] {n}")

            elif cmd == "/context":
                if not names:
                    console.print("上下文为空")
                else:
                    console.print(f"当前上下文包含 {len(names)} 个文件：")
                    for n in names:
                        console.print(f"  - {n}")
                console.print(f"对话历史共 {len(msgs) - 1} 条消息")

            elif cmd == "/clear":
                del msgs[1:]
                console.print("对话历史已清空")

            elif cmd == "/read":
                files = list_src_files()
                if not files:
                    console.print("[yellow]⚠️  src/ 下没有文件[/yellow]")
                    continue
                if not arg:
                    console.print("可用文件（[cyan]/read <编号>[/cyan]，"
                                  "可一次多个，如 [cyan]/read 1 3 5[/cyan]）：")
                    for i, f in enumerate(files, 1):
                        console.print(f"  [cyan]{i:>3}[/cyan]  {f.relative_to(ROOT)}")
                    continue
                try:
                    tokens = shlex.split(arg)
                except ValueError as e:
                    console.print(f"[yellow]⚠️  参数解析失败: {e}[/yellow]")
                    continue
                for p in resolve_read(tokens, files):
                    read_file_into_msgs(p, msgs)

            else:
                console.print(f"[yellow]未知命令: {cmd}（用 /help 查看）[/yellow]")
            continue

        # ---------- 正常对话：流式 + 实时 Markdown 渲染 ----------
        trim_msgs(msgs)
        msgs.append({"role": "user", "content": q})

        try:
            stream = client.chat.completions.create(
                model=MODEL,
                messages=msgs,
                stream=True,
                temperature=0.2,
            )

            buf: list[str] = []
            max_lines = max(5, (console.height or 24) - 8)
            last_render = 0.0

            with Live(
                console=console,
                refresh_per_second=8,
                transient=True,
                vertical_overflow="crop",
            ) as live:
                for chunk in stream:
                    if not chunk.choices:          # usage 之类的空块
                        continue
                    d = chunk.choices[0].delta.content or ""
                    if not d:
                        continue
                    buf.append(d)

                    now = time.monotonic()
                    if now - last_render >= 0.1:   # 节流，避免 O(n²) 渲染
                        last_render = now
                        preview = fit_markdown("".join(buf), console, max_lines)
                        live.update(Markdown(preview))

            text = "".join(buf)
            if text:
                console.print(Markdown(text))
                written = export_reply(text)
                if written:
                    console.print("[dim]已写入: " + ", ".join(written) + "[/dim]")
            else:
                console.print("[yellow]（空回复）[/yellow]")

            msgs.append({"role": "assistant", "content": text})

        except Exception as e:
            console.print(f"\n[red]⚠️  请求失败: {e}[/red]")
            msgs.pop()

    return 0


if __name__ == "__main__":
    sys.exit(main())