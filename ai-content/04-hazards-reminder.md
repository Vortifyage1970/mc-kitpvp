## 一、结算链路（game/end 与 game/reset）

1. `#state` 未置 1 = `end` 永不触发。这是目前最容易被漏掉的一环。
2. `schedule ... replace` 用 `replace` 模式，同一次结算内重复触发不会叠加多个 10 秒定时器；但 `game/end` 已被 `#state=2` 锁死，正常情况下不会被重复调用。
3. 0 幸存者不自动结算：如果最后两人互相耗死在同一刻，或剩下的人全部掉线，局会卡在"进行中"状态，需要管理员手动跑 `function kitpvp:game/end` 或 `function kitpvp:game/reset`。是否需要"平局自动结算"是设计决策，我按保守方案（不自动）写，需要改的话告诉我。
4. `reset` 里的 `kill @e` 白名单未定，画、物品展示框会被误杀，骨架已全部注释掉，未验证前不要取消注释。
5. 结算的 10 秒内玩家仍能互相攻击，设计文档第九节"无敌实现方式"未定，没有臆造抗性 V 或屏蔽伤害的方案。
6. `title @a times`、`schedule`、`playsound`、`tellraw` 的 `clickEvent` / `hoverEvent` 全部是 1.20.1 旧格式；若你在别处看到 `click_event`、`return`、`execute if items`、`function ... with {...}`，那都是 1.20.2+ 的写法，不要引入。

## 二、测试开关（debug/test）

1. `#test` 一旦为 1，自动判定胜利永远不触发。如果哪天你忘了关，跑正式局就不会结算。建议正式局前先跑一次 `function kitpvp:debug/test/status` 看 `#test` 是不是 0。
2. `build` 模式会摘掉 `kitpvp.selected`，这会让 survivors 统计少一个人。这是刻意的——建造期间不参与游戏统计。如果你就是想"边建造边参与统计"，用 `play` 而不是 `build`。
3. `force_reset` 里 `schedule clear kitpvp:game/reset` 只能清掉还没发射的那一次。如果 `end` 的 200t 倒计时已经跑完并执行了 `reset`，那 `force_reset` 只是再跑一次 `reset`，是幂等的，不会出错。
4. `solo_start` 和 `play` 都不做传送，因为大厅坐标和地图坐标还是 TODO。玩家会留在原地。等你确定坐标后，把 `solo_start` 末尾注释里的 `tp @s <x> <y> <z>` 取消注释即可。
5. `effect give ... instant_health 1 5 true` 是我用来代替 `/heal` 的写法（1.20.1 没有 `/heal` 命令，那是 Mod 提供的）。如果实测发现回不满，把 amplifier 调到 9。
6. 所有 `tellraw` / `title` / `clickEvent` 都是 1.20.1 旧格式，没有 `click_event`、`return`、`execute if items`、宏等 1.20.2+ 语法。同时注意下节的斜杠规则。

## 三、tellraw 的 clickEvent 必须带斜杠

单独拆成一节，因为写测试函数和菜单按钮时最容易在这里翻车。

**规则：`"action":"run_command"` 的 `value` 必须以 `/` 开头。**

这条命令是交给命令解析器执行的，没有前导斜杠就不是一条合法命令，点击后不会产生预期效果。

正确：

```json
{"text":"[开始游戏]","green","clickEvent":{"action":"run_command","value":"/function kitpvp:game/start"}}
```

错误（漏斜杠）：

```json
{"text":"[开始游戏]","color":"green","clickEvent":{"action":"run_command","value":"function kitpvp:game/start"}}
```

相关约定：

- `suggest_command` 的 `value` 是填进聊天输入框的内容，也建议带 `/`。
- `copy_to_clipboard` 的 `value` 是纯文本，是否带 `/` 按用途决定；想让玩家粘贴即可执行，就必须带。
- `hoverEvent` 用 `contents`，不要写成 `value`。
- 生成这些 JSON 时留意转义：外层用单引号包住整段 JSON 时，内部全部用双引号。
````