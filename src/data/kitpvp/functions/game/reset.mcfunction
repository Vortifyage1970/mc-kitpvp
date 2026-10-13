# 结算清理：game/end 用 schedule 在 200 刻后调用（设计文档 2.11 第 3~7 步）
execute as @a run function kitpvp:util/clear_player

# tp @a <x> <y> <z>  ← 大厅坐标待定
execute as @a run function kitpvp:lobby/enter

# 非玩家实体：清掉落物 + 我们自己召唤出来的东西，避免误伤画 / 物品展示框 / 地图装饰。
# 约定：每新增一种召唤物，就在这里追加一行对应的 kill（A2）。

function kitpvp:map/restore

kill @e[type=item]
kill @e[tag=kitpvp.ghost_minion]

scoreboard players set #survivors kitpvp.game 0
scoreboard players set #tick kitpvp.game 0
scoreboard players set #state kitpvp.game 0

tellraw @a [{"text":"[系统] ","color":"gray","bold":true},{"text":"本局已重置，回到主大厅","color":"gray"}]
