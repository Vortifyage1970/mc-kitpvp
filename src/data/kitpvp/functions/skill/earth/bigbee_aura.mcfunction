# @s = 大蜜蜂：半径 20 格内的所有玩家和生物持续挂挖掘疲劳 V + 缓慢 III（观战者、躺在地上的尸体不算）
# 每刻跑一次、效果给 1 秒：刷新远比过期快，不会闪
# 不要改成"每 0.5 秒一次 + scores={kitpvp.earth_cd_a=..0} 节流"：分数一旦缺失，那个选择器就完全不匹配，
# 光环会一声不吭地停掉 —— 这个坑已经踩过两次（第一次是召唤时漏给初值，第二次是初值给了但对象选错）
# 玩家一条、非玩家实体一条：@e 那条把玩家排除掉；物品/箭这类不支持效果的实体给了也是空操作
# 两种效果各发一遍：挖掘疲劳 V + 缓慢 III（走速约 55%）
# 挖掘疲劳在 Java 版是双效果（Wiki: Mining Fatigue）：攻速 -10%/级、挖掘速度 ×0.3^min(级,4)
#   ⇒ V 级 = 攻速只剩 50%（玩家挥刀冷却翻倍）、挖掘速度 0.81%（几乎挖不动）
# 只有玩家吃这套：Wiki 明确"所有生物不受挖掘疲劳/急迫影响"（生物没有挥刀冷却那一套）
# 缓慢每级 -15%，没有"正好 50%"的整数级：III = 55%、IV = 40%，这里取更接近的 III
execute as @a[distance=..20,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run effect give @s minecraft:mining_fatigue 1 4 true
execute as @a[distance=..20,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run effect give @s minecraft:slowness 1 2 true
execute as @e[type=!minecraft:player,distance=..20,nbt=!{Health:0.0f}] run effect give @s minecraft:mining_fatigue 1 4 true
execute as @e[type=!minecraft:player,distance=..20,nbt=!{Health:0.0f}] run effect give @s minecraft:slowness 1 2 true
