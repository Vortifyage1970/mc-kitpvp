# @s = 交警（闪现版）。24 格内有"跑得比 v 快"的活玩家，就瞬移到他的正前方 1.2 格（^ ^ ^1.2 = 那家伙的视线方向）
# ★ 阈值 v 写在这里的 900：分数是 (格/刻 x100)² 的和，所以 900 = 0.30 格/刻 ≈ 6 格/秒
#   原版：走路 0.216 → 467，疾跑 0.28 → 784，疾跑跳 0.35 → 1225，速度 I 疾跑 0.336 → 1129
#   于是"平地跑（784）不触发，疾跑跳 / 加速药水才触发"；想更松改 600（≈0.245），更严改 1200
# 坐在出场矿车里时不闪（tp 乘客会把人从车上扯下来），等车 10 秒自己消失后再开始截人
# 没找到目标也把冷却设回 100（2026-11-11：传送 5 秒一次），不会每刻刷选择器
execute at @p[distance=..24,scores={kitpvp.pspd=900..,kitpvp.alive=1}] unless entity @e[tag=kitpvp.earth_cop_cart,distance=..2] run tp @s ^ ^ ^1.2
execute at @p[distance=..24,scores={kitpvp.pspd=900..,kitpvp.alive=1}] unless entity @e[tag=kitpvp.earth_cop_cart,distance=..2] run playsound minecraft:entity.enderman.teleport master @a[distance=..16] ~ ~ ~ 0.8 1.4
scoreboard players set @s kitpvp.earth_cd_a 100