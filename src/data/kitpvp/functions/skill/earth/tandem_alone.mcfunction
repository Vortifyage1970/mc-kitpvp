# @s = 幸存的这一只：同伴没了 ⇒ 立刻清空身上所有效果，改为永久速度 II + 力量 I + 发光
effect clear @s
effect give @s minecraft:speed infinite 1 true
effect give @s minecraft:strength infinite 0 true
effect give @s minecraft:glowing infinite 0 true
playsound minecraft:entity.zombie.ambient master @a[distance=..16] ~ ~ ~ 1.0 0.6
tag @s add kitpvp.tandem_alone
