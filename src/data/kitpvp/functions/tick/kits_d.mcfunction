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

# 地球生灵系统（本分支维护，块内容见 tick/earth.mcfunction）
function kitpvp:tick/earth

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
# 陷阱师（kit 77）：两个补货倒计时按每刻走（不要搬进 slow2，否则冷却会变 2 倍长）
execute as @a[scores={kitpvp.trap_hook_cd=1..}] run scoreboard players remove @s kitpvp.trap_hook_cd 1
execute as @a[scores={kitpvp.trap_worm_cd=1..}] run scoreboard players remove @s kitpvp.trap_worm_cd 1
