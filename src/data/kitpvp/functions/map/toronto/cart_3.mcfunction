# 多伦多矿车点 3：按钮 6050 65 6054 → 往潜影盒 6049 64 6054 里填一辆矿车
advancement revoke @s only kitpvp:player/toronto_cart_3
item replace block 6049 64 6054 container.0 with minecraft:minecart 1
execute at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 0.8 1.2
