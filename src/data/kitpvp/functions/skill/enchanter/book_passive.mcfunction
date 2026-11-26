# 只要主手是《神学大全》就走：不依赖对局状态，大厅里也生效
execute if data entity @s SelectedItem{id:"minecraft:book"} run function kitpvp:skill/enchanter/book_hold
