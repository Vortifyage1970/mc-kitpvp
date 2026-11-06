# @s = 金星（狐狸）：给 7 格内"不是召唤者"的玩家打上冷气标记
# 有标记 +1、没标记 -1 —— 这两句在 tick 里统一跑（和舔狗制冷模块共用同一套 coldness）
# 归属先归零再 operation：魂石路径/手动召出来的没有 earth_owner，源分缺失会留上一只的旧值
scoreboard players set #venus_owner kitpvp.game 0
scoreboard players operation #venus_owner kitpvp.game = @s kitpvp.earth_owner
# 无主（earth_owner 为空 = 0 且没人持有 etid 0）：谁都冷，免得"手动召的狐狸冻不住人"
execute if score #venus_owner kitpvp.game matches ..0 as @a[distance=..7,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run tag @s add kitpvp.venus_chilled
# 有主：只有不属于这一只的玩家才吃（召唤者自己免疫）
execute if score #venus_owner kitpvp.game matches 1.. as @a[distance=..7,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #venus_owner kitpvp.game run tag @s add kitpvp.venus_chilled
