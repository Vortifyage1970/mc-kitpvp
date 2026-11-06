# 磁铁每刻的吸力：掉落物 10 格内 0.7 格/刻（约 14 格/秒）往磁铁身上靠
# 玩家：只吸"站在原地的人"（pspd ≤ 199），每刻 0.15 格（约 3 格/秒）。
#   ● 为什么不再吸走起来的人：移动玩家只能靠服务端 tp 改位置，这是"纠正"，不是"施力"；
#     房主 0 延迟看不出问题，别人一旦在跑，服务端每刻纠正就会把他钉在原地（表现为卡住、跑不动）。
#     现在只要动起来（走路 pspd ≈ 467）就完全不干预，谁都卡不住。
#   ● 想给人"被拽住"的压迫感，别用 tp：改成给 4 格内玩家缓慢 I/II（状态效果走的是客户端预测，不打架）。
# 写法要点：先 at 磁铁（定圆心）、再 as 目标（换对象）、再 at @s（回到目标位置）最后 facing 磁铁 feet 定向，^ ^ ^ 才是"朝磁铁"
execute at @e[tag=kitpvp.earth_magnet] as @e[type=minecraft:item,distance=..10] at @s facing entity @e[tag=kitpvp.earth_magnet,limit=1] feet run tp @s ^ ^ ^0.7
execute at @e[tag=kitpvp.earth_magnet] as @a[distance=..4,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},scores={kitpvp.pspd=..199}] at @s facing entity @e[tag=kitpvp.earth_magnet,limit=1] feet run tp @s ^ ^ ^0.15
