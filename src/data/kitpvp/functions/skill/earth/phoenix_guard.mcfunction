# @s = 凤凰的守卫 marker（tick 每刻对每个守卫调用）
# 只认自己那一号：配对号相同的本体/蛋才会被当成"自己的"
scoreboard players operation #phx_pair kitpvp.game = @s kitpvp.phx_pair
tag @e[tag=kitpvp.earth_phoenix] remove kitpvp.phx_tmp
execute as @e[tag=kitpvp.earth_phoenix] if score @s kitpvp.phx_pair = #phx_pair kitpvp.game run tag @s add kitpvp.phx_tmp
# 贴着本体走；本体没了就停在最后位置（那里就是蛋的位置）
execute at @e[tag=kitpvp.phx_tmp,limit=1,sort=nearest] run tp @s ~ ~ ~
# 主人编号（link 是召唤后才写的，只能每刻抄）
scoreboard players add @s kitpvp.earth_owner 0
execute if entity @e[tag=kitpvp.phx_tmp,distance=..4] run scoreboard players add @e[tag=kitpvp.phx_tmp,distance=..4,limit=1,sort=nearest] kitpvp.earth_owner 0
execute if entity @e[tag=kitpvp.phx_tmp,distance=..4] run scoreboard players operation @s kitpvp.earth_owner = @e[tag=kitpvp.phx_tmp,distance=..4,limit=1,sort=nearest] kitpvp.earth_owner
# 第一形态倒下 → 原地留蛋
execute if score @s kitpvp.phx_stage matches 0 unless entity @e[tag=kitpvp.phx_tmp,distance=..4] run function kitpvp:skill/earth/phoenix_egg
# 蛋孵化倒计时
execute if score @s kitpvp.phx_stage matches 1 run function kitpvp:skill/earth/phoenix_hatch
# 第二形态也倒下 → 守卫收工
execute if score @s kitpvp.phx_stage matches 2 unless entity @e[tag=kitpvp.phx_tmp,distance=..4] run kill @s
tag @e[tag=kitpvp.earth_phoenix] remove kitpvp.phx_tmp
