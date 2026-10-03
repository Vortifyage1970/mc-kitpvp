# ===== 将 @s 清到"干净初始状态" =====
# 复用方：
#   1) 选职业（每个职业函数的第一行）
#   2) 主大厅 [初始化我] 按钮 -> kitpvp:lobby/reset_self
#   3) 结算重置 -> execute as @a run function kitpvp:util/clear_player
#
# 约定：本函数会清掉 kitpvp.kit。
# 这不是 bug——选职业入口是"具体职业函数"，函数自己知道要写成几号，
# 所以清完立刻由职业函数写回。不存在"待选 id 丢失"的问题。
#
# 保留的会话性 tag（刻意不清）：
#   kitpvp.joined    清了会导致根 tick 重复触发 player/join
#   kitpvp.in_lobby  位置状态；on_death 用它判定"大厅死亡不计"
#
# 本函数不负责：
#   位置 / 传送        由调用方负责
#   spawnpoint         由 game/start 或 map/distribute 写入
#   着火状态           1.20.1 无 /extinguish（该命令 1.20.5 才有）
#   饱食度 / 饱和度    1.20.1 无直接命令可复位

# --- 一、背包 / 效果 / 经验 ---
clear @s
effect clear @s
xp set @s 0 points
xp set @s 0 levels

# --- 二、下坐骑 ---
ride @s dismount

# --- 三、游戏性 tag 清理 ---
tag @s remove kitpvp.selected
tag @s remove kitpvp.invincible
tag @s remove kitpvp.sudden_death
tag @s remove kitpvp.spectator
tag @s remove kitpvp.respawn_pending
tag @s remove kitpvp.death_immune
tag @s remove kitpvp.keep_inventory
tag @s remove kitpvp.skill_ready
tag @s remove kitpvp.skill_consume
tag @s remove kitpvp.shield_held
tag @s remove kitpvp.assassin_hidden
tag @s remove kitpvp.ready
tag @s remove kitpvp.ready_pending

# --- 四、分数归零（含 kit）---
scoreboard players set @s kitpvp.kit 0
scoreboard players set @s kitpvp.cd 0
scoreboard players set @s kitpvp.cd2 0
scoreboard players set @s kitpvp.inv 0
scoreboard players operation @s kitpvp.death_seen = @s kitpvp.death_detect
scoreboard players set @s kitpvp.item 0
scoreboard players set @s kitpvp.lives 3
scoreboard players set @s kitpvp.kills 0
scoreboard players set @s kitpvp.deaths 0
scoreboard players set @s kitpvp.alive 1
scoreboard players operation @s kitpvp.gapple_last = @s kitpvp.gapple_used
# 坦克统计快照：清场时把 last 推到 used，避免清场后下一刻误判
scoreboard players operation @s kitpvp.tank_last = @s kitpvp.tank_used
scoreboard players operation @s kitpvp.assassin_last = @s kitpvp.assassin_used
# 主大厅准备钓竿快照：同上
scoreboard players operation @s kitpvp.ready_last = @s kitpvp.ready_used
scoreboard players set @s kitpvp.soul_rand 0
scoreboard players set @s kitpvp.soul_bow_timer 0
scoreboard players operation @s kitpvp.soul_warrior_last = @s kitpvp.soul_warrior_used
scoreboard players operation @s kitpvp.soul_archer_last = @s kitpvp.soul_archer_used
tag @s remove kitpvp.soul_bow_held

# --- 五、属性复位到原版默认 ---
attribute @s minecraft:generic.max_health base set 20
attribute @s minecraft:generic.movement_speed base set 0.1
attribute @s minecraft:generic.attack_damage base set 1
attribute @s minecraft:generic.attack_speed base set 4
attribute @s minecraft:generic.knockback_resistance base set 0
attribute @s minecraft:generic.armor base set 0
attribute @s minecraft:generic.armor_toughness base set 0

# --- 六、回大厅模式 + 回满血 ---
gamemode adventure @s
# 1.20.1 无 /heal，用 instant_health 代替，足以回满
effect give @s minecraft:instant_health 1 5 true