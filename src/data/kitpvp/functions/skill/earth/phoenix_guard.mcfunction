# @s = 凤凰的守卫 marker（tick 每刻对每个守卫调用；守卫已经被贴到本体身上）
# 本体还在时把主人编号同步过来（link 是召唤后才写 earth_owner 的，只能每刻抄）
scoreboard players add @s kitpvp.earth_owner 0
execute if entity @e[tag=kitpvp.earth_phoenix,distance=..4] run scoreboard players add @e[tag=kitpvp.earth_phoenix,distance=..4,limit=1,sort=nearest] kitpvp.earth_owner 0
execute if entity @e[tag=kitpvp.earth_phoenix,distance=..4] run scoreboard players operation @s kitpvp.earth_owner = @e[tag=kitpvp.earth_phoenix,distance=..4,limit=1,sort=nearest] kitpvp.earth_owner
# 第一形态倒下 → 原地留蛋
execute if score @s kitpvp.phx_stage matches 0 unless entity @e[tag=kitpvp.earth_phoenix,distance=..4] run function kitpvp:skill/earth/phoenix_egg
# 蛋的倒计时（200 刻 = 10 秒）
execute if score @s kitpvp.phx_stage matches 1 run function kitpvp:skill/earth/phoenix_hatch
# 第二形态也倒下 → 守卫收工
execute if score @s kitpvp.phx_stage matches 2 unless entity @e[tag=kitpvp.earth_phoenix,distance=..4] run kill @s
