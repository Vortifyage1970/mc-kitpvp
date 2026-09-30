# ===== 重生后处理 =====
# 由根 tick.mcfunction 在玩家重生于 spawnpoint 之后调用
# 此时原版已经把玩家放到 spawnpoint 上（doImmediateRespawn=true）

# 消费标记
tag @s remove kitpvp.respawn_pending

# 死亡会清空全部药水效果，重生后重新挂上职业被动
# 其他职业有被动时，在此按同格式追加
execute if score @s kitpvp.kit matches 3 run function kitpvp:kit/tank_passive

# 重生后补发举盾令牌（如果死亡时背包里已经没有了）
execute if score @s kitpvp.kit matches 3 run function kitpvp:skill/tank_give_egg

# 5 秒无敌
function kitpvp:player/invincible

# 提示
playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1.2
