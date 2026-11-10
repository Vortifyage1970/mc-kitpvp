# @s = 使用者；执行位置 = 射线命中的那一格内部
scoreboard players set #tep_hit kitpvp.game 1

# 同色的旧门先响一声再拆（全场只允许一对）
execute if score #tep_blue kitpvp.game matches 1 run function kitpvp:skill/enderman/portal_puff_b
execute if score #tep_blue kitpvp.game matches 0 run function kitpvp:skill/enderman/portal_puff_a
execute if score #tep_blue kitpvp.game matches 1 run kill @e[tag=kitpvp.tep_b]
execute if score #tep_blue kitpvp.game matches 0 run kill @e[tag=kitpvp.tep_a]

# 从命中格沿视线回退 1.0 格：门一定在两个空气采样点之间，出来不会卡墙
execute positioned ^ ^ ^-1.0 run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.tep_new"]}
execute if score #tep_blue kitpvp.game matches 1 run tag @e[tag=kitpvp.tep_new] add kitpvp.tep_b
execute if score #tep_blue kitpvp.game matches 0 run tag @e[tag=kitpvp.tep_new] add kitpvp.tep_a
# 门朝向 = 使用者视线的反方向（开枪时是朝着墙看的，出门要朝外）
data modify entity @e[tag=kitpvp.tep_new,limit=1,sort=nearest] Rotation set from entity @s Rotation
execute as @e[tag=kitpvp.tep_new] run tp @s ~ ~ ~ ~180 ~
scoreboard players set @e[tag=kitpvp.tep_new] kitpvp.tep_life 400
scoreboard players operation @e[tag=kitpvp.tep_new] kitpvp.tep_owner = @s kitpvp.tep_pid
tag @e[tag=kitpvp.tep_new] remove kitpvp.tep_new

scoreboard players set @s kitpvp.tep_cd 30
playsound minecraft:block.end_portal_frame.fill master @a[distance=..20] ~ ~ ~ 0.7 1.6
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 0.5 1.2
# 状态灯：对应颜色的门亮起来（名字变实心方块 + 有色 + 满条）
execute if score #tep_blue kitpvp.game matches 1 run bossbar set kitpvp:tep_hud_blue name {"text":"■ 蓝门","color":"aqua"}
execute if score #tep_blue kitpvp.game matches 1 run bossbar set kitpvp:tep_hud_blue color blue
execute if score #tep_blue kitpvp.game matches 1 run bossbar set kitpvp:tep_hud_blue value 1
execute if score #tep_blue kitpvp.game matches 0 run bossbar set kitpvp:tep_hud_orange name {"text":"■ 橙门","color":"gold"}
execute if score #tep_blue kitpvp.game matches 0 run bossbar set kitpvp:tep_hud_orange color yellow
execute if score #tep_blue kitpvp.game matches 0 run bossbar set kitpvp:tep_hud_orange value 1
