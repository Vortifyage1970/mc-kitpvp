# HANDOFF —— 新对话接手说明（2026-11-15 更新）

> 这份文档是给"下一个接手这个项目的 AI / 人"看的：读完它 + `00-version.md` / `03-project-spec.md` / `04-hazards-reminder.md` 就能直接开工。

---

## 0. 一句话现状

Minecraft **1.20.1 纯数据包**版「职业战争 / KitPvP」：**41 个职业、9 张地图**全部可玩，核心循环（大厅→选职→开局→结算→重置→地图复原）稳定；本批次新增了农夫(13)，此前一批加了混沌战士(45)、混沌弓箭手(46)、火星(70)，并把星象编号收拢成 65–71。

---

## 1. 环境与路径

| 项 | 值 |
|---|---|
| 仓库 | `D:\mc-kitpvp`（只跟踪 `src/`，`tools/` 与 `ai-content/` 被 gitignore） |
| 存档 | `D:\Minecraft\.minecraft\versions\1.20.1-Forge_47.4.4\saves\职业战争` |
| 数据包链接 | 存档内 `datapacks\kitpvp` 是指向 `D:\mc-kitpvp\src` 的 **junction**（改 src 即改游戏） |
| Python | 一律用 `.\\.venv\\Scripts\\python.exe` |
| 校验 | `.\\.venv\\Scripts\\python.exe tools/check.py`（断链 / JSON / 模板 / 选择器 / 高亮 / objective criteria / 清场覆盖）；动过召唤物再跑 `tools/gen_cleanup.py` |
| 测试服 | `D:\mc-test-server`（vanilla 1.20.1，RCON 端口 **25578**，密码 `testpw`），Java：`C:\Users\tensa\AppData\Roaming\.minecraft\runtime\java-runtime-delta\bin\java.exe` |
| 音乐包 | `saves\职业战争\datapacks\rumbling`（独立数据包，**不在 git 里**；歌词也在其中 `music/rumbling_lyric/`） |

**启动测试服**（后台）后可用小 Python RCON 客户端直接 `function ...` 验证，务必只杀自己启动的那个 PID。

---

## 2. 工作流（硬性约定）

1. **先给方案再写代码**（用户明确要求过；方案要说清改动点、取舍、要他拍板的选择）。
2. 一次提交只做**一个主题**，`git add -A src` → 文案式 commit（中英都可，目前用英文）→ `git push origin main`。
3. 每次改完必跑 `tools/check.py`（0 断链、0 JSON 错才算过）；动过 `summon` / 刷怪蛋就再跑 `tools/gen_cleanup.py` 刷新清场清单。
4. 涉及职业的改动要同步**七处**：`kit/`、`kit/info/`、`kit/list/`、`util/give_kit`、`kit/random(_astral)`、`load`+`tick` 钩子、`ai-content/06-kit-registry.md`（+README 计数）。
5. 卡面（`kit/info`）有统一风格：`dark_gray` 分隔线、`gray` 标签、`white` 正文、`gold` 数字、职业名用其主题色；`tools/highlight_cards.py` 会把数字染成 gold（**卡面里避免写 "680" 这种会被误染的数字串**）。
6. **1.20.1 红线**：无 `return` / `tick` / `random` 命令、无宏；旧版 NBT；`clickEvent` 必须带前导 `/`。
7. **分支**：`main` 是主线。`origin/测试` 是朋友的在研分支（地球召唤池 33→75、六十多个 debug 探针、版本号自报），**不要整体合并**；需要里面的单个特性时按特性 cherry-pick，落地后重新对账编号与随机池（`06` 总表 / `07` 的 `#pool_size`）。

---

## 3. 当前职业与编号

| 区块 | 编号 |
|---|---|
| 经典 | 1–15（战士…炸弹兵），里系列 16–33 段内已实现的若干 |
| 混沌 | **45 混沌战士**、**46 混沌弓箭手** |
| 星象 | **65 太阳 / 66 水星 / 67 金星 / 68 地球 / 69 哈雷彗星 / 70 火星 / 71 冥王星** |
| 其它 | 87 文明小子、88 李朱俊泽 |

自由编号：47–64、72–76、89+。新增星象请从 **72** 往后加（星象块 65–76，65–71 已用）。

---

## 4. 本批次实现的机制（改之前先读对应文件）

| 机制 | 入口 | 要点 |
|---|---|---|
| 混沌战士：耗材武器池 | `kit/chaos.mcfunction`、`kit/chaos_use/break/next/wipe`、`tools/gen_chaos.py` 生成 21 把 | 武器 "碎不碎" 由 `chaos_uses` 决定，物品一律 `Unbreakable:1b`；`chaos_wipe` 每行都要 `if data` 守卫（clear 匹配 0 个会中止整份函数） |
| 诅咒剑（火星 & 混沌池） | `skill/mars/target|curse_hit|curse`、`kit/chaos_hit` | **先判诅咒再 chaos_use**（chaos_use 会在第四次命中时换掉武器）；命中目标用"3.2 格最近实体"，必须排除施法者 |
| 火星：地鸣 | `skill/mars/domain_cast|giant_spawn|giant_tick|giant_end|song_end|wild_*` | `#mars_active` 状态机；巨人死→驾驶员连坐；驾驶员死→只停音乐；歌放完（1810t）清巨人；生灵走地球召唤池（`skill/earth/random`） |
| 混沌弓箭手：魔法箭 | `skill/chaos_archer/arrow|cast` | 17 支箭，`Duration` 必须整数；`archer_shot` 必须带 `kitpvp.kit=46` 闸门 |
| 手炮（混沌池） | `kit/chaos_xbow_check|chaos_xbow_fired`、`predicates/chaos_xbow_charged.json` | 预装填弩用 `Charged` 1→0 判定 |
| 三叉戟 | `kit/chaos_shot_tri|chaos_tri_settle` | 投掷挂 pending，飞完才扣；飞行中的混沌三叉戟在 `wipe` 里按 `Trident.tag` 清理 |
| 哈雷彗星 | `kit/halley`、`skill/halley/*` | 护甲 15（钻石靴 +1 甲 / +2 韧）；岩浆怪蛋 `Size:0`；温度升高**全服广播**；天堂制造 actionbar 只给自己 |
| 音乐 | `debug/music*`、`debug/music_rumbling`、rumbling 数据包 | 点歌要同时起音乐 + 歌词；`debug/music_stop` 一并停 |
| 清场 | `game/li_purge|li_purge_verify`、`game/reset` | 狼 + iLsacuL 共用"拖到玩家身上→杀→隔刻复核" |
| debug | `debug/on`、`debug/dummy`、`debug/dummy_clear` | 训练假人：30 血铁套僵尸，`spreadplayers` 落地表 |

---

## 5. 本批次踩过的坑

**全部写在 `ai-content/04-hazards-reminder.md` 第十七节**（Duration 整数、属性 Amount 口径、@e 包含自己、统计口径陷阱、共享物品闸门、Tame 字段消失、Trident 字段、音乐 speed 换算、未加载区块清场、NoAI 浮空、spreadplayers 落地）。开工前务必读一遍那一节。

---

## 6. 已知脆弱点（可能会咬人）

1. **咒语链路的"最近实体"近似**：目标是两个贴在一起的实体时可能记错人；同理 `player_hurt_entity` 拿不到真实目标。若要彻底解决，可改成"给被击中的实体在受击时打 tag"（需要额外的 hurt 事件源）。
2. **音乐/歌词在存档、不在 git**：换机器或重装存档会丢；`tools/gen_rumbling_lyrics.py` 是重新生成的唯一来源，改完要重跑。
3. **`tick.mcfunction` 已分层（2026-11-15）**：每刻入口只剩 10 行模块调用（life / lobby / kits_a..f / player / world），
   外加两个慢拍闸门（slow2 每 2 刻、slow4 每 4 刻）。每刻命令从 381 降到 313；再加职业请往对应 `tick/kits_*` 或
   慢拍里加，**别把 `tick.mcfunction` 重新写胖**。
4. **手炮一发就碎（uses=1）**：若嫌太快，改 `gen_chaos.py` 里 `uses` 并重跑。
5. **地鸣的 1810t 收尾是硬编码**：音乐换版本要同步改这个数。
6. **debug 假人可能刷在侧后方**（spreadplayers 就近找地面），需要"始终在正前方"的话得重写落点逻辑。

---

## 7. 推荐的下一步（按收益排序）

1. **统一清场**：把所有召唤物/衍生实体纳入一条 `game/purge_entities`，`end`/`reset` 只调它。
2. **`tools/new_kit.py` 脚手架**：输入编号/名字自动生成七处，把"加职业"从 7 次手改变成一个命令。
3. **批量补简单职业**：1.12.2 的 KitNum 3 / 4 / 5 / 33 / 42 / 62 / 64（纯被动或单效果），一天能把职业数推到 43+。
4. **数值对照表**：把 1.12.2 的 63 个 KitNum 抽成 CSV，和现包逐行对照，平衡调整不再凭感觉。
5. **`debug/smoke` 冒烟测试**：遍历全部职业跑一次主动技能，输出失败清单。
6. **tick 分层**：`tick_core`（状态机）+ `tick_slow`（每 2/4 刻一次的技能计时）。

---

## 8. 新对话开场 prompt（可直接粘贴）

> 项目在 `D:\mc-kitpvp`，是 1.20.1 纯数据包的 KitPvP，职业战争。先读 `ai-content/00-version.md`、`03-project-spec.md`、`04-hazards-reminder.md`（尤其第十七节）、`05-skill-patterns.md`、`06-kit-registry.md`，再跑一次 `tools/check.py` 确认基线干净。约定：**先给方案再写代码**；一次提交一个主题；改完必须 `check.py` 通过并 push 到 `origin/main`；1.20.1 语法红线见 `00-version.md`。当前状态与最近机制见 `ai-content/HANDOFF.md`。

---

## 9. 常用命令速查

```powershell
# 校验
.\.venv\Scripts\python.exe tools/check.py

# 生成混沌武器 / 卡面高亮 / 歌词
.\.venv\Scripts\python.exe tools/gen_chaos.py
.\.venv\Scripts\python.exe tools/highlight_cards.py
.\.venv\Scripts\python.exe tools/gen_rumbling_lyrics.py

# 提交
git add -A src; git commit -m "..."; git push origin main
```

游戏内（玩家视角）：`/reload`、`/function kitpvp:debug/on`（debug 菜单）、`/function kitpvp:kit/<名字>`。
