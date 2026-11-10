# 末影人魂石的红/紫门：冷却 0.2 秒（4 刻）
tag @s add kitpvp.tep_soul
execute if score @s kitpvp.tep_cd_s matches 1.. run title @s actionbar {"text":"魂石门装填中…","color":"red"}
execute unless score @s kitpvp.tep_cd_s matches 1.. run function kitpvp:skill/enderman/portal_ray
tag @s remove kitpvp.tep_soul
