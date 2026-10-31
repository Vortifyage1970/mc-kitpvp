# 第 3 秒：每只 iLsacuL 原地生出一只 200 血的复制体
# 选择器在命令开始时只取当时存在的那些，新生成的复制体不会在同一刻继续套娃
# soul_li_pig（魂石那只抗性 V 的）不参与复制，否则它永远死不掉、复制体越滚越多
execute as @e[tag=kitpvp.li_pig,tag=!kitpvp.soul_li_pig] at @s run function kitpvp:summon/li_pig_copy
