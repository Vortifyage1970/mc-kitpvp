# @s = 迫击炮：挑一个 20 格内的目标挂上 kitpvp.mo_tgt，然后打一发
# 归属先归零再 operation：魂石链路/手动召的没有 earth_owner，源分缺失会留上一只的旧值
scoreboard players set #mo_owner kitpvp.game 0
scoreboard players operation #mo_owner kitpvp.game = @s kitpvp.earth_owner

# 只打"不是主人"的活人：创造、旁观、观战 tag 全部排除；一个都没有就不开火
tag @a remove kitpvp.mo_tgt
execute if score #mo_owner kitpvp.game matches 1.. as @a[distance=..20,gamemode=!spectator,gamemode=!creative,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #mo_owner kitpvp.game run tag @s add kitpvp.mo_tgt

execute if entity @a[tag=kitpvp.mo_tgt,limit=1] at @s run function kitpvp:skill/earth/mortar_fire
