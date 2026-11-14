# 多伦多矿车点 5：按钮 5976 65 5966 → 往潜影盒 5976 64 5965 里填一辆矿车
advancement revoke @s only kitpvp:player/toronto_cart_5
item replace block 5976 64 5965 container.0 with minecraft:minecart 1
execute at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 0.8 1.2
