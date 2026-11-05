# 排查"无重力召唤物不动"：at @s 手动跑一次，看这几行数字
# 用法：先 /function kitpvp:summon/earth_dublinn，再
#   /execute as @e[tag=kitpvp.earth_dublinn,limit=1] at @s run function kitpvp:debug/dublinn_state
scoreboard players set #dbg_near kitpvp.game 0
execute store success score #dbg_near kitpvp.game if entity @p[distance=..6,sort=nearest]
tellraw @a [{"text":"=== 无重力搬家状态 ===","color":"gold"}]
tellraw @a [{"text":"本体: ","color":"gray"},{"selector":"@s"}]
tellraw @a [{"text":"位置: ","color":"gray"},{"nbt":"Pos","entity":"@s"}]
tellraw @a [{"text":"NoGravity: ","color":"gray"},{"nbt":"NoGravity","entity":"@s"}]
tellraw @a [{"text":"6 格内有玩家: ","color":"gray"},{"score":{"name":"#dbg_near","objective":"kitpvp.game"}}]
tellraw @a [{"text":"nograv_step 累计执行次数: ","color":"gray"},{"score":{"name":"#nograv_runs","objective":"kitpvp.game"}}]
tellraw @a [{"text":"乘客: ","color":"gray"},{"nbt":"Passengers","entity":"@s"}]