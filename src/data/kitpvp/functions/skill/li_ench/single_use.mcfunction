# 单抽蛋被用掉：推进快照、清掉刷出来的骆驼并补回一张蛋、进入单抽
scoreboard players operation @s kitpvp.li_single_last = @s kitpvp.li_single_used
execute at @s run kill @e[type=minecraft:camel,distance=..8]
function kitpvp:skill/li_ench/single_draw
give @s minecraft:camel_spawn_egg{EntityTag:{Silent:1b,NoAI:1b,NoGravity:1b,Invulnerable:1b,PersistenceRequired:1b},KitLiSingle:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:1s}],display:{Name:'{"text":"单抽","color":"light_purple","italic":false}',Lore:['{"text":"右键：受 3 点伤害抽一次（冷却 2 秒）","color":"gray","italic":false}']}} 1
