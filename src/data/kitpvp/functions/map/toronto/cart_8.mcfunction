# 多伦多矿车点 8：按钮 6037 65 6005 → 潜影盒 6036 64 6005 里填一辆矿车
# 坐标全部来自 region 文件扫描（不依赖创世神选中点）
advancement revoke @s only kitpvp:player/toronto_cart_8
scoreboard players set #cart_cd8 kitpvp.game 10
item replace block 6036 64 6005 container.0 with minecraft:minecart 1
execute at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 0.8 1.2
title @s actionbar {"text":"矿车 +1","color":"white"}
