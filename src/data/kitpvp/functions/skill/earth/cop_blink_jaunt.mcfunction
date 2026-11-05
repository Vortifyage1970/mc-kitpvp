# @s = 交警。24 格内有"跑得比 v 快"的活玩家，就瞬移到他的正前方 1.2 格（^ ^ ^1.2 = 那家伙的视线方向）
# ★ v 就是这个 25：0.25 格/刻 ≈ 5 格/秒。原版走路约 21、疾跑约 28、疾跑跳 30+，所以"只要跑起来就被截"；想更松改 20（走路也会被抓），更严改 35（要疾跑跳）
# 坐在出场矿车里时不闪（tp 乘客会把人从车上扯下来），等车 10 秒自己消失后再开始截人
# 没找到目标也把冷却设回 20，等于每秒扫一次玩家，不会每刻刷选择器
execute at @p[distance=..24,scores={kitpvp.pspd=25..,kitpvp.alive=1}] unless entity @e[tag=kitpvp.earth_cop_cart,distance=..2] run tp @s ^ ^ ^1.2
execute at @p[distance=..24,scores={kitpvp.pspd=25..,kitpvp.alive=1}] unless entity @e[tag=kitpvp.earth_cop_cart,distance=..2] run playsound minecraft:entity.enderman.teleport master @a[distance=..16] ~ ~ ~ 0.8 1.4
scoreboard players set @s kitpvp.earth_cd_a 20