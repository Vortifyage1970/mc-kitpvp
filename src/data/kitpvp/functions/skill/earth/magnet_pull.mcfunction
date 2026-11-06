# 磁铁每刻的吸力：掉落物 10 格内 0.7 格/刻（约 14 格/秒）往磁铁身上靠
# 玩家：每 4 刻拉 0.15 格（约 0.75 格/秒）——只有"没在疾跑"的人会被拉。
#   ● 走路 4.3 格/秒 > 0.75，能自己走出去；疾跑（pspd ≥ 600）直接免疫，连拉都不拉。
#   ● 为什么要限频 + 看速度：服务端每刻强改位置会和客户端预测打架，延迟高的人会被反复拽回（跑不出去）；
#     每 4 刻一次、且只拉慢速状态的人，才不会被当成"卡住"。
# 写法要点：先 at 磁铁（定圆心）、再 as 目标（换对象）、再 at @s（回到目标位置）最后 facing 磁铁 feet 定向，^ ^ ^ 才是"朝磁铁"
execute at @e[tag=kitpvp.earth_magnet] as @e[type=minecraft:item,distance=..10] at @s facing entity @e[tag=kitpvp.earth_magnet,limit=1] feet run tp @s ^ ^ ^0.7
execute if score #mag_tick kitpvp.game matches 1 at @e[tag=kitpvp.earth_magnet] as @a[distance=..5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},scores={kitpvp.pspd=..599}] at @s facing entity @e[tag=kitpvp.earth_magnet,limit=1] feet run tp @s ^ ^ ^0.15
