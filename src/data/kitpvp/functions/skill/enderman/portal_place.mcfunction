# @s = 使用者；执行位置 = 射线命中的那一格内部
scoreboard players set #tep_hit kitpvp.game 1

# 同通道、同色的旧门：先响一声再拆（每个通道只允许一对）
execute if entity @s[tag=kitpvp.tep_kit] unless entity @s[tag=kitpvp.tep_col2] at @e[tag=kitpvp.tep_a,limit=1] run function kitpvp:skill/enderman/portal_puff
execute if entity @s[tag=kitpvp.tep_kit] unless entity @s[tag=kitpvp.tep_col2] run kill @e[tag=kitpvp.tep_a]
execute if entity @s[tag=kitpvp.tep_kit] if entity @s[tag=kitpvp.tep_col2] at @e[tag=kitpvp.tep_b,limit=1] run function kitpvp:skill/enderman/portal_puff
execute if entity @s[tag=kitpvp.tep_kit] if entity @s[tag=kitpvp.tep_col2] run kill @e[tag=kitpvp.tep_b]
execute unless entity @s[tag=kitpvp.tep_kit] unless entity @s[tag=kitpvp.tep_col2] at @e[tag=kitpvp.tep_r,limit=1] run function kitpvp:skill/enderman/portal_puff
execute unless entity @s[tag=kitpvp.tep_kit] unless entity @s[tag=kitpvp.tep_col2] run kill @e[tag=kitpvp.tep_r]
execute unless entity @s[tag=kitpvp.tep_kit] if entity @s[tag=kitpvp.tep_col2] at @e[tag=kitpvp.tep_p,limit=1] run function kitpvp:skill/enderman/portal_puff
execute unless entity @s[tag=kitpvp.tep_kit] if entity @s[tag=kitpvp.tep_col2] run kill @e[tag=kitpvp.tep_p]

# 门心离墙 1.0 格（一定落在两个空气采样点之间）
execute positioned ^ ^ ^-1.0 run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.tep_portal","kitpvp.tep_new"]}
execute if entity @s[tag=kitpvp.tep_kit] unless entity @s[tag=kitpvp.tep_col2] run tag @e[tag=kitpvp.tep_new] add kitpvp.tep_a
execute if entity @s[tag=kitpvp.tep_kit] if entity @s[tag=kitpvp.tep_col2] run tag @e[tag=kitpvp.tep_new] add kitpvp.tep_b
execute unless entity @s[tag=kitpvp.tep_kit] unless entity @s[tag=kitpvp.tep_col2] run tag @e[tag=kitpvp.tep_new] add kitpvp.tep_r
execute unless entity @s[tag=kitpvp.tep_kit] if entity @s[tag=kitpvp.tep_col2] run tag @e[tag=kitpvp.tep_new] add kitpvp.tep_p

# 门朝向 = 面的法线：墙 → 水平朝外；地面 → 竖直向上；天花板 → 竖直向下
data modify entity @e[tag=kitpvp.tep_new,limit=1,sort=nearest] Rotation set from entity @s Rotation
execute as @e[tag=kitpvp.tep_new] run tp @s ~ ~ ~ ~180 ~
execute store result score #tep_pitch kitpvp.game run data get entity @s Rotation[1] 1
execute if score #tep_pitch kitpvp.game matches -49..49 run data modify entity @e[tag=kitpvp.tep_new,limit=1,sort=nearest] Rotation[1] set value 0f
execute if score #tep_pitch kitpvp.game matches 50.. run data modify entity @e[tag=kitpvp.tep_new,limit=1,sort=nearest] Rotation[1] set value -90f
execute if score #tep_pitch kitpvp.game matches ..-50 run data modify entity @e[tag=kitpvp.tep_new,limit=1,sort=nearest] Rotation[1] set value 90f
scoreboard players set @e[tag=kitpvp.tep_new] kitpvp.tep_face 0
execute if score #tep_pitch kitpvp.game matches 50.. run scoreboard players set @e[tag=kitpvp.tep_new] kitpvp.tep_face 1
execute if score #tep_pitch kitpvp.game matches ..-50 run scoreboard players set @e[tag=kitpvp.tep_new] kitpvp.tep_face 2

scoreboard players set @e[tag=kitpvp.tep_new] kitpvp.tep_life 400
scoreboard players operation @e[tag=kitpvp.tep_new] kitpvp.tep_owner = @s kitpvp.tep_pid
tag @e[tag=kitpvp.tep_new] remove kitpvp.tep_new

# 冷却：里·末影人 2 秒 / 魂石 0.5 秒
execute if entity @s[tag=kitpvp.tep_kit] run scoreboard players set @s kitpvp.tep_cd 40
execute unless entity @s[tag=kitpvp.tep_kit] run scoreboard players set @s kitpvp.tep_cd_s 10

playsound minecraft:block.end_portal_frame.fill master @a[distance=..20] ~ ~ ~ 0.7 1.6
playsound minecraft:entity.enderman.teleport master @s ~ ~ ~ 0.5 1.2

# 状态灯：四种颜色各一条
execute if entity @s[tag=kitpvp.tep_kit] unless entity @s[tag=kitpvp.tep_col2] run bossbar set kitpvp:tep_hud_orange name {"text":"■ 橙门","color":"gold"}
execute if entity @s[tag=kitpvp.tep_kit] unless entity @s[tag=kitpvp.tep_col2] run bossbar set kitpvp:tep_hud_orange color yellow
execute if entity @s[tag=kitpvp.tep_kit] unless entity @s[tag=kitpvp.tep_col2] run bossbar set kitpvp:tep_hud_orange value 100
execute if entity @s[tag=kitpvp.tep_kit] if entity @s[tag=kitpvp.tep_col2] run bossbar set kitpvp:tep_hud_blue name {"text":"■ 蓝门","color":"aqua"}
execute if entity @s[tag=kitpvp.tep_kit] if entity @s[tag=kitpvp.tep_col2] run bossbar set kitpvp:tep_hud_blue color blue
execute if entity @s[tag=kitpvp.tep_kit] if entity @s[tag=kitpvp.tep_col2] run bossbar set kitpvp:tep_hud_blue value 100
execute unless entity @s[tag=kitpvp.tep_kit] unless entity @s[tag=kitpvp.tep_col2] run bossbar set kitpvp:tep_hud_red name {"text":"■ 红门","color":"red"}
execute unless entity @s[tag=kitpvp.tep_kit] unless entity @s[tag=kitpvp.tep_col2] run bossbar set kitpvp:tep_hud_red color red
execute unless entity @s[tag=kitpvp.tep_kit] unless entity @s[tag=kitpvp.tep_col2] run bossbar set kitpvp:tep_hud_red value 100
execute unless entity @s[tag=kitpvp.tep_kit] if entity @s[tag=kitpvp.tep_col2] run bossbar set kitpvp:tep_hud_purple name {"text":"■ 紫门","color":"light_purple"}
execute unless entity @s[tag=kitpvp.tep_kit] if entity @s[tag=kitpvp.tep_col2] run bossbar set kitpvp:tep_hud_purple color purple
execute unless entity @s[tag=kitpvp.tep_kit] if entity @s[tag=kitpvp.tep_col2] run bossbar set kitpvp:tep_hud_purple value 100
