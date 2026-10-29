# 有"本职业的蛋真的刷出了生物"（蛋带 EntityTag 打 kitpvp.tt_spawn_zombie）才算一次使用：
# 僵尸蛋在本服只有本职业发，但骷髅 / 恼鬼 / 烈焰人蛋与魂石共用，必须靠这层分流（见 04 §五）
# 冷却中（捡到别人丢的蛋）：不给召唤物，只把蛋刷出来的那只基础生物清掉
execute if score @s kitpvp.cd matches ..0 if entity @e[type=minecraft:zombie,tag=kitpvp.tt_spawn_zombie,distance=..8] at @e[type=minecraft:zombie,tag=kitpvp.tt_spawn_zombie,distance=..8,sort=nearest,limit=1] run function kitpvp:summon/tainted_tamer_zombie
execute if score @s kitpvp.cd matches ..0 if entity @e[type=minecraft:zombie,tag=kitpvp.tt_spawn_zombie,distance=..8] run function kitpvp:skill/tainted_tamer/start_cd1
kill @e[type=minecraft:zombie,tag=kitpvp.tt_spawn_zombie,distance=..8]
