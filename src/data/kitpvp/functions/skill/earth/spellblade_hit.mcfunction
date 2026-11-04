# 术战士打中人的结算（@s = 挨打的那个玩家）
# 触发在 tick.mcfunction 里：挨打那一帧 + 身边 3 格内有术战士。不再用 advancement（那套条件从没触发过）
# 排查用计数：每次结算 +1，游戏里 /scoreboard players get @s kitpvp.earth_hit_hits 可查
scoreboard players add @s kitpvp.earth_hit_hits 1
title @s actionbar [{"text":"术战士 命中","color":"aqua"}]

# 每挨一刀就在脚下铺一格细雪，10 秒（200 刻）后由 tick 收回；只在脚下是空气时铺，不覆盖地图方块
# 细雪冻伤在 140 刻（7 秒）开始、之后每 40 刻一下：被埋满 10 秒的人会吃到 1~2 下冰冻伤害
scoreboard players set #snow_time kitpvp.game 200
execute at @s if block ~ ~ ~ #minecraft:air run function kitpvp:skill/earth/snow_place
