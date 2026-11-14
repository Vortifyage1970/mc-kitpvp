# 多伦多矿车点 9：按钮 6049 65 5962 → 潜影盒 6049 64 5961 里填一辆矿车
# 坐标全部来自 region 文件扫描（不依赖创世神选中点）
advancement revoke @s only kitpvp:player/toronto_cart_9
scoreboard players set #cart_cd9 kitpvp.game 10
item replace block 6049 64 5961 container.0 with minecraft:minecart 1
execute at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 0.8 1.2
title @s actionbar {"text":"矿车 +1","color":"white"}
