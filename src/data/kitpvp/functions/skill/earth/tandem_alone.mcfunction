# @s = 幸存的这一只：同伴没了 ⇒ 立刻清空身上所有效果，改为永久速度 II + 力量 I + 发光
# playsound 必须带 at @s：这个函数是从 tick 里 as @e 调过来的，没有位置上下文时 ~ ~ ~ 会落到
# 命令源（世界出生点）去，声音在几十格之外 ⇒ 玩家什么都听不到
effect clear @s
effect give @s minecraft:speed infinite 1 true
effect give @s minecraft:strength infinite 0 true
effect give @s minecraft:glowing infinite 0 true
execute at @s run playsound minecraft:entity.warden.ambient master @a[distance=..16] ~ ~ ~ 1.0 0.55
tag @s add kitpvp.tandem_alone
