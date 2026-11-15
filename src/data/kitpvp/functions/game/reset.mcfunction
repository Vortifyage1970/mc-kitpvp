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
