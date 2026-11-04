# 流浪汉打中人的结算（@s = 挨打的那个玩家）
# 触发在 tick.mcfunction 里：挨打那一帧 + 身边 3 格内有流浪汉。不再用 advancement（那套条件从没触发过）
# 排查用计数：每次结算 +1，游戏里 /scoreboard players get @s kitpvp.earth_hit_hits 可查
scoreboard players add @s kitpvp.earth_hit_hits 1
title @s actionbar [{"text":"流浪汉 命中","color":"green"}]

# 反胃 5 秒（时长单位是秒）
effect give @s minecraft:nausea 5 0 true

# 再塞一瓶"口水"：普通药水（饮用型），喝下去反胃 10 秒 = 200 刻；水做底，效果全走 CustomPotionEffects
give @s minecraft:potion{Potion:"minecraft:water",CustomPotionEffects:[{Id:9b,Amplifier:0b,Duration:200}],display:{Name:'{"text":"口水","color":"green","italic":false}'}} 1
give @s minecraft:flint 1
give @s minecraft:wheat_seeds 1

# 细雪糊脸：1.20.1 没有"冰冻"这个状态效果，只能真铺一格细雪让人站进去 5 秒（铺 / 收回在 vagrant_snow 两个函数里）
# 只在脚下是空气时铺，不去覆盖地图上的方块
execute at @s if block ~ ~ ~ #minecraft:air run function kitpvp:skill/earth/vagrant_snow
