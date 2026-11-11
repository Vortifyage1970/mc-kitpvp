# 位置 = 玩家，@s = 玩家：找到脚边的载体蛋生物（猫），以它的位置调 tamer_apply
# 新版蛋带 EntityTag 标签；老版蛋只带 display.Name，tag 找不到时回退按名字 —— 两条都最多命中一次
execute at @e[tag=kitpvp.soul_tamer_token,distance=..8,sort=nearest,limit=1] run function kitpvp:skill/soul/tamer_apply
execute unless entity @e[tag=kitpvp.soul_tamer_token,distance=..8] at @e[type=minecraft:cat,name="驯兽师魂石",distance=..8,sort=nearest,limit=1] run function kitpvp:skill/soul/tamer_apply

execute at @s run kill @e[tag=kitpvp.soul_tamer_token]
execute at @s run kill @e[type=minecraft:cat,name="驯兽师魂石",distance=..8]
