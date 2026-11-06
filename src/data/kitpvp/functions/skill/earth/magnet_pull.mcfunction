# 磁铁每刻的吸力：只吸掉落物，10 格内 0.7 格/刻（约 14 格/秒）往磁铁身上靠
# ★ 不再牵引玩家：服务端每刻/每 4 刻强制改位置都会和客户端预测打架，延迟高的玩家会被反复拽回（表现为"跑不出去"）。
#   要做"引力井"就换个做法（比如给附近玩家缓慢），别再拿 tp 拽人。
# 写法要点：先 at 磁铁（定圆心）、再 as 物品（换目标）、再 at @s（回到物品位置）最后 facing 磁铁 feet 定向，^ ^ ^ 才是"朝磁铁"
execute at @e[tag=kitpvp.earth_magnet] as @e[type=minecraft:item,distance=..10] at @s facing entity @e[tag=kitpvp.earth_magnet,limit=1] feet run tp @s ^ ^ ^0.7
