# 与 A 对称：1 秒后 A 还活着就复活 B，A 也没了就一起算死
execute if entity @e[tag=kitpvp.earth_twinstar_a] at @e[tag=kitpvp.earth_twinstar_a,limit=1] run function kitpvp:summon/earth_twinstar_b