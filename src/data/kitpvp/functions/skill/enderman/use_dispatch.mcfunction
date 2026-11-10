# 一次"使用传送枪"事件：先推进快照（只推一次），再按身份分流
#   里·末影人（kit 33）→ 橙门 / 蓝门，冷却 2 秒
#   末影人魂石（tag soul_ep_active）→ 红门 / 紫门，冷却 0.5 秒
# 两个通道的门互相独立，不会串
scoreboard players operation @s kitpvp.tep_last = @s kitpvp.tep_used
execute if score @s kitpvp.kit matches 33 run function kitpvp:skill/enderman/kit_use
execute unless score @s kitpvp.kit matches 33 if entity @s[tag=kitpvp.soul_ep_active] run function kitpvp:skill/enderman/soul_use
