# @s = 大蜜蜂：半径 10 格内的所有玩家和生物持续挂挖掘疲劳 III（观战者、躺在地上的尸体不算）
# 每刻跑一次、效果给 1 秒：刷新远比过期快，不会闪
# 不要改成"每 0.5 秒一次 + scores={kitpvp.earth_cd_a=..0} 节流"：分数一旦缺失，那个选择器就完全不匹配，
# 光环会一声不吭地停掉 —— 这个坑已经踩过两次（第一次是召唤时漏给初值，第二次是初值给了但对象选错）
# 玩家一条、非玩家实体一条：@e 那条把玩家排除掉；物品/箭这类不支持效果的实体给了也是空操作
execute as @a[distance=..10,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run effect give @s minecraft:mining_fatigue 1 2 true
execute as @e[type=!minecraft:player,distance=..10,nbt=!{Health:0.0f}] run effect give @s minecraft:mining_fatigue 1 2 true
