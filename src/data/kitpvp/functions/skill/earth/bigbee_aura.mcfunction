# @s = 大蜜蜂：半径 10 格内的所有玩家和生物挂挖掘疲劳 I（观战者、躺在地上的尸体不算）
# 玩家一条、非玩家实体一条：@e 那条把玩家排除掉，剩下的活体全吃；物品/箭这类不支持效果的实体给了也是空操作
execute as @a[distance=..10,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run effect give @s minecraft:mining_fatigue 1 0 true
execute as @e[type=!minecraft:player,distance=..10,nbt=!{Health:0.0f}] run effect give @s minecraft:mining_fatigue 1 0 true

# 下一次补效果 10 刻后（0.5 秒）；给 1 秒，刷新比过期快，站着不动也不会断档
scoreboard players set @s kitpvp.earth_cd_a 10
