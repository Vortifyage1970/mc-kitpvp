# 结算清理：game/end 用 schedule 在 200 刻后调用（设计文档 2.11 第 3~7 步）
execute as @a run function kitpvp:util/clear_player

# tp @a <x> <y> <z>  ← 大厅坐标待定
execute as @a run function kitpvp:lobby/enter

# TODO: 非玩家实体清理白名单待定，未验证前不要取消注释（会误伤画 / 物品展示框）
# kill @e[type=item]
# kill @e[type=arrow]
# kill @e[type=area_effect_cloud]
# kill @e[type=!player,type=!item_frame,type=!painting]

function kitpvp:map/restore

scoreboard players set #survivors kitpvp.game 0
scoreboard players set #tick kitpvp.game 0
scoreboard players set #state kitpvp.game 0

tellraw @a [{"text":"[系统] ","color":"gray","bold":true},{"text":"本局已重置，回到主大厅","color":"gray"}]
