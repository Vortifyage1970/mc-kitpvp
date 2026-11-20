# 1.20.1 拿不到"被击中的实体"：用命中瞬间 4 格内最近的实体近似（同 skill/mars/target）
# 先给自己打标，否则 distance 0 的自己永远是最近的那个
tag @s add kitpvp.cz_self
execute at @s run tag @e[distance=..4,type=!minecraft:item,type=!minecraft:arrow,type=!minecraft:experience_orb,type=!minecraft:area_effect_cloud,type=!minecraft:armor_stand,type=!minecraft:marker,type=!minecraft:item_frame,type=!minecraft:glow_item_frame,type=!minecraft:painting,type=!minecraft:leash_knot,tag=!kitpvp.cz_self,tag=!kitpvp.displayitem,sort=nearest,limit=1] add kitpvp.cz_target
# 随机一名"非自己"的参战玩家，把目标拽过去（场上没有别人就什么都不做）
execute at @r[tag=kitpvp.selected,scores={kitpvp.alive=1},tag=!kitpvp.spectator,tag=!kitpvp.cz_self] run tp @e[tag=kitpvp.cz_target,limit=1] ~ ~ ~
tag @e[tag=kitpvp.cz_target] remove kitpvp.cz_target
tag @s remove kitpvp.cz_self
