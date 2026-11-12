# 右键「混沌·重铸」蛋：冷却好了就重铸，没好只提示
# 两条触发路径都会走到这里：① tick 里的 used 统计快照  ② advancement（item_used_on_block + ChaosToken）
scoreboard players operation @s kitpvp.chaos_skill_last = @s kitpvp.chaos_skill_used
execute if score @s kitpvp.chaos_skill_cd matches 1.. run title @s actionbar {"text":"混沌·重铸：冷却中","color":"dark_gray"}
execute unless score @s kitpvp.chaos_skill_cd matches 1.. run function kitpvp:kit/chaos_skill_do
