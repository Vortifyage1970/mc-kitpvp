# 窗口内每 20 刻刷新一次（tick 节流调用）：把 7 格内自己的炮台转成熔火形态并续期
# 只加强自己的炮台 —— 03 §2.8 无阵营，强化别人的炮台等于资敌
scoreboard players operation #ttid kitpvp.game = @s kitpvp.ttid
scoreboard players set #buffcnt kitpvp.game 0

execute as @e[tag=kitpvp.turret,distance=..7] if score @s kitpvp.turret_owner = #ttid kitpvp.game at @s run function kitpvp:skill/taint_archer/turret_to_molten
