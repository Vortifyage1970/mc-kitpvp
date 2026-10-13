# 死亡入口。大厅内死亡不计（判据 tag=kitpvp.in_lobby）：不计数、不扣命、不淘汰
execute unless entity @s[tag=kitpvp.in_lobby] run scoreboard players add @s kitpvp.deaths 1

execute unless entity @s[tag=kitpvp.in_lobby] run tag @s add kitpvp.respawn_pending

execute unless entity @s[tag=kitpvp.in_lobby] unless entity @s[tag=kitpvp.death_immune] run scoreboard players remove @s kitpvp.lives 1

# alive=1 守卫：防止旁观者被 /kill 时重复淘汰
execute unless entity @s[tag=kitpvp.in_lobby] if score @s kitpvp.lives matches ..0 if score @s kitpvp.alive matches 1 run function kitpvp:player/eliminate

execute if entity @s[tag=kitpvp.in_lobby] run function kitpvp:lobby/enter
