# 陷阱师的队伍维护（每 2 刻）：记下自己属于哪套队；本来没队就开 trap_<id> 并把自己放进去
# 队槽 37..42 = trap_1..6；陷阱虫靠 @s kitpvp.trap_team 归队
function kitpvp:util/team_index
scoreboard players set #trap_flag kitpvp.game 0
execute if score #steam kitpvp.game matches 0 run scoreboard players set #trap_flag kitpvp.game 1
execute if score #trap_flag kitpvp.game matches 1 run scoreboard players set #steam kitpvp.game 36
execute if score #trap_flag kitpvp.game matches 1 run scoreboard players operation #steam kitpvp.game += @s kitpvp.trap_id
scoreboard players operation @s kitpvp.trap_team = #steam kitpvp.game
execute if score #trap_flag kitpvp.game matches 1 if score @s kitpvp.trap_id matches 1 run team join trap_1 @s
execute if score #trap_flag kitpvp.game matches 1 if score @s kitpvp.trap_id matches 2 run team join trap_2 @s
execute if score #trap_flag kitpvp.game matches 1 if score @s kitpvp.trap_id matches 3 run team join trap_3 @s
execute if score #trap_flag kitpvp.game matches 1 if score @s kitpvp.trap_id matches 4 run team join trap_4 @s
execute if score #trap_flag kitpvp.game matches 1 if score @s kitpvp.trap_id matches 5 run team join trap_5 @s
execute if score #trap_flag kitpvp.game matches 1 if score @s kitpvp.trap_id matches 6 run team join trap_6 @s
