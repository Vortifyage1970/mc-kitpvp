# ===== 开局实现 =====
# 由 game/start 调用，此处不再做人数检查

# 1. 地图兜底：未选地图（#global <= 0）则随机/选默认
execute unless score #global kitpvp.map matches 1.. run function kitpvp:map/random

# 2. 状态切到"进行中"，并初始化全局倒计时
scoreboard players set #state kitpvp.game 1
scoreboard players set #global kitpvp.timer 480

# 3. 清掉本次开局不该带的 tag
tag @a[tag=kitpvp.selected] remove kitpvp.spectator
tag @a[tag=kitpvp.selected] remove kitpvp.in_lobby
tag @a[tag=kitpvp.selected] remove kitpvp.sudden_death
tag @a[tag=kitpvp.selected] remove kitpvp.respawn_pending

# 4. 冒险 → 生存
gamemode survival @a[tag=kitpvp.selected]

# 5. 分发到当前地图的出生点（同时写入 spawnpoint）
function kitpvp:map/distribute

# 6. 每人 5 秒无敌
execute as @a[tag=kitpvp.selected] run function kitpvp:player/invincible

# 7. 标题 + 音效（subtitle 必须在 title 之前设）
title @a[tag=kitpvp.selected] times 5 40 10
title @a[tag=kitpvp.selected] title {"text":"游戏开始","color":"gold","bold":true}
playsound minecraft:entity.ender_dragon.growl master @a[tag=kitpvp.selected] ~ ~ ~ 1 1.2

# 8. 启动全局计时器循环（8 分钟后进入突然死亡）
schedule function kitpvp:game/timer_tick 20t replace