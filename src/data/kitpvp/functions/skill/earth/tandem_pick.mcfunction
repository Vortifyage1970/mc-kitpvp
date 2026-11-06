# 位置 = 玩家脚下（aura 里 at @p 之后调进来）
# 职责：只给"离玩家最近的那只"打临时 tag，真正的效果分配交给 tandem_apply（那里要量两只之间的距离）
tag @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_alone,distance=..24] remove kitpvp.tandem_near
tag @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_alone,distance=..24,sort=nearest,limit=1] add kitpvp.tandem_near
execute as @e[tag=kitpvp.earth_tandem,tag=kitpvp.tandem_near,limit=1] at @s run function kitpvp:skill/earth/tandem_apply
