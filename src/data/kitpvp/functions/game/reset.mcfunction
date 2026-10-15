# 结算清理：game/end 用 schedule 在 200 刻后调用（设计文档 2.11 第 3~7 步）
execute as @a run function kitpvp:util/clear_player

# 回大厅（坐标见 lobby/spawn 顶部的坐标注册表）
execute as @a run function kitpvp:lobby/enter

# 非玩家实体：清掉落物 + 我们自己召唤出来的东西，避免误伤画 / 物品展示框 / 地图装饰。
# 约定：每新增一种召唤物，就在这里追加一行对应的 kill（A2）。

function kitpvp:map/restore

kill @e[type=item]
kill @e[tag=kitpvp.ghost_minion]
kill @e[tag=kitpvp.turret]
kill @e[tag=kitpvp.token_turret]
kill @e[tag=kitpvp.token_core]
kill @e[tag=kitpvp.werewolf_token]
kill @e[type=wolf]

# 里·渔夫的两个令牌生物（发光鱿鱼 / 鱿鱼）：按 tag 清，不碰地图里的鱿鱼
kill @e[tag=kitpvp.tainted_fisher_blue_token]
kill @e[tag=kitpvp.tainted_fisher_domain_token]

# 测试用召唤物（summon/zombie_iron_helmet、summon/zombie_iron_armor）：按 tag 清，不碰地图里的僵尸
kill @e[tag=kitpvp.test_dummy]

# 领域展开的雨：load 关了 doWeatherCycle，雨不会自己停 —— domain_end 之外的兜底（见 04 §五）
weather clear

# 驯兽师（kit 11）放出的动物是本职业的产品，不当场清，改在这里按类型清。
# 必须按类型而不是按 tag：繁殖出的后代不带 tag，认不出来（见 04 §五）。
# tag=!kitpvp.displayitem 护住模板里的装饰动物（见 04 §七）。
kill @e[type=minecraft:wolf,tag=!kitpvp.displayitem]
kill @e[type=minecraft:horse,tag=!kitpvp.displayitem]
kill @e[type=minecraft:parrot,tag=!kitpvp.displayitem]
kill @e[type=minecraft:dolphin,tag=!kitpvp.displayitem]
kill @e[type=minecraft:fox,tag=!kitpvp.displayitem]
kill @e[type=minecraft:frog,tag=!kitpvp.displayitem]
kill @e[type=minecraft:tadpole,tag=!kitpvp.displayitem]
kill @e[type=minecraft:turtle,tag=!kitpvp.displayitem]
kill @e[type=minecraft:goat,tag=!kitpvp.displayitem]
kill @e[type=minecraft:salmon,tag=!kitpvp.displayitem]

scoreboard players set #survivors kitpvp.game 0
scoreboard players set #tick kitpvp.game 0
scoreboard players set #state kitpvp.game 0

tellraw @a [{"text":"[系统] ","color":"gray","bold":true},{"text":"本局已重置，回到主大厅","color":"gray"}]
