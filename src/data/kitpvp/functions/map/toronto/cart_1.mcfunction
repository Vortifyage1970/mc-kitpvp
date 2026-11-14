# 多伦多矿车点 1：按钮 6023 65 6046 → 往潜影盒 6022 64 6046 里填一辆矿车
advancement revoke @s only kitpvp:player/toronto_cart_1
item replace block 6022 64 6046 container.0 with minecraft:minecart 1
execute at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 0.8 1.2
