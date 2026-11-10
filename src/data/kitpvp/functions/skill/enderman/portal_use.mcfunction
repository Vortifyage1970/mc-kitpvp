# 传送枪：右键打橙门（tep_a），潜行右键打蓝门（tep_b）
# 冷却是"每扇门 1.5 秒"；全场只允许一对，开新的覆盖旧的
execute if score @s kitpvp.tep_cd matches 1.. run title @s actionbar {"text":"传送枪装填中…","color":"dark_purple"}
execute if score @s kitpvp.tep_used matches @s kitpvp.tep_last run scoreboard players set #tep_noop kitpvp.game 0
scoreboard players operation @s kitpvp.tep_last = @s kitpvp.tep_used
execute if score @s kitpvp.tep_cd matches ..0 run function kitpvp:skill/enderman/portal_ray
