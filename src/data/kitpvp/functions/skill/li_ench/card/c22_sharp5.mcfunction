# 锋锐：攻击力 +3（等价锋利 V），20 秒
scoreboard players set @s kitpvp.ench_tmp 400
scoreboard players set @s kitpvp.ench_tmp_kind 3
attribute @s minecraft:generic.attack_damage modifier remove 00000000-0000-0000-0000-0000000000a1
attribute @s minecraft:generic.attack_damage modifier add 00000000-0000-0000-0000-0000000000a1 kitpvp.li_sharp 3 add
tellraw @s [{"text":"★ 抽到：","color":"gold"},{"text":"锋锐","color":"gold","bold":true},{"text":"（锋利 +5 · 20 秒）","color":"gray"}]
playsound minecraft:block.anvil.land master @s ~ ~ ~ 0.9 1.1
