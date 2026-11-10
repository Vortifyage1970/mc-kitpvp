# @s = 玩家；执行位置 = 出口门
# 视角跟着门转（以前那版的手感保留）：先认出门的类型，再按类型摆好脚的位置、并把朝向设为门的朝向
scoreboard players set #tep_face kitpvp.game 0
execute if score @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 1 run scoreboard players set #tep_face kitpvp.game 1
execute if score @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 1 run scoreboard players set #tep_face kitpvp.game 1
execute if score @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 2 run scoreboard players set #tep_face kitpvp.game 2
execute if score @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 2 run scoreboard players set #tep_face kitpvp.game 2

# 站到门口：墙门脚在门心下方 1.55 格；地面门 0.9；天花板门 2.0。朝向 = 门的朝向（视角跟门走）
execute if score #tep_face kitpvp.game matches 0 rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-1.55 ~ ~ ~
execute if score #tep_face kitpvp.game matches 0 rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-1.55 ~ ~ ~
execute if score #tep_face kitpvp.game matches 1 rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-0.9 ~ ~ ~
execute if score #tep_face kitpvp.game matches 1 rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-0.9 ~ ~ ~
execute if score #tep_face kitpvp.game matches 2 rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-2.0 ~ ~ ~
execute if score #tep_face kitpvp.game matches 2 rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-2.0 ~ ~ ~

# 沿门面外侧再探 0.35 格：门本身离墙 1.0 格，这一步保证身体完全在墙外
execute rotated as @e[tag=kitpvp.tep_a,distance=..1,limit=1,sort=nearest] run tp @s ^ ^ ^0.35
execute rotated as @e[tag=kitpvp.tep_b,distance=..1,limit=1,sort=nearest] run tp @s ^ ^ ^0.35

# 出门不摔伤 + 3 秒内不能再穿（防止两扇门互相弹，也给别人反应时间）
data merge entity @s {FallDistance:0f}
scoreboard players set @s kitpvp.tep_ready 60
particle minecraft:dragon_breath ~ ~0.9 ~ 0.4 0.5 0.4 0.05 14 normal
playsound minecraft:entity.enderman.teleport master @a[distance=..16] ~ ~ ~ 0.8 1.1
