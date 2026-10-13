# 开局入口：只做人数检查（1.20.1 无 return，用 execute if 控制流程）
scoreboard players set #join_count kitpvp.game 0
execute as @a[tag=kitpvp.selected,tag=!kitpvp.spectator] run scoreboard players add #join_count kitpvp.game 1

execute if score #join_count kitpvp.game matches ..1 run tellraw @a [{"text":"[!] ","color":"red","bold":true},{"text":"需要至少 2 名已选职业的玩家才能开始","color":"red"}]

execute if score #join_count kitpvp.game matches 2.. run function kitpvp:game/start_impl
