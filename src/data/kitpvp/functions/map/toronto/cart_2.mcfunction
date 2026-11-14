# 多伦多矿车点 2：按钮 5987 65 6046 → 往潜影盒 5986 64 6046 里填一辆矿车
advancement revoke @s only kitpvp:player/toronto_cart_2
item replace block 5986 64 6046 container.0 with minecraft:minecart 1
execute at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 0.8 1.2
