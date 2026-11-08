# 鹦鹉没了：外壳不再当场倒地，只是失了抗性（变回 20 血的隐形尸壳，还能继续砍人）
# 这样"点名打鹦鹉"不会一碰就整只消失，还要补刀把它打死
particle minecraft:poof ~ ~1 ~ 0.4 0.5 0.4 0.02 20 force
playsound minecraft:entity.husk.hurt master @a ~ ~ ~ 1.0 0.8
effect clear @s minecraft:resistance
tag @s add kitpvp.pl_shorn
title @a[tag=!kitpvp.spectator] actionbar {"text":"冥王星的外壳失去了抗性","color":"dark_blue"}
