# @s = 玩家：把这一刻的位移换算成"速度分"（格/刻 x100，x 与 z 位移绝对值相加）
# 分数统一在 load 里建好；首帧 px_old/pz_old 还不存在，先 add 0 兜底，否则 operation 会因源分缺失整条失败
scoreboard players add @s kitpvp.px_old 0
scoreboard players add @s kitpvp.pz_old 0
execute store result score @s kitpvp.px run data get entity @s Pos[0] 100
execute store result score @s kitpvp.pz run data get entity @s Pos[2] 100
scoreboard players operation @s kitpvp.pdx = @s kitpvp.px
scoreboard players operation @s kitpvp.pdx -= @s kitpvp.px_old
scoreboard players operation @s kitpvp.pdz = @s kitpvp.pz
scoreboard players operation @s kitpvp.pdz -= @s kitpvp.pz_old
# 取绝对值：scoreboard 没有 abs，负数乘 -1（#neg 在 load 里设为 -1）
execute if score @s kitpvp.pdx matches ..-1 run scoreboard players operation @s kitpvp.pdx *= #neg kitpvp.game
execute if score @s kitpvp.pdz matches ..-1 run scoreboard players operation @s kitpvp.pdz *= #neg kitpvp.game
scoreboard players operation @s kitpvp.pspd = @s kitpvp.pdx
scoreboard players operation @s kitpvp.pspd += @s kitpvp.pdz
scoreboard players operation @s kitpvp.px_old = @s kitpvp.px
scoreboard players operation @s kitpvp.pz_old = @s kitpvp.pz