# ===== 重生后处理 =====
# 由根 tick.mcfunction 在玩家重生于 spawnpoint 之后调用
# 此时原版已经把玩家放到 spawnpoint 上（doImmediateRespawn=true）

# 消费标记
tag @s remove kitpvp.respawn_pending

# 5 秒无敌
function kitpvp:player/invincible

# 提示
title @s times 5 30 10
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.2