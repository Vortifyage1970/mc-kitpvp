# @s = 保洁员：每 15 秒扫一次地，8 格内的掉落物 + 载具（矿车/船）全部消失
scoreboard players set @s kitpvp.earth_cd_a 300

# —— 掉落物按"件"数，不按"堆"数：一堆 64 个木头算 64 件（上一版只报堆数，丢 3 个牛排=1 堆，所以显示"1"）
scoreboard players set #jan kitpvp.game 0

# —— 载具另算：矿车六种 + 船两种（boat 含竹筏，chest_boat 就是运输船/运输竹筏）
scoreboard players set #jan_v kitpvp.game 0

# —— 播报（0 件 0 载具就完全不吭声）
execute if score #jan kitpvp.game matches 1.. run tellraw @a [{"text":"[保洁员]","color":"white","bold":true},{"text":" 收走了 ","color":"gray"},{"score":{"name":"#jan","objective":"kitpvp.game"},"color":"yellow"},{"text":" 件掉落物。","color":"gray"}]
execute if score #jan_v kitpvp.game matches 1.. run tellraw @a [{"text":"[保洁员]","color":"white","bold":true},{"text":" 拖走了 ","color":"gray"},{"score":{"name":"#jan_v","objective":"kitpvp.game"},"color":"gold"},{"text":" 个载具。","color":"gray"}]

# —— 清场：和计数用同一批选择器，保证"报几件就清几件"
