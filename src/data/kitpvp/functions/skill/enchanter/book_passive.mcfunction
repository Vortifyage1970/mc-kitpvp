# 只要主手是《神学大全》就走：不依赖对局状态，大厅里也生效
execute if data entity @s SelectedItem{id:"minecraft:book"} run function kitpvp:skill/enchanter/book_hold
# 书收起来就把读书计时归零：下次拿出来从亮着开始，补格节拍也重头算
execute unless data entity @s SelectedItem{id:"minecraft:book"} run scoreboard players set @s kitpvp.ench_book_t 0