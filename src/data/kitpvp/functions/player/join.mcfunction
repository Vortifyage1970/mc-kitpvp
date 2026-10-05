# 玩家加入服务器
# ===== 玩家生命周期起点 =====
# 由根 tick 通过 [tag=!kitpvp.joined] 检测触发

# 登记已加入，防止 tick 每刻重复触发
tag @s add kitpvp.joined

# 基础状态初始化
scoreboard players set @s kitpvp.kit 0
scoreboard players set @s kitpvp.cd 0
scoreboard players set @s kitpvp.cd2 0
scoreboard players set @s kitpvp.alive 1
scoreboard players set @s kitpvp.lives 3
scoreboard players set @s kitpvp.kills 0
scoreboard players set @s kitpvp.deaths 0
scoreboard players set @s kitpvp.inv 0
scoreboard players operation @s kitpvp.death_seen = @s kitpvp.death_detect
scoreboard players set @s kitpvp.item 0
# 坦克统计快照：把 last 推到当前 used，防止老玩家一进服被误判"刚用掉令牌"
scoreboard players operation @s kitpvp.tank_last = @s kitpvp.tank_used
scoreboard players operation @s kitpvp.assassin_last = @s kitpvp.assassin_used
# 主大厅准备钓竿快照：老玩家身上的历史钓鱼竿右键不会被算成"点了一次准备"
scoreboard players operation @s kitpvp.ready_last = @s kitpvp.ready_used
scoreboard players operation @s kitpvp.soul_warrior_last = @s kitpvp.soul_warrior_used
scoreboard players operation @s kitpvp.soul_archer_last = @s kitpvp.soul_archer_used

# 进入主大厅（负责 add kitpvp.in_lobby）
function kitpvp:lobby/enter
                                           