# 多伦多矿车点 1：按钮 5963 65 6054 → 潜影盒 5962 64 6054 里填一辆矿车
# 坐标全部来自 region 文件扫描（不依赖创世神选中点）
advancement revoke @s only kitpvp:player/toronto_cart_1
scoreboard players set #cart_cd1 kitpvp.game 10
item replace block 5962 64 6054 container.0 with minecraft:minecart 1
execute at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 0.8 1.2
title @s actionbar {"text":"矿车 +1","color":"white"}
