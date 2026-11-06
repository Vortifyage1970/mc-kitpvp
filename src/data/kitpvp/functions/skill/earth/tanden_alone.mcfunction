# @s = 幸存的这一只：同伴没了 ⇒ 永久速度 II + 力量 I，并打标签防止重复播
effect give @s minecraft:speed infinite 1 true
effect give @s minecraft:strength infinite 0 true
playsound minecraft:entity.zombie.ambient master @a[distance=..16] ~ ~ ~ 1.0 0.6
tag @s add kitpvp.tanden_alone
