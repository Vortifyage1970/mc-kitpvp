# 十连蛋被用掉：推进快照、清掉刷出来的熊猫、进入十连
scoreboard players operation @s kitpvp.li_ten_last = @s kitpvp.li_ten_used
execute at @s run kill @e[type=minecraft:panda,distance=..8]
function kitpvp:skill/li_ench/ten_draw
give @s minecraft:panda_spawn_egg{KitLiTen:1b,Enchantments:[{id:"minecraft:unbreaking",lvl:1s}],display:{Name:'{"text":"十连","color":"gold","italic":false}',Lore:['{"text":"右键：受 20 点伤害连抽十次（冷却 15 秒）","color":"gray","italic":false}']}} 1
