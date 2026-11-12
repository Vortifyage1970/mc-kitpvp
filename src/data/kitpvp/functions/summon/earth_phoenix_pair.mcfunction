# @s = 刚召出来的凤凰本体：发一个配对号，并召一个同号的隐形守卫
scoreboard players add #phx_seq kitpvp.game 1
scoreboard players operation @s kitpvp.phx_pair = #phx_seq kitpvp.game
execute at @s run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_phoenix_guard","kitpvp.phx_new"]}
# 新守卫用一次性 tag 认，避免同时有多只时改到别人的守卫
scoreboard players operation @e[tag=kitpvp.phx_new,limit=1,sort=nearest] kitpvp.phx_pair = @s kitpvp.phx_pair
scoreboard players set @e[tag=kitpvp.phx_new] kitpvp.phx_stage 0
tag @e[tag=kitpvp.phx_new] remove kitpvp.phx_new
