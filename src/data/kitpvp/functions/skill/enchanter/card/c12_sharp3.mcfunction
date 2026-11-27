# 利刃：攻击力 +2（等价锋利 III），10 秒
scoreboard players set @s kitpvp.ench_tmp 200
scoreboard players set @s kitpvp.ench_tmp_kind 3
attribute @s minecraft:generic.attack_damage modifier remove kitpvp:tmp_sharp
attribute @s minecraft:generic.attack_damage modifier add kitpvp:tmp_sharp kitpvp.tmp_sharp 2 operation add
title @s actionbar [{"text":"◇ 抽到：","color":"aqua"},{"text":"利刃","color":"aqua","bold":true},{"text":"（锋利 +3 · 10 秒）","color":"gray"}]
playsound minecraft:block.note_block.chime master @s ~ ~ ~ 0.8 1.5
