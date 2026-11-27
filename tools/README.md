# 开发工具

这些脚本把「改数据包 → 自检 → 行为回归 → 上线」串起来。**改完代码至少跑 `check.py`**，提交前建议连 `smoke.py` 一起跑。

只依赖 Python 3.10+ 标准库；`ai.py` 例外，需要 `pip install openai rich python-dotenv`。

```
python tools/check.py
python tools/smoke.py
```

---

## 一、必跑：静态体检

| 脚本 | 作用 |
|---|---|
| `check.py` | 一次性体检：函数引用断链、`tellraw`/`title` 内联 JSON、`place template` 模板是否存在、`summon` 单实体参数、`scoreboard objectives` 判据合法性、清场覆盖、1.20.1 已删物品 id、注释统计……**任何一条 FAIL 都不要提交** |
| `invariants.py` | `check.py` 的实现主体（不变量 + 规则），被 `check.py` 调用；单独跑也能看细节 |

常见失败的含义：

- `函数引用断链` —— 拼错函数名，或删了文件没删调用。
- `行内 JSON 解析失败` —— `tellraw` 少个括号/引号，**整份 function 会静默不加载**。
- `place template 模板不存在` —— `structures/` 里没有对应 `.nbt`。
- `criterion 不合法` —— 写成 `minecraft.used:minecraft:minecraft:xxx`（前缀重复）。

## 二、提交前：行为回归

| 脚本 | 作用 |
|---|---|
| `smoke.py` | 把 `src` 同步到本地测试服 → `reload` → 跑一遍所有入口 + 每个职业选择一次 → 断言没有 `Failed to load function` / `Unknown function` |

需要一台**独立的** vanilla 1.20.1 服务端（不要拿生产服用）：

```
set MC_TEST_SERVER=D:\mc-test-server
set MC_JAVA=C:\path\to\java.exe
python tools/smoke.py            # 跑完自动关服
python tools/smoke.py --keep     # 跑完不关，方便继续手测
```

测试服的 `server.properties` 需要开 RCON（默认连 `127.0.0.1:25578`，密码 `testpw`；可用 `MC_RCON_HOST/PORT/PASS` 覆盖）。

## 三、生成器（改了对应内容就要重跑）

| 脚本 | 什么时候跑 |
|---|---|
| `gen_cleanup.py` | **动过 `summon` / 刷怪蛋 / 运行期 `tag @e add`** → 重新生成 `game/reset_entities.mcfunction`（清场白名单）。漏跑 = 跨局残留 |
| `gen_structure.py` | 增删文件后 → 刷新 `ai-content/01-file-structure.md` |
| `gen_cards.py` | 改职业数值 / 装备后 → 重新生成 `kit/info/*.mcfunction` 卡片（**别手改卡片**） |
| `gen_trims.py` | 改盔甲纹饰分配 → 按 `ASSIGN` 表往所有 kit 的盔甲里重塞 `Trim`（幂等，别手改） |
| `gen_lobby.py` | 改大厅菜单 / 按钮 |
| `gen_chaos.py` | 改混沌武器池 |
| `gen_rumbling_lyrics.py` | 改音乐（火星地鸣）歌词时间轴 |

## 四、查资料 / 查故障

| 脚本 | 作用 |
|---|---|
| `scan_logs.py` | 读 `latest.log`，把 `Failed to load function ... Whilst parsing command on line N` 摘出来——**function 静默不加载时第一个跑它** |
| `rcon.py` | 直连测试服发命令：`python tools/rcon.py "reload" "function kitpvp:load"` |
| `nbt_tool.py` | 结构模板（`.nbt`）无损读写：`roundtrip` 自证、`strip-entities` 清实体、`emit-paintings` 导出画 |
| `nbt_info.py` | 批量看模板的 `size` / 方块数 / 调色板 / 实体数 |
| `scan_mca_commands.py` | **1.12.2** 存档 region 扫描（命令方块 / 箱子 / 告示牌） |
| `scan_120.py` | **1.20.1** 存档 region 扫描（`block_entities`；1.20 没有 `Level` 包装，用旧扫描器会一无所获） |
| `find_text.py` | 在 region 里按文本搜（找某个职业名/提示语在哪个命令方块里） |
| `normalize_noise.py` | 规范 `skill/sun/noise/` 的 128 条干扰文案 |
| `scaffold.py` | 新建数据包骨架（已存在则不覆盖） |
| `new_kit.py` | 新建职业时生成所有需要改的文件骨架 |
| `audit_refill.py` | 审计"补货型冷却"的两条不变量（使用侧写 cd、补货在慢拍且在使用之后） |
| `highlight_cards.py` | 把 `06-kit-registry.md` 里未完成/待办高亮 |
| `ai.py` | 把 `ai-content/` 当上下文喂给模型的 CLI（可选，需要额外依赖） |

---

## 五、目录约定

| 目录 | 入库 | 说明 |
|---|---|---|
| `src/` | ✅ | 数据包本体，**唯一事实来源** |
| `tools/` | ✅ | 上面这些脚本 |
| `ai-content/` | ✅ | 约束文档（`00`–`07`）、注册表、历史 1.12.2 资料 |
| `out/` | ❌ | 一次性的调试/生成脚本与导出数据，不入库 |
| `balance/` | ❌ | 平衡性试算的临时文件 |
| `.env` / `.venv/` | ❌ | 本地环境 |

`ai-content/` 里以 `_` 开头的都是原始导出数据（JSON/TXT），不入库；正式文档都入库。