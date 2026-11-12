# 地球·75 凤凰：金剑僵尸 20 血；第一次倒下留下「凤凰蛋」，10 秒后原地复活一次（只复活一次）
# 不打召唤者靠队伍：link 把玩家和 earth_minion_new 放进同一队 earth_N，原版 AI 会跳过队友
summon minecraft:zombie ~ ~ ~ {Tags:["kitpvp.earth_minion","kitpvp.earth_minion_new","kitpvp.earth_phoenix"],CustomName:'{"text":"凤凰","color":"gold"}',CustomNameVisible:1b,PersistenceRequired:1b,CanPickUpLoot:0b,Health:20.0f,Attributes:[{Name:"minecraft:generic.max_health",Base:20.0}],HandItems:[{id:"minecraft:golden_sword",Count:1b},{}]}
# 守卫 marker：每刻贴着本体走，本体倒下时它就停在死亡位置（不用尸体帧，本机实测尸体 1 刻内就没了）
execute as @e[tag=kitpvp.earth_phoenix,tag=kitpvp.earth_minion_new] at @s run summon minecraft:marker ~ ~ ~ {Tags:["kitpvp.earth_phoenix_guard"]}
# 新守卫补 0；已有阶段（1 = 蛋、2 = 复活过）不要覆盖
execute as @e[tag=kitpvp.earth_phoenix_guard] unless score @s kitpvp.phx_stage matches 0.. run scoreboard players set @s kitpvp.phx_stage 0
