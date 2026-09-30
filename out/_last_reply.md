## 一、直接回答：`[name=...]` 不行

`name=` 选择器参数匹配的是**实体的 `CustomName`** —— 也就是被命名牌命名过的、或者 `/summon` 时手写 `{CustomName:'...'}` 的实体才有。

刷怪蛋右键生成的末影人/铁傀儡**不携带任何自定义 NBT，也不会继承令牌物品上的 `KitAssassinEgg:1b` / `KitTankEgg:1b`**。物品上的 NBT 和生成出来的实体 NBT 是两码事，原版不会搬运。所以：

- `@e[type=enderman,name=隐匿令牌]` → 永远匹配不到任何实体
- `@e[type=enderman,nbt={KitAssassinEgg:1b}]` → 同理，匹配不到
- `@e[type=enderman,tag=xxx]` → 也匹配不到，因为没人给这只实体的 `Tags` 数组写东西（只有 `/summon` 能写）

想让刷怪蛋生成出来的那**一只**带有标记，**在纯数据包里做不到**——`used` 统计只告诉你"玩家右键了刷怪蛋"，不告诉你"哪只末影人是刚出生的"。除非你在同一刻手动扫描"新出现的末影人"，但末影人会移动/会瞬移/会被别的东西杀掉，用位置或计数都不可靠。

---

## 二、可行的替代方案

按改动量从小到大排：

| 方案 | 是否精确 | 改动 | 前置约束 |
|---|---|---|---|
| A. 地图不放该类实体，保留全局 `kill` | 差 | 0 | 地图层面禁止 |
| B. 令牌换成投掷物（雪球/鸡蛋），按 `type=` 清 | 好 | 小 | 地图不放该投掷物 |
| C. **令牌换成"带自定义 NBT 的消耗品" + `minecraft:consume_item` advancement** | 最好 | 中 | 无 |
| D. 地图装饰改用"无 AI 的其他 type"或盔甲架+头颅 | 差 | 地图层面 | 地图作者配合 |

- **A**：把地图装饰用的末影人/铁傀儡**全部删掉**，然后代码保持现在这样全局 `kill`。因为地图上再也没有别的同类实体，全局清也等于精确清。
- **B**：令牌改成 `minecraft:snowball`（坦克）、`minecraft:egg`（刺客），`kill @e[type=snowball]` / `kill @e[type=egg]`。投掷物天然会消失，比末影人干净。**但**：雪球/鸡蛋是堆叠物品，`minecraft.used:` 统计不分 NBT，地图上若散落雪球/鸡蛋就会被误触发。
- **C**：见下节。这是唯一能"精确到令牌 NBT"的方案。
- **D**：比如地图上想让两只末影人当装饰，把它们换成"无 AI 的盔甲架戴着头颅"，或换成别的 type（猪、蝙蝠之类）。

---

## 三、推荐方案 C 的思路

**不再用刷怪蛋**，把令牌做成"带自定义 NBT 的水瓶"（或曲奇、干海带、蜂蜜瓶等任何可食用的东西），然后：

- 玩家右键 **喝掉** → 触发 advancement `minecraft:consume_item`
- advancement 的 `item` 条件**精确匹配 NBT**，只有"带 `KitToken:1b` 标记的水瓶"才会触发
- advancement 的 `rewards.function` 直接指向 `skill/assassin_cast`

这样：

- **不再需要清任何实体**（消耗品吃完就没了）
- **不再需要 `used` / `last` 统计 objective**（也不需要 load 里创建它们）
- **不会和地图上的水瓶互相污染**（NBT 精确匹配）
- 与弓箭手的 `archer_pickup` 是同一套"advancement 触发 + revoke"模式，风格统一

大致形态（**`minecraft:consume_item` 这个 trigger 在 1.20.1 我印象里存在，但请你务必用一个小测试 advancement 实测确认，或查阅 1.20.1 官方 advancement 文档，不要直接抄**）：

src/data/kitpvp/advancements/player/assassin_cast.json

```json
{
  "criteria": {
    "drink": {
      "trigger": "minecraft:consume_item",
      "conditions": {
        "item": {
          "items": ["minecraft:potion"],
          "nbt": "{KitAssassinToken:1b}"
        }
      }
    }
  },
  "rewards": {
    "function": "kitpvp:skill/assassin_cast"
  }
}
```

调用链：

- `player/join.mcfunction`：加一行 `advancement revoke @s only kitpvp:player/assassin_cast`（保证新会话能触发）
- `skill/assassin_give_item.mcfunction`：`give @s minecraft:potion{KitAssassinToken:1b,display:{Name:'{"text":"隐匿药水","color":"dark_purple","bold":true}'}} 1`
- `skill/assassin_cast.mcfunction`：**首行**先 `advancement revoke @s only kitpvp:player/assassin_cast`，再走 `cd <= 0 → assassin_fire` 的分流
- `tick.mcfunction`：删掉"刺客/坦克用于检测 used>last 的行"、"清末影人/铁傀儡的行"、"void 兜底补发判断 Inventory NBT 的行"（补发改成判断"背包里没带 `KitAssassinToken:1b` 的水瓶"），补发行改为读取 `advancement` 状态或直接沿用 `cd=0` 判据
- `load.mcfunction`：`assassin_used` / `assassin_last` 这两个 objective 可以退役（也可以留着不碍事）
- `util/clear_player.mcfunction`：删掉两行 `operation ... assassin_last = ...`，并把"退不掉"的 `advancement revoke` 加进来

坦克同理，只要换一个**不同的**消耗品（例如曲奇 `minecraft:cookie`），advancement 各自精确匹配各自的 NBT。

---

## 四、我的建议

- **短期、不想动地图、也不想换令牌物品**：选 **A**，把地图装饰里的末影人/铁傀儡清掉。代价是"地图里永远不能出现末影人和铁傀儡"，用一个 `kill @e[type=enderman]` / `kill @e[type=iron_golem]` 全局清也说得过去。
- **想彻底摆脱这个坑**：选 **C**。虽然要新建两个 advancement 并改一圈文件，但从此"技能触发"和"清实体"这件事完全解耦，未来再做召唤类技能也不会互相干扰。
- **B 我不推荐**，因为雪球/鸡蛋/投掷物的 `used` 统计同样不分 NBT，跟刷怪蛋是同类问题，只是从"不能精确清实体"变成"不能精确区分来源"。

你决定走哪条，我按那条把相关的 `.mcfunction` 全量改好给你，包括 `load.mcfunction` 的 objective 增删和 `player/join` 的 revoke 行。