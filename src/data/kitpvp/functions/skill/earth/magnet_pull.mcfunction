# 磁铁每刻的吸力：掉落物 10 格内 0.7 格/刻（约 14 格/秒）往磁铁身上靠
# 玩家：每刻 0.2 格（约 4 格/秒），只有"没在疾跑"的人会被拉。
#   ● 为什么是"每刻一点点"而不是"每 4 刻一大步"：tp 是不连续的位移，步长越大越像卡帧；
#     每刻 0.2 格看起来是连续的滑动；走路 4.3 格/秒略高于 4，硬顶着走还能一点点挪出去，疾跑则直接免疫。
#   ● 疾跑（pspd ≥ 600）连拉都不拉：这是给"想跑的人"留的硬保证，不会再出现被吸住逃不掉。
# 写法要点：先 at 磁铁（定圆心）、再 as 目标（换对象）、再 at @s（回到目标位置）最后 facing 磁铁 feet 定向，^ ^ ^ 才是"朝磁铁"
execute at @e[tag=kitpvp.earth_magnet] as @e[type=minecraft:item,distance=..10] at @s facing entity @e[tag=kitpvp.earth_magnet,limit=1] feet run tp @s ^ ^ ^0.7
execute at @e[tag=kitpvp.earth_magnet] as @a[distance=..5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},scores={kitpvp.pspd=..599}] at @s facing entity @e[tag=kitpvp.earth_magnet,limit=1] feet run tp @s ^ ^ ^0.2
