# 首行推进 assassin_last，漏写会无限连放；cd>0 时令牌已消耗但不放技能
scoreboard players operation @s kitpvp.assassin_last = @s kitpvp.assassin_used

execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/assassin/fire
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"隐匿冷却中","color":"gray"}

# 开"令牌发回"窗口（同 tank/cast）
tag @s add kitpvp.assassin_handout

# 载体一律当场收掉：**不能放在 tick/kits_a 里每刻清**——那会跑在 slow2 的 dispatch 之前，
# 变成"先清后判"，技能永远不触发、handout 窗口也永远不开（2026-11-26 实机 bug）
execute at @s run kill @e[tag=kitpvp.assassin_token,distance=..8]
