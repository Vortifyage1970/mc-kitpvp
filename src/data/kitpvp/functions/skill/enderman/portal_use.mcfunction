# 传送枪：右键打橙门（tep_a），潜行右键打蓝门（tep_b）
# 冷却是"每扇门 1.5 秒"；全场只允许一对，开新的覆盖旧的
# 注意：1.20.1 的 `matches` 不接受 `..0` 这种写法（会报"应为值的取值范围"导致整份函数加载失败），
#       所以这里统一用 `unless ... matches 1..` 表达"<= 0"
execute if score @s kitpvp.tep_cd matches 1.. run title @s actionbar {"text":"传送枪装填中…","color":"dark_purple"}
scoreboard players operation @s kitpvp.tep_last = @s kitpvp.tep_used
execute unless score @s kitpvp.tep_cd matches 1.. run title @s actionbar {"text":"传送枪：开火","color":"light_purple"}
execute unless score @s kitpvp.tep_cd matches 1.. run function kitpvp:skill/enderman/portal_ray
