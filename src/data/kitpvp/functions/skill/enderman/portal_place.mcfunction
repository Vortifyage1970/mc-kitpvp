# @s = 使用者；执行位置 = 射线命中的那一格内部
# 只认第一次命中（#tep_hit 由 portal_ray 归零，这里置 1）
scoreboard players set #tep_hit kitpvp.game 1

# 同色的旧门先拆掉（全场只允许一对）
execute if score #tep_blue kitpvp.game matches 1 run kill @e[tag=kitpvp.tep_b]
execute if score #tep_blue kitpvp.game matches 0 run kill @e[tag=kitpvp.tep_a]

# 从命中格沿视线回退 0.6 格，把门贴在方块外侧
execute positioned ^ ^ ^-0.6 run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.tep_new"]}
execute if score #tep_blue kitpvp.game matches 1 run tag @e[tag=kitpvp.tep_new] add kitpvp.tep_b
execute if score #tep_blue kitpvp.game matches 0 run tag @e[tag=kitpvp.tep_new] add kitpvp.tep_a
# 门朝向 = 使用者当时的视线（也就是从门里"往外"的方向）
data modify entity @e[tag=kitpvp.tep_new,limit=1,sort=nearest] Rotation set from entity @s Rotation
scoreboard players set @e[tag=kitpvp.tep_new] kitpvp.tep_life 400
tag @e[tag=kitpvp.tep_new] remove kitpvp.tep_new

scoreboard players set @s kitpvp.tep_cd 30
playsound minecraft:block.end_portal_frame.fill master @a[distance=..20] ~ ~ ~ 0.7 1.6
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 0.5 1.2
execute if score #tep_blue kitpvp.game matches 1 run title @s actionbar {"text":"蓝门已架好","color":"aqua"}
execute if score #tep_blue kitpvp.game matches 0 run title @s actionbar {"text":"橙门已架好","color":"gold"}
