# 多伦多矿车点 2：按钮约 5987 65 6046 → 往潜影盒 5986 64 6046 填一辆矿车
# 两条触发：advancement（item_used_on_block，位置放宽 ±1）+ tick 兜底（按钮 powered 状态）
advancement revoke @s only kitpvp:player/toronto_cart_2
scoreboard players set #cart_cd2 kitpvp.game 10
item replace block 5986 64 6046 container.0 with minecraft:minecart 1
execute at @s run playsound minecraft:block.note_block.bell master @s ~ ~ ~ 0.8 1.2
title @s actionbar {"text":"矿车 +1","color":"white"}
