# ===== 里·末影人（kit 33）/ 末影人魂石：传送枪 =====
# 状态灯只发给"当前有传送枪的人"（里·末影人 或 魂石生效中）
bossbar set kitpvp:tep_hud_orange players @a[scores={kitpvp.kit=33},tag=!kitpvp.spectator]
bossbar set kitpvp:tep_hud_blue players @a[scores={kitpvp.kit=33},tag=!kitpvp.spectator]
bossbar set kitpvp:tep_hud_red players @a[tag=kitpvp.soul_ep_active,tag=!kitpvp.spectator]
bossbar set kitpvp:tep_hud_purple players @a[tag=kitpvp.soul_ep_active,tag=!kitpvp.spectator]
# 使用分发：里·末影人走橙/蓝，魂石走红/紫（快照只推进一次，防止两边抢同一次右键）
execute as @a[scores={kitpvp.alive=1},tag=!kitpvp.spectator] unless score @s kitpvp.tep_last matches -2147483648.. run scoreboard players operation @s kitpvp.tep_last = @s kitpvp.tep_used
execute as @a[scores={kitpvp.alive=1},tag=!kitpvp.spectator] at @s if score @s kitpvp.tep_used > @s kitpvp.tep_last run function kitpvp:skill/enderman/use_dispatch
# 冷却：里·末影人 2 秒 / 魂石 0.5 秒
execute as @a[scores={kitpvp.tep_cd=1..}] run scoreboard players remove @s kitpvp.tep_cd 1
execute as @a[scores={kitpvp.tep_cd_s=1..}] run scoreboard players remove @s kitpvp.tep_cd_s 1
execute as @a[scores={kitpvp.tep_ready=1..}] run scoreboard players remove @s kitpvp.tep_ready 1
# 末影人魂石：20 秒后收回传送枪并关掉红/紫门
execute as @a[tag=kitpvp.soul_ep_active,scores={kitpvp.soul_ep_timer=1..}] run scoreboard players remove @s kitpvp.soul_ep_timer 1
execute as @a[tag=kitpvp.soul_ep_active,scores={kitpvp.soul_ep_timer=..0}] run function kitpvp:skill/soul/soul_ep_expire
# 门的寿命 / 粒子 / 状态灯
execute as @e[tag=kitpvp.tep_portal] at @s run function kitpvp:skill/enderman/portal_tick
# 玩家穿门（每个人 3 秒免疫；两扇门都齐了才生效）
execute as @e[tag=kitpvp.tep_a] at @s as @a[distance=..1.3,scores={kitpvp.tep_ready=..0},tag=!kitpvp.spectator,tag=!kitpvp.tep_locked] run function kitpvp:skill/enderman/enter_b
execute as @e[tag=kitpvp.tep_b] at @s as @a[distance=..1.3,scores={kitpvp.tep_ready=..0},tag=!kitpvp.spectator,tag=!kitpvp.tep_locked] run function kitpvp:skill/enderman/enter_a
execute as @e[tag=kitpvp.tep_r] at @s as @a[distance=..1.3,scores={kitpvp.tep_ready=..0},tag=!kitpvp.spectator,tag=!kitpvp.tep_locked] run function kitpvp:skill/enderman/enter_p
execute as @e[tag=kitpvp.tep_p] at @s as @a[distance=..1.3,scores={kitpvp.tep_ready=..0},tag=!kitpvp.spectator,tag=!kitpvp.tep_locked] run function kitpvp:skill/enderman/enter_r
# 非玩家实体（召唤物 / 箭 / 掉落物）任何人的门都能穿；装饰类与 marker 不参与
execute as @e[tag=kitpvp.tep_a] at @s as @e[type=!minecraft:player,type=!minecraft:marker,distance=..1.3,tag=!kitpvp.displayitem,tag=!kitpvp.tep_locked] unless score @s kitpvp.tep_ready matches 1.. run function kitpvp:skill/enderman/ent_through_b
execute as @e[tag=kitpvp.tep_b] at @s as @e[type=!minecraft:player,type=!minecraft:marker,distance=..1.3,tag=!kitpvp.displayitem,tag=!kitpvp.tep_locked] unless score @s kitpvp.tep_ready matches 1.. run function kitpvp:skill/enderman/ent_through_a
execute as @e[tag=kitpvp.tep_r] at @s as @e[type=!minecraft:player,type=!minecraft:marker,distance=..1.3,tag=!kitpvp.displayitem,tag=!kitpvp.tep_locked] unless score @s kitpvp.tep_ready matches 1.. run function kitpvp:skill/enderman/ent_through_p
execute as @e[tag=kitpvp.tep_p] at @s as @e[type=!minecraft:player,type=!minecraft:marker,distance=..1.3,tag=!kitpvp.displayitem,tag=!kitpvp.tep_locked] unless score @s kitpvp.tep_ready matches 1.. run function kitpvp:skill/enderman/ent_through_r
# 实体侧的穿门免疫
execute as @e[tag=kitpvp.tep_locked] at @s unless entity @e[tag=kitpvp.tep_portal,distance=..1.7] run tag @s remove kitpvp.tep_locked
execute as @e[type=!minecraft:player,scores={kitpvp.tep_ready=1..}] run scoreboard players remove @s kitpvp.tep_ready 1
execute as @e[tag=kitpvp.bomb_rider,scores={kitpvp.bomb_life=1..}] run scoreboard players remove @s kitpvp.bomb_life 1
execute as @e[tag=kitpvp.bomb_rider,scores={kitpvp.bomb_life=..0}] run kill @s

# 渔夫：无戟计时器，背包无戟持续 160 刻（8 秒）才允许补发，防"投出即补"刷两把
execute as @a[scores={kitpvp.kit=7}] at @s run kill @e[type=minecraft:drowned,distance=..16,name="寻戟"]
scoreboard players add @a[scores={kitpvp.kit=7,kitpvp.alive=1}] kitpvp.fisher_no_tri 1
execute as @a[scores={kitpvp.kit=7,kitpvp.alive=1}] if data entity @s Inventory[{tag:{KitFisherTrident:1b}}] run scoreboard players set @s kitpvp.fisher_no_tri 0

tag @a remove kitpvp.hold_ep_prev
tag @a[tag=kitpvp.hold_ep] add kitpvp.hold_ep_prev
tag @a remove kitpvp.hold_ep
execute as @a if data entity @s SelectedItem.tag.KitEnderPearl run tag @s add kitpvp.hold_ep
execute as @a[scores={kitpvp.kit=8,kitpvp.alive=1},tag=!kitpvp.spectator] if score @s kitpvp.ender_used > @s kitpvp.ender_last run function kitpvp:skill/enderman/cast


# 狼人 / 驯兽师：都用 wolf_spawn_egg（嗅闻令牌 / 狼蛋），各自靠 EntityTag 认自己那只、按 kit 分闸门，互不触发
# 命中被动的 18 刻（0.9 秒）内置冷却
execute as @a[scores={kitpvp.werewolf_hit_cd=1..}] run scoreboard players remove @s kitpvp.werewolf_hit_cd 1

# 农夫（kit 13）：iron_hoe 的 used 覆盖"耕地"与"平A 命中"两种用法（空挥不计），播种、吃面包同理
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=13},tag=!kitpvp.spectator] if score @s kitpvp.farm_used > @s kitpvp.farm_last run function kitpvp:skill/farmer/cultivate
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=13},tag=!kitpvp.spectator] if score @s kitpvp.plant_used > @s kitpvp.plant_last run function kitpvp:skill/farmer/harvest
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=13},tag=!kitpvp.spectator] if score @s kitpvp.bread_used > @s kitpvp.bread_last run function kitpvp:skill/farmer/eat_bread
# 混沌·农锄（kit 45）：同一把铁锄的 used 统计，给农夫同款手感但不产种子 / 小麦
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=45},tag=!kitpvp.spectator] if score @s kitpvp.farm_used > @s kitpvp.farm_last run function kitpvp:kit/chaos_farm
# 里·农夫（kit 34）共享同一套耕地被动（③A）
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=34},tag=!kitpvp.spectator] if score @s kitpvp.farm_used > @s kitpvp.farm_last run function kitpvp:skill/farmer/cultivate
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=34},tag=!kitpvp.spectator] if score @s kitpvp.plant_used > @s kitpvp.plant_last run function kitpvp:skill/farmer/harvest
execute as @a[tag=kitpvp.selected,scores={kitpvp.alive=1,kitpvp.kit=34},tag=!kitpvp.spectator] if score @s kitpvp.bread_used > @s kitpvp.bread_last run function kitpvp:skill/farmer/eat_bread

# 里·农夫（kit 34）：两种蛋都与别的系统共用同种蛋（蘑菇牛=炸弹兵、尸壳=僵尸魂石），各走 dispatch 按名字分流
# 召集农民：上限 1，冷却 60 秒；冷却走完且手上 / 16 格内地上都没有才补回
execute if entity @e[tag=kitpvp.tf_leader] run function kitpvp:skill/tainted_farmer/leader_tick
