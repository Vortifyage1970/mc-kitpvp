# 多伦多矿车点 4：按钮 6037 65 6005 → 往潜影盒 6036 64 6005 里填一辆矿车
advancement revoke @s only kitpvp:player/toronto_cart_4
item replace block 6036 64 6005 container.0 with minecraft:minecart 1
execute at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 0.8 1.2
