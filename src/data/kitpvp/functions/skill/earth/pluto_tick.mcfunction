# 冥王星（80）的共生与站位（由 tick 以「as 僵尸 at 僵尸」调用）
# 1) 按配对号找鹦鹉：找得到就清零缺失计时，找不到就 +1，缺满 6 刻才判死
#    （宽限是照抄「冥王星」职业的 check：跨区块/刚落地的几刻 @e 也选不到，立刻判死会白死）
# 2) 把同号的那只鹦鹉钉到僵尸头顶 ~ ~2 ~（NoAI，不做任何跟随 AI）
scoreboard players operation #pl_pair kitpvp.game = @s kitpvp.pluto_pair
scoreboard players set #pl_alive kitpvp.game 0
execute as @e[tag=kitpvp.earth_pluto_parrot] if score @s kitpvp.pluto_pair = #pl_pair kitpvp.game run scoreboard players set #pl_alive kitpvp.game 1
execute if score #pl_alive kitpvp.game matches 1 run scoreboard players set @s kitpvp.pluto_miss 0
execute if score #pl_alive kitpvp.game matches 0 run scoreboard players add @s kitpvp.pluto_miss 1
execute if score @s kitpvp.pluto_miss matches 6.. run function kitpvp:skill/earth/pluto_die
execute as @e[tag=kitpvp.earth_pluto_parrot] if score @s kitpvp.pluto_pair = #pl_pair kitpvp.game run tag @s add kitpvp.pl_pair_tmp
execute at @s as @e[tag=kitpvp.pl_pair_tmp] run tp @s ~ ~2 ~
tag @e[tag=kitpvp.pl_pair_tmp] remove kitpvp.pl_pair_tmp
