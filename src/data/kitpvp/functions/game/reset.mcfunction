# 结算清理：game/end 用 schedule 在 200 刻后调用（设计文档 2.11 第 3~7 步）
execute as @a run function kitpvp:util/clear_player

# iLsacuL 再清一遍：结算到重置这 10 秒里玩家还可能把新蛋放出来（见 04 §十四）
function kitpvp:game/li_purge

# 非玩家实体：清掉落物 + 我们自己召唤出来的东西，避免误伤画 / 物品展示框 / 地图装饰。
# 约定：每新增一种召唤物，就在这里追加一行对应的 kill（A2）。
# ⚠ 这一整段必须排在下面"回大厅"之前：玩家一走，地图区块随时可能卸下、实体随之离开世界实体列表，
#   这些 kill 会静默什么也清不掉（驯兽师留在旧地图里的狼就是这么活到下一局的，见 04 §五）。
kill @e[type=item]
kill @e[tag=kitpvp.ghost_minion]
kill @e[tag=kitpvp.turret]
kill @e[tag=kitpvp.token_turret]
kill @e[tag=kitpvp.token_core]
kill @e[tag=kitpvp.werewolf_token]
# 驯兽师狼蛋给狼打了专属 tag；明确清掉召唤狼，下面按动物类型清理同时覆盖它们的后代
kill @e[tag=kitpvp.tamer_wolf]

# 里·渔夫的两个令牌生物（发光鱿鱼 / 鱿鱼）：按 tag 清，不碰地图里的鱿鱼
kill @e[tag=kitpvp.tainted_fisher_blue_token]
kill @e[tag=kitpvp.tainted_fisher_domain_token]

# 太阳的两个令牌生物（蜜蜂 / 蝙蝠）：按 tag 清，不碰地图里的蜜蜂与蝙蝠
kill @e[tag=kitpvp.sun_flare_token]
kill @e[tag=kitpvp.sun_spot_token]

# 里·驯兽师的召唤物（tag kitpvp.tt_minion）与残留的基础生物（tag kitpvp.tt_spawn）：按 tag 清，不碰地图原生的同类生物
kill @e[tag=kitpvp.tt_minion]
kill @e[tag=kitpvp.tt_spawn]

# 金星的舔狗 / 令牌基础生物 / 自爆苦力怕：按 tag 清，不碰地图原生的狼与苦力怕
kill @e[tag=kitpvp.venus_dog]
kill @e[tag=kitpvp.venus_token]
kill @e[tag=kitpvp.venus_bomb_creeper]

# 冥王星的鹦鹉分身：按 tag 清
kill @e[tag=kitpvp.pluto_parrot]

# 文明小子的令牌基础生物 / 还在飞的两种口水（一次性的投掷物，落地前也必须清干净）
kill @e[tag=kitpvp.civil_token]
kill @e[type=minecraft:potion,nbt={Item:{tag:{KitCivilSpit:1b}}}]
kill @e[type=minecraft:potion,nbt={Item:{tag:{KitCivilDemonSpit:1b}}}]

# 李朱俊泽的 iLsacuL 与自爆苦力怕：按 tag 清，不碰地图原生的猪与苦力怕
kill @e[tag=kitpvp.li_pig]
# 新四种魂石的残留：落点 marker / 驯兽师的狗与动物 / 金星的舔狗与自爆苦力怕
kill @e[tag=kitpvp.soul_tamer_marker]
kill @e[tag=kitpvp.soul_sun_marker]
kill @e[tag=kitpvp.soul_tamer_wolf]
kill @e[tag=kitpvp.soul_tamer_animal]
kill @e[tag=kitpvp.soul_venus_dog]
kill @e[tag=kitpvp.soul_venus_bomb]
tag @a remove kitpvp.soul_venus_owner
kill @e[tag=kitpvp.li_bomb]

# 地球的召唤物 / 坐骑 / 炸弹 / 令牌载体：按 tag 清，不碰地图原有的同类生物
# 从「测试」分支搬来的召唤物：守卫 / 时钟必须排在本体前面删（本体一消失，守卫会以为它战死）
kill @e[tag=kitpvp.earth_threshold_guard]
kill @e[tag=kitpvp.earth_hydrator_guard]
kill @e[tag=kitpvp.earth_leaker_clock]
kill @e[tag=kitpvp.earth_minecart_boat]
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
