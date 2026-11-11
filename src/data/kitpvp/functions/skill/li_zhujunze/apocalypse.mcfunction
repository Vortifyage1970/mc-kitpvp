# 安全阀：数量离谱时把这一批 iLsacuL 一次性炸掉
# ⚠ 只炸一轮：以前是"每刻炸剩下所有猪"，而 200 血的复制体一发半径 8 炸不死，
#    于是每刻每只都再刷一只苦力怕 —— 这就是"李朱俊泽数量爆炸"的来源（2026-11-11 复现）
scoreboard players set #licount kitpvp.game 0
execute as @e[tag=kitpvp.li_pig,tag=!kitpvp.soul_li_pig] run scoreboard players add #licount kitpvp.game 1
execute if score #licount kitpvp.game matches 1.. as @e[tag=kitpvp.li_pig,tag=!kitpvp.soul_li_pig] at @s run function kitpvp:skill/li_zhujunze/boom8
execute if score #licount kitpvp.game matches 1.. run kill @e[tag=kitpvp.li_pig,tag=!kitpvp.soul_li_pig]
execute if score #licount kitpvp.game matches 0 run scoreboard players set #liapoc kitpvp.game 0
