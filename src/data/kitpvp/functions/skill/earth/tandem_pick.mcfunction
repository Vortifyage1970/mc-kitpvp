# 位置 = 玩家脚下（aura 里 at @p 之后调进来）
# ★ 粘住：当前被标记的那只只要还在 5 格内就不换人 —— 两只并排时每秒重挑会导致"轮流减速"，看着像两只都在减
execute unless entity @e[tag=kitpvp.earth_tandem,tag=kitpvp.tandem_near,distance=..5] run tag @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_alone,distance=..24] remove kitpvp.tandem_near
execute unless entity @e[tag=kitpvp.earth_tandem,tag=kitpvp.tandem_near] run tag @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_alone,distance=..24,sort=nearest,limit=1] add kitpvp.tandem_near
execute as @e[tag=kitpvp.earth_tandem,tag=kitpvp.tandem_near,limit=1] at @s run function kitpvp:skill/earth/tandem_apply
