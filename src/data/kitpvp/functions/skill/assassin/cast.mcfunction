# 首行推进 assassin_last，漏写会无限连放；cd>0 时令牌已消耗但不放技能
scoreboard players operation @s kitpvp.assassin_last = @s kitpvp.assassin_used

execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/assassin/fire
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"隐匿冷却中","color":"gray"}
