# @s = 变速器：5 格内没有除召唤者以外的玩家就获得速度 VI；有人靠近就改成抗性 II + 缓慢 III + 急迫 I
# 归属靠 earth_owner 比较（link 里写好的队槽编号）：召唤者有自己的 etid，别人一律算"靠近的敌人"
# 先归零：魂石召出来的生灵没有 earth_owner 分，operation 会因源分缺失直接失败，不能留上一只的旧值
scoreboard players set #gb_owner kitpvp.game 0
scoreboard players operation #gb_owner kitpvp.game = @s kitpvp.earth_owner

# 数一数 5 格内除召唤者外还有几个玩家（观战者和躺在地上的尸体不算）
# 数完的分数留在 #gb_enemy 上，游戏里可以 /scoreboard players get #gb_enemy kitpvp.game 直接读来排查
scoreboard players set #gb_enemy kitpvp.game 0
execute as @a[distance=..5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] unless score @s kitpvp.etid = #gb_owner kitpvp.game run scoreboard players add #gb_enemy kitpvp.game 1

# 空旷：极速（速度 VI），同时清掉"变慢"的两条与急迫，否则两种状态会叠在一起
execute if score #gb_enemy kitpvp.game matches 0 run effect give @s minecraft:speed 1 5 true
execute if score #gb_enemy kitpvp.game matches 0 run effect clear @s minecraft:resistance
execute if score #gb_enemy kitpvp.game matches 0 run effect clear @s minecraft:slowness
execute if score #gb_enemy kitpvp.game matches 0 run effect clear @s minecraft:haste

# 有人：变肉变慢 + 急迫 I，并撤掉速度，否则靠速度 VI 抵消缓慢 III 根本慢不下来
# 急迫只在"身边有玩家"时给（人的设计口径）：落单时只有速度
# 召唤者自己走近不触发这一段（有人数已经把召唤者排除了），要试效果得让第二个玩家靠近
execute if score #gb_enemy kitpvp.game matches 1.. run effect give @s minecraft:resistance 1 1 true
execute if score #gb_enemy kitpvp.game matches 1.. run effect give @s minecraft:slowness 1 2 true
execute if score #gb_enemy kitpvp.game matches 1.. run effect give @s minecraft:haste 1 0 true
execute if score #gb_enemy kitpvp.game matches 1.. run effect clear @s minecraft:speed

# 下一次判定 10 刻后（0.5 秒）；效果给 1 秒，刷新比过期快，切换时不会留空档
scoreboard players set @s kitpvp.earth_cd_a 10
