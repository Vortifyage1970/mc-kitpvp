# 结算清理：game/end 用 schedule 在 200 刻后调用（设计文档 2.11 第 3~7 步）
execute as @a run function kitpvp:util/clear_player

# iLsacuL 再清一遍：结算到重置这 10 秒里玩家还可能把新蛋放出来（见 04 §十四）
function kitpvp:game/li_purge

# 非玩家实体：清掉落物 + 我们自己召唤出来的东西，避免误伤画 / 物品展示框 / 地图装饰。
# ⚠ 这一整段必须排在下面"回大厅"之前：玩家一走，地图区块随时可能卸下、实体随之离开世界实体列表，
#   这些 kill 会静默什么也清不掉（驯兽师留在旧地图里的狼就是这么活到下一局的，见 04 §五）。
kill @e[type=item]
# 按 tag 清：清单由 tools/gen_cleanup.py 从所有 summon 与刷怪蛋的 EntityTag 反推生成。
# 新增召唤物只需重跑那个工具（check.py 会拦住"忘了重跑"），不再往这里手写逐条 kill。
# ===== 本分支新增召唤物的顺序敏感清理（守卫先于本体）=====
# 李朱俊泽的 iLsacuL 与自爆苦力怕：按 tag 清，不碰地图原生的猪与苦力怕
kill @e[tag=kitpvp.li_pig]
kill @e[tag=kitpvp.li_bomb]

# 地球的召唤物 / 坐骑 / 炸弹 / 令牌载体：按 tag 清，不碰地图原有的同类生物
# 守卫（木星劈雷 / 动员家喊话）必须排在各自本体前面删：否则本体一消失，守卫就以为它战死了
kill @e[tag=kitpvp.earth_jupiter_guard]
kill @e[tag=kitpvp.earth_threshold_guard]
kill @e[tag=kitpvp.earth_hydrator_guard]
kill @e[tag=kitpvp.earth_capitalist_guard]
kill @e[tag=kitpvp.earth_leaker_clock]
kill @e[tag=kitpvp.earth_twinstar_guard_a]
kill @e[tag=kitpvp.earth_twinstar_guard_b]
kill @e[tag=kitpvp.earth_mobilizer_guard]
kill @e[tag=kitpvp.earth_noteblock_guard]
kill @e[tag=kitpvp.nb_dying]
# 凤凰：守卫先杀（否则它的"本体没了"会当成死亡、留一颗蛋），蛋一起收
kill @e[tag=kitpvp.earth_phoenix_guard]
kill @e[tag=kitpvp.phx_egg]
# 罐子先封口再清场：否则 reset 这一刀会让每只罐子都"碎一次"，白白刷出一堆生灵
kill @e[tag=kitpvp.earth_jar_guard]
# 冥王星的鹦鹉是乘客、不是 earth_minion，得单独清，否则僵尸没了它还挂在半空
kill @e[tag=kitpvp.earth_pluto_parrot]
kill @e[tag=kitpvp.earth_minion]
kill @e[tag=kitpvp.earth_mount]
kill @e[tag=kitpvp.earth_bomb]
kill @e[tag=kitpvp.earth_token]
# 地球魂石的落点标记（隐形 marker，不会自己消失）
kill @e[tag=kitpvp.soul_earth_marker]

# 测试用召唤物（summon/zombie_iron_helmet、summon/zombie_iron_armor）：按 tag 清，不碰地图里的僵尸
kill @e[tag=kitpvp.test_dummy]

# 渔夫魂石的令牌生物（鳕鱼）：按 tag 清，不碰地图里的鱼
kill @e[tag=kitpvp.soul_fisher_token]

# 出生点锚点（重生兜底，见 04 §十一）：每局重建，不能留到下一局地图
kill @e[tag=kitpvp.spawn_anchor]

# 领域展开的雨：load 关了 doWeatherCycle，雨不会自己停 —— domain_end 之外的兜底（见 04 §五）
weather clear

function kitpvp:game/reset_entities

# 下面三类 tag 管不到：载体是按名字召出来的、投掷物是独立实体、动物后代不带 tag
kill @e[type=minecraft:mooshroom,name="开始一场起义"]
kill @e[type=minecraft:husk,name="召集农民"]
kill @e[type=minecraft:potion,nbt={Item:{tag:{KitCivilSpit:1b}}}]
kill @e[type=minecraft:potion,nbt={Item:{tag:{KitCivilDemonSpit:1b}}}]
# 驯兽师（kit 11）放出的动物是本职业的产品，不当场清，改在这里按类型清。
# 必须按类型而不是按 tag：繁殖出的后代不带 tag，认不出来（见 04 §五）。
# tag=!kitpvp.displayitem 护住模板里的装饰动物（见 04 §七）。
kill @e[type=minecraft:wolf,tag=!kitpvp.displayitem]
kill @e[type=minecraft:horse,tag=!kitpvp.displayitem]
kill @e[type=minecraft:parrot,tag=!kitpvp.displayitem]
kill @e[type=minecraft:dolphin,tag=!kitpvp.displayitem]
kill @e[type=minecraft:fox,tag=!kitpvp.displayitem]
kill @e[type=minecraft:frog,tag=!kitpvp.displayitem]
kill @e[type=minecraft:tadpole,tag=!kitpvp.displayitem]
kill @e[type=minecraft:turtle,tag=!kitpvp.displayitem]
kill @e[type=minecraft:goat,tag=!kitpvp.displayitem]
kill @e[type=minecraft:salmon,tag=!kitpvp.displayitem]
# 溺尸：僵尸浸水转化会丢 tag（见 tick/kits_e），结算按类型兜底清
kill @e[type=minecraft:drowned,tag=!kitpvp.displayitem]

# 结算状态复位：与实体清理无关，放在回大厅之前即可
scoreboard players set #mars_active kitpvp.game 0
scoreboard players set #tf_wave kitpvp.game 0
scoreboard players set #tf_wave2 kitpvp.game 0
scoreboard players set #soul_mars_wild_timer kitpvp.game 0
tag @a remove kitpvp.soul_venus_owner
tag @a remove kitpvp.sun_hit
# 汉堡小子：收起 bossbar 与蓄力状态
bossbar set kitpvp:burger_hud_1 players
bossbar set kitpvp:burger_hud_2 players
bossbar set kitpvp:burger_hud_3 players
bossbar set kitpvp:burger_hud_4 players
bossbar set kitpvp:burger_hud_5 players
bossbar set kitpvp:burger_hud_6 players
bossbar set kitpvp:burger_hud_7 players
bossbar set kitpvp:burger_hud_8 players
bossbar set kitpvp:ench_s1 players
bossbar set kitpvp:ench_a1 players
bossbar set kitpvp:ench_s2 players
bossbar set kitpvp:ench_a2 players
bossbar set kitpvp:ench_s3 players
bossbar set kitpvp:ench_a3 players
bossbar set kitpvp:ench_s4 players
bossbar set kitpvp:ench_a4 players
bossbar set kitpvp:ench_s5 players
bossbar set kitpvp:ench_a5 players
bossbar set kitpvp:ench_s6 players
bossbar set kitpvp:ench_a6 players
bossbar set kitpvp:ench_s7 players
bossbar set kitpvp:ench_a7 players
bossbar set kitpvp:ench_s8 players
bossbar set kitpvp:ench_a8 players
scoreboard players set @a kitpvp.burger_charge 0
scoreboard players set @a kitpvp.burger_snd 20
scoreboard players set @a kitpvp.burger_slot 0
scoreboard players set @a kitpvp.burger_announced 0
tag @a remove kitpvp.soul_ep_active
clear @a minecraft:spyglass{KitPortalGunSoul:1b}
bossbar set kitpvp:tep_hud_orange name {"text":"□ 橙门","color":"dark_gray"}
bossbar set kitpvp:tep_hud_orange color white
bossbar set kitpvp:tep_hud_orange value 0
bossbar set kitpvp:tep_hud_blue name {"text":"□ 蓝门","color":"dark_gray"}
bossbar set kitpvp:tep_hud_blue color white
bossbar set kitpvp:tep_hud_blue value 0
bossbar set kitpvp:tep_hud_red name {"text":"□ 红门","color":"dark_gray"}
bossbar set kitpvp:tep_hud_red color white
bossbar set kitpvp:tep_hud_red value 0
bossbar set kitpvp:tep_hud_purple name {"text":"□ 紫门","color":"dark_gray"}
bossbar set kitpvp:tep_hud_purple color white
bossbar set kitpvp:tep_hud_purple value 0

# 领域展开的雨：load 关了 doWeatherCycle，雨不会自己停 —— domain_end 之外的兜底（见 04 §五）
weather clear

# 回大厅（坐标见 lobby/spawn 顶部的坐标注册表）—— 只能在上面把实体清完之后走人
execute as @a run function kitpvp:lobby/enter

function kitpvp:map/restore
# 地图复原会重新载入其区域；再扫一次，避免刚载入的旧狼漏过前面的清理
kill @e[tag=kitpvp.tamer_wolf]

scoreboard players set #survivors kitpvp.game 0
scoreboard players set #state kitpvp.game 0

# 结算末尾补扫驯兽师狼：玩家回大厅后狼会跟着主人传送过去，上面那次 kill 早了一刻（见 04 §五）
scoreboard players set #wolfsweep kitpvp.game 0
schedule function kitpvp:game/wolf_sweep 20t replace

tellraw @a [{"text":"[系统] ","color":"gray","bold":true},{"text":"本局已重置，回到主大厅","color":"gray"}]
execute as @a run function kitpvp:music/winning/stop
