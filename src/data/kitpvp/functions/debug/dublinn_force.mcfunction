# 用法：站在深池旁边跑 /function kitpvp:debug/dublinn_force
# 作用：把最近那只的出手冷却清零，并立刻调一次 dublinn_strike（不等 15 刻）
# 读法：3.5 格内有活人却没掉血 ⇒ 问题在 dublinn_strike 内部；掉了 ⇒ 只是冷却/触发器的问题
scoreboard players set #dl_dbg kitpvp.game 0
execute store result score #dl_dbg kitpvp.game if entity @e[tag=kitpvp.earth_dublinn,distance=..16]
tellraw @s [{"text":"[深池] 16 格内：","color":"gray"},{"score":{"name":"#dl_dbg","objective":"kitpvp.game"},"color":"yellow"},{"text":" 只","color":"gray"}]
execute as @e[tag=kitpvp.earth_dublinn,limit=1,sort=nearest] run scoreboard players set @s kitpvp.earth_cd_a 0
execute as @e[tag=kitpvp.earth_dublinn,limit=1,sort=nearest] at @s run function kitpvp:skill/earth/dublinn_strike
tellraw @s [{"text":"[深池] 已强制出手一次（若你 3.5 格内却没掉血，就是 dublinn_strike 里的条件没命中）","color":"dark_gray"}]
execute as @e[tag=kitpvp.earth_dublinn,limit=1,sort=nearest] run tellraw @a [{"text":"[深池] 这一只的主人分 earth_owner=","color":"gray"},{"score":{"name":"@s","objective":"kitpvp.earth_owner"},"color":"aqua"}]
