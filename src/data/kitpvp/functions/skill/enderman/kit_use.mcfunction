# 里·末影人的橙/蓝门：冷却 2 秒（40 刻）
tag @s add kitpvp.tep_kit
execute if score @s kitpvp.tep_cd matches 1.. run title @s actionbar {"text":"传送枪装填中…","color":"dark_purple"}
execute unless score @s kitpvp.tep_cd matches 1.. run function kitpvp:skill/enderman/portal_ray
tag @s remove kitpvp.tep_kit
