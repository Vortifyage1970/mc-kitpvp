# 多伦多矿车点 8：按钮约 6049 65 5962 → 往潜影盒 6049 64 5961 填一辆矿车
# 两条触发：advancement（item_used_on_block，位置放宽 ±1）+ tick 兜底（按钮 powered 状态）
advancement revoke @s only kitpvp:player/toronto_cart_8
scoreboard players set #cart_cd8 kitpvp.game 10
item replace block 6049 64 5961 container.0 with minecraft:minecart 1
execute at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 0.8 1.2
title @s actionbar {"text":"矿车 +1","color":"white"}
