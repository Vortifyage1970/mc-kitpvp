# ===== 文明小子（kit 87）=====
# 技能组 1：喷溅口水。喷溅药水在本服有三个来源（纵火狂 / 药剂师 / 本职业），
# 靠"上一刻手持的是不是自己的口水"分流；last 无条件推进（见 05 §12）。
tag @a remove kitpvp.hold_cb_prev
tag @a[tag=kitpvp.hold_cb] add kitpvp.hold_cb_prev
tag @a[scores={kitpvp.kit=87}] remove kitpvp.hold_cb
execute as @a[scores={kitpvp.kit=87}] if data entity @s SelectedItem.tag.KitCivilSpit run tag @s add kitpvp.hold_cb
execute as @a[scores={kitpvp.kit=87}] if data entity @s SelectedItem.tag.KitCivilDemonSpit run tag @s add kitpvp.hold_cb
execute as @a[scores={kitpvp.kit=87}] if data entity @s Inventory[{Slot:40b,tag:{KitCivilSpit:1b}}] run tag @s add kitpvp.hold_cb
execute as @a[scores={kitpvp.kit=87}] if data entity @s Inventory[{Slot:40b,tag:{KitCivilDemonSpit:1b}}] run tag @s add kitpvp.hold_cb
execute as @a[scores={kitpvp.kit=87,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.civil_used > @s kitpvp.civil_last run function kitpvp:skill/civil/cast

# 口水效果由自定义药水数据交给原版处理；此处只处理落地音效与虚空清理
execute as @e[type=minecraft:potion,nbt={Item:{tag:{KitCivilSpit:1b}}},tag=!kitpvp.civil_spit_burst] at @s unless block ~ ~-0.5 ~ air unless block ~ ~-0.5 ~ cave_air unless block ~ ~-0.5 ~ void_air run function kitpvp:skill/civil/spit_burst
execute as @e[type=minecraft:potion,nbt={Item:{tag:{KitCivilDemonSpit:1b}}},tag=!kitpvp.civil_demon_burst] at @s unless block ~ ~-0.5 ~ air unless block ~ ~-0.5 ~ cave_air unless block ~ ~-0.5 ~ void_air run function kitpvp:skill/civil/demon_spit_burst
kill @e[type=minecraft:potion,nbt={Item:{tag:{KitCivilSpit:1b}}},y=-100,dy=100]
kill @e[type=minecraft:potion,nbt={Item:{tag:{KitCivilDemonSpit:1b}}},y=-100,dy=100]

# 技能组 2：恶魔形态（cd2 180 秒 / 持续 60 秒）
execute as @a[scores={kitpvp.kit=87,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.civil_demon_used > @s kitpvp.civil_demon_last run function kitpvp:skill/civil/demon_cast
execute as @a[tag=kitpvp.civil_demon,scores={kitpvp.civil_demon_timer=1..}] run scoreboard players remove @s kitpvp.civil_demon_timer 1
execute as @a[tag=kitpvp.civil_demon,scores={kitpvp.civil_demon_timer=..0}] at @s run function kitpvp:skill/civil/demon_end
# 恶魔形态令牌补货（cd2 走完才发）
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=87,kitpvp.alive=1,kitpvp.cd2=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/civil/refill_demon

# 令牌刷出来的基础生物兜底清
kill @e[tag=kitpvp.civil_token]

# ===== 李朱俊泽（kit 88）=====
# 召唤入口：猪蛋在本服只有本职业发，仍然按 used > last 认"真的放出了一只"
execute as @a[scores={kitpvp.kit=88,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.li_pig_used > @s kitpvp.li_pig_last run function kitpvp:skill/li_zhujunze/cast
# 内联循环计时器：李朱俊泽在局内，或地球召出的 iLsacuL 存在时就一直走；两者都没有则归零
scoreboard players set #li_active kitpvp.game 0
execute if score #state kitpvp.game matches 1 if entity @a[scores={kitpvp.kit=88}] run scoreboard players set #li_active kitpvp.game 1
# 场上有任何一只 iLsacuL（地球召的、魂石召的、还有它们的 200 血复制体）循环就继续跑 ——
# 以前这里只认 earth_ilsacul，于是魂石的 20 秒计时一结束、而剩下的复制体明明还站着，循环就冻住了：
# 复制阶段还在扫 @e[tag=li_pig]，可 timer 已经不再被调用（2026-11-10 车主报的"过一个循环就停"）。
execute if score #state kitpvp.game matches 1 if entity @e[tag=kitpvp.li_pig] run scoreboard players set #li_active kitpvp.game 1
execute if score #li_active kitpvp.game matches 1 run function kitpvp:skill/li_zhujunze/timer
execute if score #li_active kitpvp.game matches 0 run scoreboard players set #litimer kitpvp.game 0
execute if score #li_active kitpvp.game matches 0 run scoreboard players set #liapoc kitpvp.game 0

# ===== 地球（kit 68）=====
# 技能：召唤生灵。蛋在本服只有本职业发，仍然按 used > last 认"真的放出了一枚"。
# 山羊蛋刷出来的山羊是纯载体，cast 里当场清掉。
execute as @a[scores={kitpvp.kit=68,kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.earth_used > @s kitpvp.earth_last run function kitpvp:skill/earth/cast

# 召唤物计时器（都挂在实体上）
execute as @e[scores={kitpvp.earth_cd_a=1..}] run scoreboard players remove @s kitpvp.earth_cd_a 1

# ---- 地球召唤物：从「测试」分支搬过来的 8 只（2026-11-10）----
# 守卫式死亡触发：把隐形 marker 拖到本体身上，本体一没就干活（顺序不能反：先拖再判）
execute as @e[tag=kitpvp.earth_threshold] at @s run tp @e[tag=kitpvp.earth_threshold_guard,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_threshold_guard] at @s unless entity @e[tag=kitpvp.earth_threshold,distance=..3] run function kitpvp:skill/earth/threshold_death
execute as @e[tag=kitpvp.earth_hydrator] at @s run tp @e[tag=kitpvp.earth_hydrator_guard,distance=..5,limit=1,sort=nearest] ~ ~ ~
execute as @e[tag=kitpvp.earth_hydrator_guard] at @s unless entity @e[tag=kitpvp.earth_hydrator,distance=..3] run function kitpvp:skill/earth/hydrator_death
# 泄密者：15 秒一次的播报（时钟是独立 marker）
execute as @e[tag=kitpvp.earth_leaker_clock,scores={kitpvp.leaker_cd=1..}] run scoreboard players remove @s kitpvp.leaker_cd 1
execute as @e[tag=kitpvp.earth_leaker_clock,scores={kitpvp.leaker_cd=..0}] at @s run function kitpvp:skill/earth/leaker_tick
# 滑冰者：铺雪 / 滑行音效合成一条每刻扫描（两个计时在函数内部自己判断，省一遍 @e 过滤）
execute as @e[tag=kitpvp.earth_skater] at @s run function kitpvp:skill/earth/skater_tick
# 井盖：2.5 格内有人就弹开
execute as @e[tag=kitpvp.earth_manhole,scores={kitpvp.earth_cd_a=..0}] at @s if entity @a[distance=..2.5,gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] run function kitpvp:skill/earth/manhole_pop
# 矿车：40 秒寿命，到点连船带蠹虫自毁；蠹虫没了就顺手清掉孤儿船
execute as @e[tag=kitpvp.earth_minecart,scores={kitpvp.minecart_life=1..}] run scoreboard players remove @s kitpvp.minecart_life 1
execute as @e[tag=kitpvp.earth_minecart,scores={kitpvp.minecart_life=..0},tag=!kitpvp.earth_minecart_stopped] at @s run function kitpvp:skill/earth/minecart_stop
execute as @e[type=minecraft:boat,tag=kitpvp.earth_minecart_boat] at @s unless entity @e[type=minecraft:silverfish,tag=kitpvp.earth_minecart,distance=..2] run kill @s
# Dominion：出场计时（只用来决定"出场那阵烟"还要不要补，不控制烟花本身）
execute as @e[tag=kitpvp.earth_dominion] run scoreboard players add @s kitpvp.dominion_age 1
execute as @e[tag=kitpvp.earth_sheep,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/sheep_aura
execute as @e[tag=kitpvp.earth_disruptor,scores={kitpvp.earth_cd_a=..0}] at @s run function kitpvp:skill/earth/disrupt
# 超凡升天：60 刻后开始漂浮，300 刻后离场（tag 区分两个阶段）
execute as @e[tag=kitpvp.earth_levitate,scores={kitpvp.earth_lev=1..}] run scoreboard players remove @s kitpvp.earth_lev 1
execute as @e[tag=kitpvp.earth_levitate,tag=!kitpvp.earth_lifted,scores={kitpvp.earth_lev=..0}] at @s run function kitpvp:skill/earth/levitate_start
execute as @e[tag=kitpvp.earth_levitate,tag=kitpvp.earth_lifted,scores={kitpvp.earth_lev=..0}] at @s run function kitpvp:skill/earth/levitate_end
# 跟踪炸弹的小僵尸 6 秒后清除
execute as @e[tag=kitpvp.earth_tracker,scores={kitpvp.earth_life=1..}] run scoreboard players remove @s kitpvp.earth_life 1
execute as @e[tag=kitpvp.earth_tracker,scores={kitpvp.earth_life=..0}] run kill @s

# 湿海绵船夫：只有还坐在自己的筏上时才有抗性提升 V，下筏 / 沉船就撤掉
execute as @e[tag=kitpvp.earth_boatman1] at @s unless entity @e[tag=kitpvp.earth_boat1,distance=..2] run effect clear @s minecraft:resistance

# 干海绵船夫：船被打掉（2 格内找不到自己的船）→ 一次性给 15 秒力量 II
execute as @e[tag=kitpvp.earth_boatman2,tag=!kitpvp.earth_powered,tag=!kitpvp.earth_power_armed] at @s unless entity @e[tag=kitpvp.earth_boat2,distance=..2] run tag @s add kitpvp.earth_power_armed
execute as @e[tag=kitpvp.earth_power_armed] run effect give @s minecraft:strength 15 1 true
execute as @e[tag=kitpvp.earth_power_armed] run tag @s add kitpvp.earth_powered
execute as @e[tag=kitpvp.earth_power_armed] run tag @s remove kitpvp.earth_power_armed

# 随从：本体（小僵尸）一死，驮着它的悦灵也不该继续飘——2 格内找不到自己的小僵尸就清掉
execute as @e[type=minecraft:allay,tag=kitpvp.earth_retainer_mount] at @s unless entity @e[type=minecraft:zombie,tag=kitpvp.earth_retainer,distance=..2] run kill @s

# 可疑草丛：落地 2 秒后才算蹲好；敌人贴身（半径 1）或血量掉到 20 以下（被打到）就爆开
# 贴身判定按玩家逐个查（见 skill/earth/grass_probe）：主人自己踩上去不算，草丛可以顶着主人走
# popped 是防重入：kill 的移除在下一刻，同一刻几条判定会各调一次 pop，直接变好几只
execute as @e[tag=kitpvp.earth_grass,tag=!kitpvp.earth_grass_popped,scores={kitpvp.earth_grass_arm=1..}] run scoreboard players remove @s kitpvp.earth_grass_arm 1
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.alive=1},tag=!kitpvp.spectator] at @s run function kitpvp:skill/earth/grass_probe
execute as @e[tag=kitpvp.earth_grass,tag=!kitpvp.earth_grass_popped] store result score @s kitpvp.tmp run data get entity @s Health
execute as @e[tag=kitpvp.earth_grass,tag=!kitpvp.earth_grass_popped,scores={kitpvp.tmp=..19}] at @s run function kitpvp:summon/earth_grass_pop

# 黑客死亡播报：本刻存活数比上一刻少 => 刚有黑客被干掉（同一刻掉两只只播一次，够用）
scoreboard players set #hacker_count kitpvp.game 0
execute as @e[tag=kitpvp.earth_hacker] run scoreboard players add #hacker_count kitpvp.game 1
execute if score #state kitpvp.game matches 1 if score #hacker_count kitpvp.game < #hacker_prev kitpvp.game run function kitpvp:summon/earth_hacker_death
scoreboard players operation #hacker_prev kitpvp.game = #hacker_count kitpvp.game

# 召唤蛋补货（自愈口径，同太阳）
execute if score #state kitpvp.game matches 1 as @a[scores={kitpvp.kit=68,kitpvp.alive=1,kitpvp.cd=..0},tag=!kitpvp.spectator] at @s run function kitpvp:skill/earth/auto
# 山羊载体兜底清
kill @e[tag=kitpvp.earth_token]

# ===== 炸弹兵（kit 19）/ 里·炸弹兵（kit 32）=====
# 五套令牌共用蘑菇牛蛋，蛋刷出的隐形载体只当落点标记：dispatch 按载体 tag 分流，cast 在它的位置放炸弹再清掉

# 补货：cd 走完才发；满仓时什么都不发、cd 停在 0，等下一枚用掉再起计

# 补货计时：表四个（小/大/假/跟踪）+ 里三个（大/跟踪/核弹），各算各的、用掉才起计
execute as @a[scores={kitpvp.bomb_small_cd=1..}] run scoreboard players remove @s kitpvp.bomb_small_cd 1
execute as @a[scores={kitpvp.bomb_big_cd=1..}] run scoreboard players remove @s kitpvp.bomb_big_cd 1
execute as @a[scores={kitpvp.bomb_fake_cd=1..}] run scoreboard players remove @s kitpvp.bomb_fake_cd 1
execute as @a[scores={kitpvp.bomb_track_cd=1..}] run scoreboard players remove @s kitpvp.bomb_track_cd 1
execute as @a[scores={kitpvp.bomb_nuke_cd=1..}] run scoreboard players remove @s kitpvp.bomb_nuke_cd 1

# 末影人魂石：用掉蛋就发一把魂石·传送枪

# ===== 混沌战士（kit 45）：弓 / 弩 / 三叉戟的"使用"各扣一次 =====
execute as @a[scores={kitpvp.kit=45}] unless score @s kitpvp.chaos_bow_last matches -2147483648.. run scoreboard players operation @s kitpvp.chaos_bow_last = @s kitpvp.chaos_bow_used
execute as @a[scores={kitpvp.kit=45}] unless score @s kitpvp.chaos_tri_last matches -2147483648.. run scoreboard players operation @s kitpvp.chaos_tri_last = @s kitpvp.chaos_tri_used
execute as @a[scores={kitpvp.kit=45}] if score @s kitpvp.chaos_tri_used > @s kitpvp.chaos_tri_last run function kitpvp:kit/chaos_shot_tri
# 三叉戟待结算：飞完（或超时 6 秒）才扣次数
execute as @a[scores={kitpvp.chaos_tri_pending=1}] run scoreboard players add @s kitpvp.chaos_tri_wait 1
execute as @a[scores={kitpvp.chaos_tri_pending=1}] at @s unless entity @e[type=minecraft:trident,nbt={Trident:{tag:{ChaosBlade:1b}}},distance=..96] run function kitpvp:kit/chaos_tri_settle
execute as @a[scores={kitpvp.chaos_tri_wait=120..}] run function kitpvp:kit/chaos_tri_settle
execute as @a[scores={kitpvp.kit=45},nbt={SelectedItem:{id:"minecraft:bow"}}] run function kitpvp:kit/chaos_arrow_check
execute as @a[scores={kitpvp.kit=45},nbt={SelectedItem:{id:"minecraft:crossbow"}}] run function kitpvp:kit/chaos_xbow_check
# 混沌重铸：右键令牌（统计 spyglass 使用）→ 清武器并随机重铸，冷却 30 秒
# 混沌·金斧：持有时隐身（effect 类被动只能走 tick）
execute as @a[scores={kitpvp.kit=45}] at @s if data entity @s SelectedItem.tag.ChaosInvisible run effect give @s minecraft:invisibility 1 0 true
