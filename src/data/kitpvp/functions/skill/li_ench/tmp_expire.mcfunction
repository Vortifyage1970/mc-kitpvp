# 临时强化到点：利刃/锋锐是属性修饰符，得手动摘；抗性/回血是效果，自己会掉
execute if score @s kitpvp.ench_tmp_kind matches 3 run attribute @s minecraft:generic.attack_damage modifier remove 00000000-0000-0000-0000-0000000000a1
scoreboard players set @s kitpvp.ench_tmp 0
scoreboard players set @s kitpvp.ench_tmp_kind 0
title @s actionbar {"text":"临时强化已结束","color":"gray"}
