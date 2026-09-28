#!/usr/bin/env python3
"""生成 1.20.1 数据包标准骨架，已存在则不覆盖"""
import pathlib, json

ROOT = pathlib.Path(__file__).resolve().parent.parent / "src"
NS = "kitpvp"          # ← 命名空间，只改这里就能全项目改名

dirs = [
    # 原版钩子
    "data/minecraft/tags/functions",
    # 自己的命名空间
    f"data/{NS}/functions",
    f"data/{NS}/functions/lobby",
    f"data/{NS}/functions/kit",
    f"data/{NS}/functions/game",
    f"data/{NS}/functions/player",
    f"data/{NS}/functions/util",
    f"data/{NS}/tags/functions",
    f"data/{NS}/predicates",
    f"data/{NS}/advancements",
    f"data/{NS}/loot_tables",
    f"data/{NS}/item_modifiers",
]

files = {
    # ---------- 包描述 ----------
    "pack.mcmeta": json.dumps({
        "pack": {"pack_format": 15, "description": "KitPvP 职业战争"}
    }, ensure_ascii=False, indent=2),

    # ---------- 原版钩子 ----------
    "data/minecraft/tags/functions/load.json": json.dumps(
        {"values": [f"{NS}:load"]}, indent=2),

    "data/minecraft/tags/functions/tick.json": json.dumps(
        {"values": [f"{NS}:tick"]}, indent=2),

    # ---------- 顶层函数 ----------
    f"data/{NS}/functions/load.mcfunction":
        "# 数据包加载时执行一次\n"
        "say KitPvP loaded\n",

    f"data/{NS}/functions/tick.mcfunction":
        "# 每游戏刻执行\n",

    # ---------- lobby / 大厅相关 ----------
    f"data/{NS}/functions/lobby/enter.mcfunction":
        "# 玩家进入大厅\n",

    f"data/{NS}/functions/lobby/leave.mcfunction":
        "# 玩家离开大厅\n",

    f"data/{NS}/functions/lobby/spawn.mcfunction":
        "# 将玩家传送到大厅出生点\n",

    # ---------- kit / 职业相关 ----------
    f"data/{NS}/functions/kit/give.mcfunction":
        "# 给玩家发放当前职业物品\n",

    f"data/{NS}/functions/kit/clear.mcfunction":
        "# 清空玩家职业物品\n",

    f"data/{NS}/functions/kit/select.mcfunction":
        "# 选择职业入口\n",

    # ---------- game / 回合流程 ----------
    f"data/{NS}/functions/game/start.mcfunction":
        "# 开始一局游戏\n",

    f"data/{NS}/functions/game/end.mcfunction":
        "# 结束一局游戏\n",

    f"data/{NS}/functions/game/tick.mcfunction":
        "# 游戏主循环，每刻执行\n",

    # ---------- player / 玩家事件 ----------
    f"data/{NS}/functions/player/join.mcfunction":
        "# 玩家加入服务器\n",

    f"data/{NS}/functions/player/leave.mcfunction":
        "# 玩家离开服务器\n",

    f"data/{NS}/functions/player/death.mcfunction":
        "# 玩家死亡处理\n",

    f"data/{NS}/functions/player/respawn.mcfunction":
        "# 玩家重生处理\n",

    # ---------- util / 通用工具 ----------
    f"data/{NS}/functions/util/say.mcfunction":
        "# 通用提示工具函数\n",

    f"data/{NS}/functions/util/title.mcfunction":
        "# 通用标题工具函数\n",
}

# 1) 建目录
for d in dirs:
    (ROOT / d).mkdir(parents=True, exist_ok=True)

# 2) 建文件（已存在则跳过）
for rel, content in files.items():
    p = ROOT / rel
    if p.exists():
        print(f"跳过已存在: {rel}")
        continue
    p.write_text(content, encoding="utf-8")
    print(f"创建: {rel}")

print("\n完成。")