# 右键「混沌·重铸」令牌：冷却好了就重铸，没好只提示
scoreboard players operation @s kitpvp.chaos_skill_last = @s kitpvp.chaos_skill_used
execute if score @s kitpvp.chaos_skill_cd matches 1.. run title @s actionbar {"text":"混沌·重铸冷却中","color":"dark_gray"}
execute if score @s kitpvp.chaos_skill_cd matches ..0 run function kitpvp:kit/chaos_skill_do
