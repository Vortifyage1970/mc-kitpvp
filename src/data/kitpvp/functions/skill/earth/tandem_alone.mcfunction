# @s = 幸存的这一只：同伴没了 ⇒ 立刻清空身上所有效果，改为永久速度 II + 力量 I
# ★ 先 effect clear @s（不带效果名 = 清全部）：同伴刚死时它身上很可能还挂着缓慢 II 或速度 II，
#   不清就会和下面这两条叠在一起（缓慢 II + 速度 II ≈ 白给）
effect clear @s
effect give @s minecraft:speed infinite 1 true
effect give @s minecraft:strength infinite 0 true
playsound minecraft:entity.zombie.ambient master @a[distance=..16] ~ ~ ~ 1.0 0.6
tag @s add kitpvp.tandem_alone
