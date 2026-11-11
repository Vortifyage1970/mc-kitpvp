# debug 模式（#debug=1）专用单人开局；不传送，玩家留在原位（要回大厅用 lobby/enter）
execute if score #debug kitpvp.game matches 0 run title @s times 5 40 10
execute if score #debug kitpvp.game matches 0 run title @s title {"text":"请先开启 debug 模式","color":"red","bold":true}
execute if score #debug kitpvp.game matches 0 run tellraw @s [{"text":"[debug] 先执行 /function kitpvp:debug/on","color":"red"}]

execute if score #debug kitpvp.game matches 1 as @s run tag @s add kitpvp.selected

execute if score #debug kitpvp.game matches 1 as @s run tag @s remove kitpvp.spectator
execute if score #debug kitpvp.game matches 1 as @s run gamemode survival @s

execute if score #debug kitpvp.game matches 1 as @s run scoreboard players set @s kitpvp.lives 3
execute if score #debug kitpvp.game matches 1 as @s run scoreboard players set @s kitpvp.alive 1

execute if score #debug kitpvp.game matches 1 as @s run function kitpvp:lobby/exit

execute if score #debug kitpvp.game matches 1 run scoreboard players set #state kitpvp.game 1

execute if score #debug kitpvp.game matches 1 as @s run function kitpvp:player/invincible

execute if score #debug kitpvp.game matches 1 run title @a times 5 30 10
execute if score #debug kitpvp.game matches 1 run title @a title {"text":"[debug] 开局","color":"light_purple","bold":true}
execute if score #debug kitpvp.game matches 1 run title @a subtitle {"text":"记得先选职业","color":"gray"}

execute if score #debug kitpvp.game matches 1 run function kitpvp:game/start_impl
