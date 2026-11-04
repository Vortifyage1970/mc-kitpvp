# @s = 大蜜蜂：半径 10 格内的所有玩家挂挖掘疲劳 I（观战者、躺在地上的尸体不算）
# 挖掘疲劳只影响"挖方块"，而原版生物根本不挖方块，所以这里只发给玩家；
# 对自家召唤物发也没意义，反而会盖掉它身上别的状态效果
execute as @a[distance=..10,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run effect give @s minecraft:mining_fatigue 1 0 true

# 下一次补效果 10 刻后（0.5 秒）；给 1 秒，刷新比过期快，站着不动也不会断档
scoreboard players set @s kitpvp.earth_cd_a 10
