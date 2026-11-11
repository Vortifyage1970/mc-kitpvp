# 地球·81 逃兵：半血触发一次 —— 直接借用原版"骷髅怕狼"：在它面前放一只**看不见的狼**，
# 骷髅那套硬编码的 AvoidEntityGoal<Wolf> 就会接管：背对着狼往反方向狂奔。
# ★ 数据包加不了 AI 目标，"怕狼"只能靠真的放一只狼在旁边——玩家看不到它（Invisible + Silent + NoAI）
tag @s add kitpvp.dser_flee
# 早期版本给它挂过 NoAI（脚本拖它跑），现在要靠原版寻路，先把 AI 还回去
data merge entity @s {NoAI:0b}
kill @e[tag=kitpvp.dser_wolf]
execute at @s run summon minecraft:wolf ~ ~ ~ {Tags:["kitpvp.dser_wolf"],Silent:1b,NoAI:1b,Invulnerable:1b,Invisible:1b,PersistenceRequired:1b}
playsound minecraft:entity.villager.hurt hostile @a[distance=..12] ~ ~ ~ 1.0 1.3
particle minecraft:poof ~ ~1 ~ 0.4 0.4 0.4 0.02 12 normal
