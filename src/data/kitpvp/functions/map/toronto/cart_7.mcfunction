# 多伦多矿车点 7：按钮 6006 65 5977 → 往潜影盒 6006 64 5976 里填一辆矿车
advancement revoke @s only kitpvp:player/toronto_cart_7
item replace block 6006 64 5976 container.0 with minecraft:minecart 1
execute at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 0.8 1.2
