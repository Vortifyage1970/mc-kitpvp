# 多伦多矿车点 2：按钮 5972 65 6004 → 潜影盒 5971 64 6004 里填一辆矿车
# 坐标全部来自 region 文件扫描（不依赖创世神选中点）
advancement revoke @s only kitpvp:player/toronto_cart_2
scoreboard players set #cart_cd2 kitpvp.game 10
item replace block 5971 64 6004 container.0 with minecraft:minecart 1
execute at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 0.8 1.2
title @s actionbar {"text":"矿车 +1","color":"white"}
