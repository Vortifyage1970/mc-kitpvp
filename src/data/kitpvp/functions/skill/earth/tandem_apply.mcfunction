# @s = 被标记的那只（离玩家最近）。位置锚在它身上
# ★ 交替：两个半身轮流拿速度 II —— 每判一次（2 秒）换一边，走起来是"一前一后交替领先"
#   先清掉两只身上的速度，再只给轮到的那一边，避免两边叠加成常驻加速
effect clear @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_alone] minecraft:speed
effect clear @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_alone] minecraft:slowness
scoreboard players add #td_alt kitpvp.game 1
execute if score #td_alt kitpvp.game matches 2.. run scoreboard players set #td_alt kitpvp.game 0
# 0 = 轮到 a 半身（底座），1 = 轮到 b 半身；速度给 3 秒，比 2 秒间隔多 1 秒，轮换时不会闪空
execute if score #td_alt kitpvp.game matches 0 run effect give @e[tag=kitpvp.earth_tandem_a,tag=!kitpvp.tandem_alone] minecraft:speed 3 1 true
execute if score #td_alt kitpvp.game matches 1 run effect give @e[tag=kitpvp.earth_tandem_b,tag=!kitpvp.tandem_alone] minecraft:speed 3 1 true
particle minecraft:end_rod ~ ~ ~ 0.2 0.1 0.2 0.02 6 normal
