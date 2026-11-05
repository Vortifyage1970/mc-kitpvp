# 术战士打中人的结算（@s = 挨打的那个玩家）
# 触发在 tick.mcfunction 里：挨打那一帧 + 身边 3 格内有术战士。不再用 advancement（那套条件从没触发过）
# 排查用计数：每次结算 +1，游戏里 /scoreboard players get @s kitpvp.earth_hit_hits 可查
# ★ 剑上带火焰附加：目标挨刀时正在燃烧，脚下那格细雪会被原版"着火实体碰到细雪"的规则当场拆成空气，
#   同时把目标的火扑掉（方块被消耗掉）。这不是计时器坏了（Wiki: Powder Snow — Breaking）。
#   用户认可这个表现：术战士 = 点火 + 顺手灭火，只有目标没着火时细雪才会留满 10 秒
scoreboard players add @s kitpvp.earth_hit_hits 1
title @s actionbar [{"text":"术战士 命中","color":"aqua"}]

# 每挨一刀就在脚下铺一格细雪，10 秒（200 刻）后由 tick 收回
# 只铺"空气"位置：不能写成 #minecraft:air —— 那个方块标签不一定存在，标签不存在时整条命令静默失败
# （sendCommandFeedback 是关的，连报错都看不见），所以这里把三种空气逐个点名
scoreboard players set #snow_time kitpvp.game 200
execute at @s if block ~ ~ ~ minecraft:air run function kitpvp:skill/earth/snow_place
execute at @s if block ~ ~ ~ minecraft:cave_air run function kitpvp:skill/earth/snow_place
execute at @s if block ~ ~ ~ minecraft:void_air run function kitpvp:skill/earth/snow_place