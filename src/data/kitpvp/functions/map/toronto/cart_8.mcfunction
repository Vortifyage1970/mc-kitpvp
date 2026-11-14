# 多伦多矿车点 8：按钮 6049 65 5962 → 往潜影盒 6049 64 5961 里填一辆矿车
advancement revoke @s only kitpvp:player/toronto_cart_8
item replace block 6049 64 5961 container.0 with minecraft:minecart 1
execute at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 0.8 1.2
