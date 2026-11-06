# 位置 = 玩家脚下（aura 里 at @p 之后调进来）
# ★ 用"临时给最近那只打 tag"来分清远近：sort=nearest/furthest 在同一批里会互相打架，
#   而且一对里只有一只在半径内时两者会选中同一只（之前速度与缓慢互相抵消就是这个原因）
tag @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_alone,distance=..24] remove kitpvp.tandem_near
tag @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_alone,distance=..24,sort=nearest,limit=1] add kitpvp.tandem_near
# 近的那只：只给缓慢 II（先清速度，否则 +40% 与 -33% 抵消，看着像没效果）
effect clear @e[tag=kitpvp.earth_tandem,tag=kitpvp.tandem_near] minecraft:speed
effect give @e[tag=kitpvp.earth_tandem,tag=kitpvp.tandem_near] minecraft:slowness 2 1 true
# 另一只：只给速度 II
effect clear @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_alone,tag=!kitpvp.tandem_near,distance=..24] minecraft:slowness
effect give @e[tag=kitpvp.earth_tandem,tag=!kitpvp.tandem_alone,tag=!kitpvp.tandem_near,distance=..24] minecraft:speed 2 1 true
# 近的那只脚下冒一小团紫粒子：让人一眼看出游戏认为"谁更近"（排查期间保留，稳定后可删）
particle minecraft:end_rod ~ ~ ~ 0.2 0.1 0.2 0.02 6 normal
