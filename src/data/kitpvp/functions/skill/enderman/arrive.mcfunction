# @s = 玩家；执行位置 = 出口门
scoreboard players set #tep_face kitpvp.game 0
execute if score @e[tag=kitpvp.tep_portal,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 1 run scoreboard players set #tep_face kitpvp.game 1
execute if score @e[tag=kitpvp.tep_portal,distance=..1,limit=1,sort=nearest] kitpvp.tep_face matches 2 run scoreboard players set #tep_face kitpvp.game 2

# 站到门口：墙门脚在门心下方 1.55、地面门 0.9、天花板门 2.0；朝向 = 门的朝向（视角跟门走）
execute if score #tep_face kitpvp.game matches 0 rotated as @e[tag=kitpvp.tep_portal,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-1.55 ~ ~ ~
execute if score #tep_face kitpvp.game matches 1 rotated as @e[tag=kitpvp.tep_portal,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-0.9 ~ ~ ~
execute if score #tep_face kitpvp.game matches 2 rotated as @e[tag=kitpvp.tep_portal,distance=..1,limit=1,sort=nearest] run tp @s ~ ~-2.0 ~ ~ ~
# 再沿门面外侧探 0.35 格：门离墙 1.0 格，这一步保证身体完全在墙外
execute rotated as @e[tag=kitpvp.tep_portal,distance=..1,limit=1,sort=nearest] run tp @s ^ ^ ^0.35

data merge entity @s {FallDistance:0f}
scoreboard players set @s kitpvp.tep_ready 60
tag @s add kitpvp.tep_locked
particle minecraft:dragon_breath ~ ~0.9 ~ 0.4 0.5 0.4 0.05 14 normal
playsound minecraft:entity.enderman.teleport master @a[distance=..16] ~ ~ ~ 0.8 1.1
