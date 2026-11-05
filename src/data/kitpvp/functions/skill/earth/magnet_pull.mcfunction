# 磁铁每刻的吸力：掉落物 0.35 格/刻往磁铁身上靠（约 7 格/秒），玩家 0.06 格/刻（约 1.2 格/秒）
# 写法要点：先 at 磁铁（定圆心）、再 as 物品（换目标）、再 at @s（回到物品位置）最后 facing 磁铁 feet 定向，^ ^ ^ 才是"朝磁铁"
execute at @e[tag=kitpvp.earth_magnet] as @e[type=minecraft:item,distance=..6] at @s facing entity @e[tag=kitpvp.earth_magnet,limit=1] feet run tp @s ^ ^ ^0.35
execute at @e[tag=kitpvp.earth_magnet] as @a[distance=..3.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] at @s facing entity @e[tag=kitpvp.earth_magnet,limit=1] feet run tp @s ^ ^ ^0.06
