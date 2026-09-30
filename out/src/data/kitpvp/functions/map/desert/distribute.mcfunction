# ===== 沙漠地图：9 个出生点随机分配给参战玩家 =====
# 逻辑：每次 @r 从"参战 + 未分配"的玩家集合里抽一个，依次放进各出生点
#   - 用 @s 把抽中的玩家传进 spawn_N，蹲点函数内 tp + spawnpoint + 打 tag
#   - @r[...] 在集合为空时静默跳过，不会报错
#   - 参战人数 < 9 时，只有前 N 个出生活点被占用，其余空置（预期）

execute as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_1
execute as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_2
execute as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_3
execute as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_4
execute as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_5
execute as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_6
execute as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_7
execute as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_8
execute as @r[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_9

# 兜底：若还有没分完的玩家（>9 人，正常不会发生），塞到出生点 1
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spawn_assigned,tag=!kitpvp.spectator] run function kitpvp:map/desert/spawn_1
