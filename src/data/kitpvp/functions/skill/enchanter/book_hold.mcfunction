# 主手拿着《神学大全》：减速 30% + 发光 + 翻书声 + 两条进度每刻各涨 1/300
effect give @s minecraft:slowness 1 1 true
effect give @s minecraft:glowing 1 0 true
execute if score @s kitpvp.ench_sw matches ..2 run scoreboard players add @s kitpvp.ench_sw_fill 1
execute if score @s kitpvp.ench_ap matches ..2 run scoreboard players add @s kitpvp.ench_ap_fill 1
execute if score @s kitpvp.ench_sw_fill matches 300.. run function kitpvp:skill/enchanter/fill_sw
execute if score @s kitpvp.ench_ap_fill matches 300.. run function kitpvp:skill/enchanter/fill_ap
scoreboard players add @s kitpvp.ench_book_cd 1
execute if score @s kitpvp.ench_book_cd matches 40.. run function kitpvp:skill/enchanter/book_page
