# 剑附魔：只在金剑位于主手时掷（搬动背包会把东西弄丢，这条路径不碰任何格子）
execute if data entity @s SelectedItem{id:"minecraft:golden_sword"} run function kitpvp:skill/enchanter/sw_roll
