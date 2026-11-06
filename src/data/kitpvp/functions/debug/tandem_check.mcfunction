# 排查用：站在串联体旁边跑 /function kitpvp:debug/tandem_check
# 只要 tick 里那轮 aura 跑过，就有一只带 kitpvp.tandem_near 标记 —— 下面的"近"打的就是它
tellraw @s [{"text":"=== 串联体 · 近的那只 ===","color":"gold","bold":true}]
tellraw @s [{"text":"血量 ","color":"gray"},{"nbt":"Health","entity":"@e[tag=kitpvp.earth_tandem,tag=kitpvp.tandem_near,limit=1]"},{"text":"  效果 ","color":"gray"},{"nbt":"ActiveEffects","entity":"@e[tag=kitpvp.earth_tandem,tag=kitpvp.tandem_near,limit=1]"}]
tellraw @s [{"text":"=== 串联体 · 远的那只 ===","color":"aqua","bold":true}]
tellraw @s [{"text":"血量 ","color":"gray"},{"nbt":"Health","entity":"@e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_near,limit=1]"},{"text":"  效果 ","color":"gray"},{"nbt":"ActiveEffects","entity":"@e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_near,limit=1]"}]
tellraw @s [{"text":"读法：近的只该有 slowness(id 2)、远的只该有 speed(id 1)；两行都空 = aura 这一轮没跑到（看后面两行）","color":"dark_gray","italic":true}]
execute if entity @e[tag=kitpvp.earth_tandem] run tellraw @s [{"text":"✔ 场上有一对","color":"green"}]
execute unless entity @e[tag=kitpvp.earth_tandem] run tellraw @s [{"text":"✘ 场上没有串联体","color":"red"}]
execute if entity @e[tag=kitpvp.earth_tandem,tag=kitpvp.tandem_near] run tellraw @s [{"text":"✔ tag 已打上（说明 pick 跑过）","color":"green"}]
execute unless entity @e[tag=kitpvp.earth_tandem,tag=kitpvp.tandem_near] run tellraw @s [{"text":"✘ 没有 tandem_near：aura 没被触发（走到 8 格内、且 cd 归零才会）","color":"red"}]
