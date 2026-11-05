# @s = 深池飞行兵的蠹虫（载具）。乘客僵尸被骑着时导航算不出路径，自己永远挥不了刀，所以这里替它出手
# by 后面点名乘客僵尸：伤害记在它头上（有击退、有击杀归属），不是"凭空掉血"
# 手感：每 10 刻（0.5 秒）一下、5 点伤害（僵尸基础 3 点 + 避雷针锋利 V 的一部分）；两个数都能直接改
# ★ 进了随机池之后要加主人过滤（照抄变速器的 earth_owner 判定），否则连召唤者一起打
scoreboard players set @s kitpvp.earth_cd_a 10
execute at @s run damage @p[distance=..2.5,sort=nearest] 5 minecraft:mob_attack by @e[tag=kitpvp.earth_dublinn_zombie,distance=..2,sort=nearest,limit=1]