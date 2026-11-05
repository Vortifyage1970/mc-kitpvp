# @s = 交警。24 格内有"跑得比 v 快"的活玩家，就瞬移到他的正前方 1.2 格（^ ^ ^1.2 = 那家伙的视线方向）
# ★ v 就是这个 35：0.35 格/刻 ≈ 7 格/秒，疾跑跳跃刚好触发；想更灵敏改 25，想只在加速药水时触发改 50
# 没找到目标也把冷却设回 20，等于每秒扫一次玩家，不会每刻刷选择器
execute at @p[distance=..24,scores={kitpvp.pspd=35..,kitpvp.alive=1}] run tp @s ^ ^ ^1.2
execute at @p[distance=..24,scores={kitpvp.pspd=35..,kitpvp.alive=1}] run playsound minecraft:entity.enderman.teleport master @a[distance=..16] ~ ~ ~ 0.8 1.4
scoreboard players set @s kitpvp.earth_cd_a 20