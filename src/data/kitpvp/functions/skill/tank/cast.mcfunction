# 首行推进 tank_last，漏写会无限连放；cd>0 时令牌已消耗但不放技能（设计接受的惩罚）
scoreboard players operation @s kitpvp.tank_last = @s kitpvp.tank_used

execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/tank/fire
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"举盾冷却中","color":"gray"}

# 开"令牌发回"窗口：快照推进 = 令牌真的被用掉（04 §四：不用"背包里没有就补"）
tag @s add kitpvp.tank_handout
