# 参与开发

这是一个 **Minecraft 1.20.1 纯数据包**项目（职业战争 / KitPvP）。`src/` 是唯一事实来源，其余都是围绕它自检、回归、文档的工具。

## 先看这两处

| 位置 | 内容 |
|---|---|
| [`README.md`](README.md) | 概览、玩法、目录结构、开发流程 |
| [`ai-content/`](ai-content/) | 约束文档与设计依据，**动手前必读** |
| [`tools/README.md`](tools/README.md) | 每个脚本干什么、什么时候必须跑 |

文档的权威顺序：**规则在 `03-project-spec.md`，实例在 `06-kit-registry.md`，objective/tag/物品标记账本在 `07-objective-tags.md`；代码是事实。**

`04-hazards-reminder.md` 是踩坑合集（18 节 + 17.x 细目），**1.20.1 的语法红线、静默不加载、补货冷却、清场策略都在里面**，改任何新机制前建议先搜一遍。

## 环境

```bash
python -m venv .venv
# 只用标准库；只有 tools/ai.py 需要额外装：pip install openai rich python-dotenv
```

行为回归（`tools/smoke.py`）需要一台**独立的** vanilla 1.20.1 服务端，且 `server.properties` 里开 RCON：

```bash
set MC_TEST_SERVER=D:\mc-test-server   # 服务端目录（默认值就是它）
set MC_JAVA=C:\path\to\java.exe        # 默认指向官方启动器自带 java
python tools/smoke.py
```

## 提交前必须过

```bash
python tools/check.py        # 断链 / JSON / 模板 / 选择器 / 判据 / 清场覆盖
python tools/gen_cleanup.py  # 只在你动过 summon / 刷怪蛋时
python tools/smoke.py        # 真开一台服务器跑一遍入口 + 所有职业
```

**`check.py` 有 FAIL 就不要提交**：其中多数问题会让整份 `.mcfunction` 在加载期被丢弃——`reload` 不报错、游戏照常能进，只是那个技能"点了没反应"，非常难查。

## 常见改动分别要跑什么

| 你改了什么 | 还要跑 |
|---|---|
| 新增/删除任意 `.mcfunction` | `tools/gen_structure.py` |
| 新增召唤物、刷怪蛋、运行期 `tag @e add` | `tools/gen_cleanup.py`（漏跑 = 跨局残留） |
| 职业数值 / 装备 | `tools/gen_cards.py`（卡片是生成的，别手改） |
| 新增职业 | `tools/new_kit.py` 生成骨架，再看 `06-kit-registry.md` 编号表 |
| 新增地图 | 参考 `map/` 下任一地图：`restore` / `distribute` / `pass` / `spawn_N`，并接入 `map/restore`、`map/distribute`、`map/random`、`select_menu` |

## 代码约定（摘要）

- 1.20.1 红线：没有 `return` / `tick` / `random` 命令，没有宏，没有函数参数，物品用旧版 NBT 写法。
- `matches` 只吃字面量与范围，**不要写逗号列表**（会让整份函数加载失败）。
- 统计判据写法：`minecraft.used:minecraft.<物品>`，**冒号形式在函数里不合法**。
- 每刻车道（`tick/kits_*`）保持精简，能放 `slow2` / `slow4` 就别放每刻。
- 新技能优先照 `05-skill-patterns.md` 里的现成范式（`dispatch` / `cast` / `fire` 三段式等）。

## 分支与上线

- 功能分支自己开，**不要直接在 `main` 上堆大改**；`测试` 分支是历史遗留的实验分支。
- 合进 `main` 前跑一遍上面三条自检，PR 描述里附上 `check.py` / `smoke.py` 的结果。
- `main` 推上去只是备份；**上线要另外推 `deploy`**（服务器 `post-receive` 钩子会自动部署 + `/reload`）：

```bash
git push origin main
git push deploy main
```

## 目录

| 目录 | 入库 | 说明 |
|---|---|---|
| `src/` | ✅ | 数据包本体 |
| `tools/` | ✅ | 自检 / 回归 / 生成器 / 存档扫描 |
| `ai-content/` | ✅ | 约束文档、注册表、历史 1.12.2 资料（`_` 开头的原始 dump 不入库） |
| `out/`、`balance/` | ❌ | 一次性调试脚本与导出数据 |