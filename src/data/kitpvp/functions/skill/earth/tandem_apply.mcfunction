# 串联体：两个半身轮流拿速度 II（每 3 秒换一边），与玩家位置无关
# 先清掉两边的速度再只给轮到的那只，避免叠加成常驻加速；效果给 3 秒，和 3 秒的判定间隔对齐（换边那一帧由新值顶上，肉眼看不到空档）
effect clear @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_alone] minecraft:speed
scoreboard players add #td_alt kitpvp.game 1
execute if score #td_alt kitpvp.game matches 2.. run scoreboard players set #td_alt kitpvp.game 0
# 0 = a 半身（底座）、1 = b 半身
execute if score #td_alt kitpvp.game matches 0 run effect give @e[tag=kitpvp.earth_tandem_a,tag=!kitpvp.tandem_alone] minecraft:speed 3 1 true
execute if score #td_alt kitpvp.game matches 1 run effect give @e[tag=kitpvp.earth_tandem_b,tag=!kitpvp.tandem_alone] minecraft:speed 3 1 true
