# 首行推进 assassin_last，漏写会无限连放；cd>0 时令牌已消耗但不放技能
scoreboard players operation @s kitpvp.assassin_last = @s kitpvp.assassin_used

execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/assassin/fire
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"隐匿冷却中","color":"gray"}

# 打开"令牌发回"窗口（同 tank/cast）：快照推进 = 令牌真的被用掉了，冷却走完由 tick 一次性发回
tag @s add kitpvp.assassin_handout
