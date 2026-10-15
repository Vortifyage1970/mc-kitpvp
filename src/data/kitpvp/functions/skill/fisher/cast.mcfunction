# 首行推进 fisher_last，漏写会无限连放；cd>0 时令牌已消耗但不放技能（设计接受的惩罚）
scoreboard players operation @s kitpvp.fisher_last = @s kitpvp.fisher_used

execute if score @s kitpvp.cd matches ..0 run function kitpvp:skill/fisher/fire
execute if score @s kitpvp.cd matches 1.. run title @s actionbar {"text":"寻戟冷却中","color":"gray"}

# 打开"令牌发回"窗口（同 tank/cast）：快照推进 = 令牌真的被用掉了。
# 这一行同时兜住"三叉戟尚未离场"那类白按：没进冷却也照样把令牌发回来（见 04 §四）
tag @s add kitpvp.fisher_handout
