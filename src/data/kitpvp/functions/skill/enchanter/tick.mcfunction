# 附魔师每刻：剑回到主手就摘掉等待标记，立刻把攒满的蓄力花掉；顺带把提示计时减一
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} run tag @s remove kitpvp.ench_wait
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} run function kitpvp:skill/enchanter/ench_check
execute if score @s kitpvp.ench_hint matches 1.. run scoreboard players remove @s kitpvp.ench_hint 1
# 坐杀博徒：冷却每刻 -1（只在对局里走）、领域里跑领域 tick、临时强化到点收掉
execute if score @s kitpvp.ench_domain_cd matches 1.. run scoreboard players remove @s kitpvp.ench_domain_cd 1
execute if entity @s[tag=kitpvp.ench_domain] run function kitpvp:skill/enchanter/domain_tick
execute if score @s kitpvp.ench_tmp matches 1.. run scoreboard players remove @s kitpvp.ench_tmp 1
execute if score @s kitpvp.ench_tmp matches ..0 if score @s kitpvp.ench_tmp_kind matches 1.. run function kitpvp:skill/enchanter/tmp_expire
# 赌徒之蛋：用掉一次就给下一次领域免冷却
execute if score @s kitpvp.ench_egg_used > @s kitpvp.ench_egg_last run function kitpvp:skill/enchanter/egg_cast
# 坐杀博徒·入场券：用掉一次就展开（同魂石的写法）
execute if score @s kitpvp.ench_domain_used > @s kitpvp.ench_domain_last run function kitpvp:skill/enchanter/domain_cast
