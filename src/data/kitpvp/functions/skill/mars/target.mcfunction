# 1.20.1 拿不到"被击中的实体"，用命中瞬间 3.2 格内最近的实体近似
# ⚠ @e 会包含攻击者本人（distance 0 永远最近）→ 先给自己打 tag 排除掉，否则会诅咒到自己
tag @s add kitpvp.mars_attacker
tag @e[tag=kitpvp.mars_wild,distance=..3.2] add kitpvp.mars_near
execute as @e[tag=kitpvp.mars_near,limit=1,sort=nearest] run function kitpvp:skill/mars/wild_hit
execute unless entity @e[tag=kitpvp.mars_near,limit=1] as @e[distance=..3.2,limit=1,sort=nearest,type=!minecraft:item,type=!minecraft:arrow,type=!minecraft:experience_orb,type=!minecraft:area_effect_cloud,type=!minecraft:armor_stand,tag=!kitpvp.mars_attacker] run function kitpvp:skill/mars/curse_hit
tag @e[tag=kitpvp.mars_near] remove kitpvp.mars_near
tag @s remove kitpvp.mars_attacker
