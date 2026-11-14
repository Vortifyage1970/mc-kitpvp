# 装填状态消失 = 射出一发：手上还是混沌弩才扣一次
scoreboard players set @s kitpvp.chaos_xbow_charge 0
execute if data entity @s SelectedItem.tag.ChaosXbow run function kitpvp:kit/chaos_use
particle minecraft:smoke ~ ~1 ~ 0.2 0.2 0.2 0.02 6 normal
