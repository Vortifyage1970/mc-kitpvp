# 利刃：攻击力 +2（等价锋利 III），12 秒
scoreboard players set @s kitpvp.ench_tmp 240
scoreboard players set @s kitpvp.ench_tmp_kind 3
attribute @s minecraft:generic.attack_damage modifier remove 00000000-0000-0000-0000-0000000000a1
attribute @s minecraft:generic.attack_damage modifier add 00000000-0000-0000-0000-0000000000a1 kitpvp.li_sharp 2 add
title @s actionbar [{"text":"◇ 抽到：","color":"aqua"},{"text":"利刃","color":"aqua","bold":true},{"text":"（锋利 +3 · 12 秒）","color":"gray"}]
playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.8 1.5
