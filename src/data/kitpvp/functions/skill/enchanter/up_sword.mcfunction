# 剑升一级：先确认金剑在主手，否则把蓄力留着、等剑回到手上再升
execute unless data entity @s SelectedItem{id:"minecraft:golden_sword"} run function kitpvp:skill/enchanter/sw_wait
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} run function kitpvp:skill/enchanter/sw_up
