# @s = 深池飞行兵的蠹虫（载具）。乘客僵尸被骑着时导航算不出路径，自己永远挥不了刀，所以这里替它出手
# 主人过滤照抄变速器：先归零再 operation（魂石路径没有 earth_owner，源分缺失会让 operation 失败留旧值）
# 判定用"最近的那个玩家"：他如果不是主人就打，是主人就这一下不打（两个玩家时只判最近的那个）
# 手感：每 10 刻（0.5 秒）一下、5 点伤害（僵尸基础 3 + 避雷针锋利 V 的一部分）；by 点名乘客僵尸 ⇒ 有击退、有击杀归属
# ★ 要进随机池，summon 里的蠹虫还得带 kitpvp.earth_minion 与 kitpvp.earth_minion_new（link 才会给 earth_owner 赋值）
scoreboard players set #dl_owner kitpvp.game 0
scoreboard players operation #dl_owner kitpvp.game = @s kitpvp.earth_owner
scoreboard players set @s kitpvp.earth_cd_a 10
execute at @e[tag=kitpvp.earth_dublinn_zombie,distance=..2,sort=nearest,limit=1] as @p[distance=..2.5,sort=nearest] unless score @s kitpvp.etid = #dl_owner kitpvp.game run damage @s 5 minecraft:mob_attack by @e[tag=kitpvp.earth_dublinn_zombie,distance=..2,sort=nearest,limit=1]