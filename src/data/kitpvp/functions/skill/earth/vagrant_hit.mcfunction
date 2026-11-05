# 流浪汉打中人的结算（@s = 挨打的那个玩家）
# 触发在 tick.mcfunction 里：挨打那一帧 + 身边 3 格内有流浪汉。不再用 advancement（那套条件从没触发过）
# 排查用计数：每次结算 +1，游戏里 /scoreboard players get @s kitpvp.earth_hit_hits 可查
scoreboard players add @s kitpvp.earth_hit_hits 1
title @s actionbar [{"text":"流浪汉 命中","color":"green"}]

# 反胃 5 秒（时长单位是秒）
effect give @s minecraft:nausea 5 0 true

# 再塞一瓶"口水"：普通药水（饮用型），喝下去反胃 10 秒 = 200 刻；水做底，效果全走 CustomPotionEffects
give @s minecraft:potion{Potion:"minecraft:water",CustomPotionEffects:[{Id:9b,Amplifier:0b,Duration:200}],display:{Name:'{"text":"口水","color":"dark_green","italic":false}'}} 1
summon minecraft:item ~ ~ ~ {PickupDelay:0s,Tags:["kitpvp.junk_new"],Item:{id:"minecraft:flint",Count:1b,tag:{display:{Name:'{"text":"燧石","color":"gray","italic":false}'},kitpvp:{serial:0}}}}
summon minecraft:item ~ ~ ~ {PickupDelay:0s,Tags:["kitpvp.junk_new"],Item:{id:"minecraft:wheat_seeds",Count:1b,tag:{display:{Name:'{"text":"小麦种子","color":"yellow","italic":false}'},kitpvp:{serial:0}}}}
execute as @e[tag=kitpvp.junk_new] at @s run function kitpvp:skill/earth/junk_serial

# 燧石与种子走"掉出来 + 写唯一序号"，和 COSER 的物料同款，捡到手永远不叠
# 不给细雪：流浪汉只管反胃 + 口水 + 燧石 + 种子（细雪那套留给术战士，回收逻辑仍是 skill/earth/snow_clear）
