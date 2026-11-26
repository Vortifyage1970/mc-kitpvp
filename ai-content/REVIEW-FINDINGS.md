# 审查发现清单（REVIEW-FINDINGS）

> 生成方式：多智能体按 8 个子系统分头审计（对照 `ai-content/REVIEW.md` 的不变量清单），
> 共 25 条原始发现；**再由我逐条核实**（子代理会误报），结论如下。
> 代码是真相；本清单与 `tools/check.py` + `tools/smoke.py` 一起构成可持续审查体系。

## 结论速览

| 分类 | 条数 |
|---|---|
| 真实 bug —— 已修 | 10 |
| 真实问题 —— 记录待定（复杂度/风险，暂不自动改） | 2 |
| 误报（已核实不成立） | 2 |
| 文档/注释不一致 —— 已修 | 11 |

---

## A. 真实 bug（已修）

| # | 位置 | 问题 | 修法 |
|---|---|---|---|
| 1 | `reset_entities` | 史莱姆魂石载体 tag `kitpvp.soul_slime_token` 不在清场表 → 跨局残骸 | `gen_cleanup.py` 的 `EGG_RE` 从 `EntityTag:{Tags:[` 放宽到 `EntityTag:{`（原正则漏掉 `EntityTag:{Size:0,Tags:[...]}` 这种顺序），重跑后 112→**114** 个 tag |
| 2 | `util/clear_player` | `scoreboard players set @a kitpvp.fisher_no_tri 0`（应为 `@s`）→ 任一玩家选职会清掉全场渔夫的补戟计时 | 改 `@a`→`@s` |
| 3 | `tick/kits_a` + `tick/slow2` | 里·弓箭手炮台/熔火核心**令牌永远补不回来**：`kits_a`（每刻，先跑）在 `cd=0` 时已把 `cd` 置 1200，而真正 `give_token_*` 在 `slow2`（后跑）且要求 `cd=0` → 永不同时成立；还每 60s 假报「+1」 | 把 `give_token_turret/core` 挪进 `kits_a`、放在置 cd **之前**；删掉 `slow2` 里那两条永不命中的死行 |
| 4 | `skill/soul/earth_team_id` | 先 `util/team_index` 得 `#steam`（幽灵主人=1..6）后又无条件 `matches 1..6 → +18`，把幽灵主人误算成地球段 → 召出的生灵 join 到 `earth_N` 而主人还在 `ghost_N`，**生灵打主人** | 新增 `earth_assign.mcfunction`：只有 `#steam==0`（原本不在任何队）时才 link+etid+18；`earth_team_id` 仅 `matches 0` 时调它 |
| 5 | `tick/slow2`（哈雷） | 天堂制造入口缺 `at @s`，`cast` 里 `~` 的粒子和音效落在函数执行点（世界原点）而非玩家处 | 入口补 `at @s` |
| 6 | `load` | `kitpvp.soul_next` 被 `objectives add` 两次（同名第二条静默失败） | 删掉重复的一条 |
| 7 | `load` | 传送门 reload 清理只删 `tep_a/tep_b`，漏 `tep_r/tep_p/tep_portal` | 补三行 `kill @e[tag=...]`（`reset_entities` 本来已全，仅 /reload 的兜底） |

> 编号 1/2 在 agent 报告里各出现两次（state-reset 与 load/clear 分头命中），去重后合并。

## B. 真实问题 —— 记录待定（未自动改）

| # | 位置 | 问题 | 为什么先不改 |
|---|---|---|---|
| 8 | `skill/tainted_farmer/leader_tick` + `wave_wood` | 里农夫「两条波次错开 6 秒」实际不成立：木锄波次依赖「场上已有石锄」，而首只石锄要到 12 秒才出现，`#tf_wave2` 在 0 干等，于是石锄与木锄同刻触发、此后永久同步（0 偏移） | 属节奏手感问题；修法涉及波次相位对齐，需实机调，不宜盲改。计划：让 `#tf_wave2` 在无石锄时也保持相位（如空转时重置为 240 而非停在 0） |
| 9 | `skill/tainted_archer/team_slot` | 部署炮台时无条件 `team join turret_N @s`，未先 `util/team_index` 判断主人是否已在别的队（魂石进过队时会把主人搬出原队，旧召唤物翻脸） | 与不变量⑤一致但属边界；修法要沿用 ghost/farmer 的「有队沿用」写法，需配合炮台队语义验证，记录待办 |

## C. 误报（已核实不成立，无需改）

| # | agent 说法 | 核实结论 |
|---|---|---|
| 10 | 「火星地鸣入口卡 `kit=70` 违反共用蛋不变量（high）」 | **不成立**。地鸣蛋只有火星自己会拿到；非火星用幽灵魂石时 `mars_domain_used` 增长由 `dispatch` 首行推进 `mars_domain_last`（入口是 `kit=70` 才进，非火星不进 → last 不推进但 used 也只在非火星手里增长，且他们永远变不回火星），无副作用。**保留 kit=70** |
| 11 | 「chaos_bow_last/tri_last 的 `unless score ... matches -2147483648..` 恒假、永不执行」 | **不成立**。分数未设置时 `matches` 判定失败 → `unless` 成立 → 首次初始化会执行（这正是该 idom 的用途）。仅「load/join 未显式初始化」在极端跨局下可能首刻误触一次，属低危，未改 |

## D. 文档/注释不一致（已修）

| # | 位置 | 修法 |
|---|---|---|
| 12 | `kit/random` 头注释只列 37 个职业 | 改写为「0..38 共 39 个；表 1..14/18/19，里 23..25/27..34，混沌 45/46，星象 65..71，抽象 87..89」 |
| 13 | `07` `#pool_size` 全职业写 38 | 改 39 |
| 14 | `kit/info/mars`「在随机玩家头顶召唤」 | 改「在施法者脚下 +8 召唤」（代码早已改 `at @s`） |
| 15 | `kit/info/mars`「每 1.5 秒刷生灵」 | 改「每 1.2 秒（24 刻）」 |
| 16 | `06` 火星行「诅咒剑用 ChaosCurse」 | 改「用 `KitMarsSword`；`ChaosCurse` 是混沌池那把」 |
| 17 | `skill/mars/curse` 注释「凋零 II」 | 改「凋零 I」（效果 amplifier 0） |
| 18 | `kit/info/tainted_farmer` 召集冷却「60 秒」 | 改「45 秒」 |
| 19 | `kit/info/farmer` / `kit/info/tainted_farmer` 面包「再生 II 4 秒」 | 改「再生 II + 抗性 II 各 5 秒」；同步 `tools/gen_cards.py` 源串 |
| 20 | `summon/tainted_farmer_leader` 注释「250 血僵尸」 | 改「200 血僵尸」 |
| 21 | `07` `tf_owner` 消费者写 `skill/tainted_farmer/join_own`（不存在） | 改 `util/team_join` |
| 22 | `tick/kits_c` 注释「冥王星（kit 76）」 | 改 kit 71 |
| 23 | `reset` 里 tep bossbar 未清 players（low） | 经核实 tep_hud_* 是每刻 `players @a[...]` 全量重设的组播 HUD，**自清**，不属"按玩家显示"，不需要清（与不变量⑥的判据一致）——不改 |

---

## 这套审查怎么持续用

1. 改完一定跑：`tools/check.py`（含 8 类不变量 lint）+ `tools/smoke.py`（入口 + 39 职业）。
2. 审代码：只审 `ai-content/REVIEW.md` §3.1 的必读文件 + 每个子系统抽 1 个代表；其余交给 lint。
3. 审提交：`git diff` 优先看动了 `load / util / game / tick / skill/soul` 的。
4. 需要重跑多智能体审查时：分系统各派一个子代理，喂 `REVIEW.md` 的不变量清单，要求"证据 + 严重度"，结果**必须人工复核实**（本次 25 条里就有 2 条误报）。
