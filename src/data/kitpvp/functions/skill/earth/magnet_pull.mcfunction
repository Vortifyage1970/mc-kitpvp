# 磁铁每刻的吸力：10 格内的掉落物 0.7 格/刻（约 14 格/秒），6 格内的玩家 0.03 格/刻（约 0.6 格/秒）
# ★ 玩家那条别调大：服务端每刻 tp 会和客户端预测打架（人会"被粘住"、走不动），0.12 那版就是这个毛病；
#   0.03 走路（4.3 格/秒）随便就能挣脱，站着不动才会被慢慢拖过去 —— 这才是"资源点"该有的手感
# 写法要点：先 at 磁铁（定圆心）、再 as 物品（换目标）、再 at @s（回到物品位置）最后 facing 磁铁 feet 定向，^ ^ ^ 才是"朝磁铁"
execute at @e[tag=kitpvp.earth_magnet] as @e[type=minecraft:item,distance=..10] at @s facing entity @e[tag=kitpvp.earth_magnet,limit=1] feet run tp @s ^ ^ ^0.7
execute at @e[tag=kitpvp.earth_magnet] as @a[distance=..6,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s facing entity @e[tag=kitpvp.earth_magnet,limit=1] feet run tp @s ^ ^ ^0.03
