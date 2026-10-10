# ===== 结算后的清理与重置 =====
# 由 kitpvp:game/end 通过 schedule 在 200 刻（10 秒）后调用
# 对应设计文档 2.11 第 3~7 步
#
# 玩家清场 100% 走 util/clear_player，不额外补 kit 归零
# （clear_player 已经把 kitpvp.kit 一起清了）

# --- 一、玩家清场 ---
execute as @a run function kitpvp:util/clear_player

# --- 二、送回主大厅 ---
# lobby/enter 负责打上 kitpvp.in_lobby
# 大厅坐标待定，取消注释并填坐标
# tp @a <x> <y> <z>
execute as @a run function kitpvp:lobby/enter

# --- 三、清除非玩家实体 ---
# TODO: 白名单待定（设计文档 2.11：保留玩家、画、物品展示框、永久装饰、地图所需载具）
# 下列骨架会误伤画/展示框，未验证前不要取消注释
# kill @e[type=item]
# kill @e[type=arrow]
# kill @e[type=area_effect_cloud]
# kill @e[type=!player,type=!item_frame,type=!painting]

# --- 四、地图方块回滚 ---
# 各图自己的 restore 用 place template 覆盖回初始地形
# 依赖：#global kitpvp.map（1 = 沙漠，7 = 地球）
function kitpvp:map/restore

# --- 五、全局状态归零，允许下一局 ---
scoreboard players set #survivors kitpvp.game 0
scoreboard players set #tick kitpvp.game 0
scoreboard players set #state kitpvp.game 0

tellraw @a [{"text":"[系统] ","color":"gray","bold":true},{"text":"本局已重置，回到主大厅","color":"gray"}]