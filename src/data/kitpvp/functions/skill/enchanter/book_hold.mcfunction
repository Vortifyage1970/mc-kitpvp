# 主手拿着《神学大全》：减速 30% + 发光 + 翻书声 + 每 300 刻给两条各 +1 点
effect give @s minecraft:slowness 1 1 true
effect give @s minecraft:glowing 1 0 true
scoreboard players add @s kitpvp.ench_book_t 1
scoreboard players add @s kitpvp.ench_book_cd 1
execute if score @s kitpvp.ench_book_t matches 300.. run function kitpvp:skill/enchanter/book_gain
execute if score @s kitpvp.ench_book_cd matches 40.. run function kitpvp:skill/enchanter/book_page
