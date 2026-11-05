# @s = 大蜜蜂：半径 20 格内的玩家和生物持续挂挖掘疲劳 V + 缓慢 III
# 不算观战者、躺在地上的尸体，也不算召唤者本人和召唤者的其他召唤物（见下面的 earth_owner/etid 排除）
# 每刻跑一次、效果给 1 秒：刷新远比过期快，不会闪
# 不要改成"每 0.5 秒一次 + scores={kitpvp.earth_cd_a=..0} 节流"：分数一旦缺失，那个选择器就完全不匹配，
# 光环会一声不吭地停掉 —— 这个坑已经踩过两次（第一次是召唤时漏给初值，第二次是初值给了但对象选错）
# 归零再赋值：#bb_owner 每只蜜蜂都要重算；源分缺失时 operation 会失败、留下上一只的旧值
scoreboard players set #bb_owner kitpvp.game 0
scoreboard players operation #bb_owner kitpvp.game = @s kitpvp.earth_owner

# 玩家：etid 与召唤者相同的那个就是主人，跳过
# （魂石召唤路径不写 earth_owner ⇒ #bb_owner = 0，而玩家 etid 是 1..6，谁也匹配不上 ⇒ 照常全吃，这是预期的）
# 挖掘疲劳在 Java 版是双效果（Wiki: Mining Fatigue）：攻速 -10%/级、挖掘速度 ×0.3^min(级,4)
#   ⇒ V 级 = 攻速只剩 50%（玩家挥刀冷却翻倍）、挖掘速度 0.81%（几乎挖不动）
# 只有玩家吃这套：Wiki 明确"所有生物不受挖掘疲劳/急迫影响"（生物没有挥刀冷却那一套）
execute as @a[distance=..20,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #bb_owner kitpvp.game run effect give @s minecraft:mining_fatigue 1 4 true
execute as @a[distance=..20,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #bb_owner kitpvp.game run effect give @s minecraft:slowness 1 2 true

# 非玩家实体：earth_owner 与召唤者相同的（同一玩家放出来的其他召唤物）也跳过，别让光环保着自己的队友狂减速
# 物品/箭这类不支持效果的实体给了也是空操作
execute as @e[type=!minecraft:player,distance=..20,nbt=!{Health:0.0f}] unless score @s kitpvp.earth_owner = #bb_owner kitpvp.game run effect give @s minecraft:mining_fatigue 1 4 true
execute as @e[type=!minecraft:player,distance=..20,nbt=!{Health:0.0f}] unless score @s kitpvp.earth_owner = #bb_owner kitpvp.game run effect give @s minecraft:slowness 1 2 true
