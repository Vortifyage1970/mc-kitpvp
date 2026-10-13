gamerule keepInventory true
gamerule doMobSpawning false
gamerule mobGriefing false
gamerule doFireTick false
gamerule doInsomnia false
gamerule doWeatherCycle false
gamerule naturalRegeneration true
gamerule fallDamage true
gamerule announceAdvancements false
gamerule doImmediateRespawn true
gamerule logAdminCommands false
gamerule commandBlockOutput false
#gamerule sendCommandFeedback false

scoreboard objectives add kitpvp.kit dummy "职业"
scoreboard objectives add kitpvp.cd dummy "技能冷却"
scoreboard objectives add kitpvp.cd2 dummy "第二技能冷却"
scoreboard objectives add kitpvp.alive dummy "存活"
scoreboard objectives add kitpvp.lives dummy "命数"
scoreboard objectives add kitpvp.kills dummy "击杀数"
scoreboard objectives add kitpvp.deaths dummy "死亡数"
scoreboard objectives add kitpvp.map dummy "地图"
scoreboard objectives add kitpvp.timer dummy "倒计时"
scoreboard objectives add kitpvp.inv dummy
scoreboard objectives add kitpvp.death_detect deathCount
scoreboard objectives add kitpvp.death_seen dummy
scoreboard objectives add kitpvp.game dummy "游戏状态"
scoreboard objectives add kitpvp.item dummy "物品计数"
scoreboard objectives add kitpvp.tank_used minecraft.used:minecraft.iron_golem_spawn_egg
scoreboard objectives add kitpvp.tank_last dummy "坦克技能快照"
scoreboard objectives add kitpvp.assassin_used minecraft.used:minecraft.enderman_spawn_egg
scoreboard objectives add kitpvp.assassin_last dummy "刺客技能快照"
scoreboard objectives add kitpvp.fisher_used minecraft.used:minecraft.drowned_spawn_egg
scoreboard objectives add kitpvp.fisher_last dummy "渔夫技能快照"
scoreboard objectives add kitpvp.fisher_no_tri dummy "渔夫无戟计时器"
scoreboard objectives add kitpvp.ready_used minecraft.used:minecraft.carrot_on_a_stick
scoreboard objectives add kitpvp.ready_last dummy "大厅准备快照"
scoreboard objectives add kitpvp.tmp dummy
scoreboard objectives add kitpvp.soul_rand dummy "魂石随机数"
scoreboard objectives add kitpvp.soul_bow_timer dummy "魂石弓倒计时"
scoreboard objectives add kitpvp.soul_warrior_used minecraft.used:minecraft.blaze_spawn_egg
scoreboard objectives add kitpvp.soul_archer_used minecraft.used:minecraft.skeleton_spawn_egg
scoreboard objectives add kitpvp.soul_warrior_last dummy "战士魂石快照"
scoreboard objectives add kitpvp.soul_archer_last dummy "弓箭手魂石快照"
scoreboard objectives add kitpvp.arsonist_used minecraft.used:minecraft.splash_potion
scoreboard objectives add kitpvp.arsonist_last dummy
scoreboard objectives add kitpvp.arsonist_ammo dummy
scoreboard objectives add kitpvp.fire_timer dummy
scoreboard objectives add kitpvp.soul_ghost_used minecraft.used:minecraft.vex_spawn_egg
scoreboard objectives add kitpvp.soul_ghost_last dummy "幽灵魂石快照"
scoreboard objectives add kitpvp.soul_ghost_timer dummy "幽灵魂石倒计时"
scoreboard objectives add kitpvp.ghost_minion_cd dummy "阴兵召唤冷却"
scoreboard objectives add kitpvp.tid dummy "队槽编号"
scoreboard objectives add kitpvp.rng dummy
scoreboard objectives add kitpvp.ender_used minecraft.used:minecraft.ender_pearl
scoreboard objectives add kitpvp.ender_last dummy
scoreboard objectives add kitpvp.ender_ammo dummy

# 预留（暂无消费者，刻意保留）：cd2 = 第二技能冷却；item = 物品计数
scoreboard objectives modify kitpvp.kit displayname {"text":"职业","color":"gold"}
scoreboard objectives modify kitpvp.lives displayname {"text":"命数","color":"red"}
scoreboard objectives modify kitpvp.kills displayname {"text":"击杀","color":"aqua"}

scoreboard objectives setdisplay sidebar kitpvp.lives

# 幽灵阴兵队：每位使用者一队，最多 6 队循环复用（队槽由 summon/ghost_minion_pair 惰性分配）
team add ghost_1
team add ghost_2
team add ghost_3
team add ghost_4
team add ghost_5
team add ghost_6

tag @a remove kitpvp.selected
tag @a remove kitpvp.invincible
tag @a remove kitpvp.sudden_death
tag @a remove kitpvp.in_lobby
tag @a remove kitpvp.spectator
tag @a remove kitpvp.death_immune
tag @a remove kitpvp.keep_inventory
tag @a remove kitpvp.respawn_pending
tag @a remove kitpvp.joined
tag @a remove kitpvp.shield_held
tag @a remove kitpvp.assassin_hidden
tag @a remove kitpvp.soul_bow_held
tag @a remove kitpvp.soul_transit
tag @a remove kitpvp.soul_ghost_active
tag @a remove kitpvp.on_pad

scoreboard players set @a kitpvp.kit 0
scoreboard players set @a kitpvp.cd 0
scoreboard players set @a kitpvp.cd2 0
scoreboard players set @a kitpvp.alive 1
scoreboard players set @a kitpvp.lives 3
scoreboard players set @a kitpvp.kills 0
scoreboard players set @a kitpvp.deaths 0
scoreboard players set @a kitpvp.inv 0
scoreboard players set @a kitpvp.death_detect 0
scoreboard players set @a kitpvp.death_seen 0
scoreboard players set @a kitpvp.item 0
scoreboard players set @a kitpvp.tid 0
scoreboard players set @a kitpvp.fisher_no_tri 0

scoreboard players set #global kitpvp.map 0
scoreboard players set #global kitpvp.timer 0
scoreboard players set #state kitpvp.game 0
scoreboard players set #survivors kitpvp.game 0
scoreboard players set #tick kitpvp.game 0
scoreboard players set #test kitpvp.game 0
scoreboard players set #soul_count kitpvp.game 5
scoreboard players set #ghost_tid kitpvp.game 0
scoreboard players set #ghost_need_new kitpvp.game 0

data remove storage kitpvp:main temp
data remove storage kitpvp:main player

# 装饰实体设为无敌，避免被清场命令波及
tag @e[type=minecraft:armor_stand] add kitpvp.displayitem
tag @e[type=minecraft:item_frame] add kitpvp.displayitem
tag @e[type=minecraft:glow_item_frame] add kitpvp.displayitem
tag @e[type=minecraft:painting] add kitpvp.displayitem

execute as @e[tag=kitpvp.displayitem] run data merge entity @s {Invulnerable:1b}

say Kitpvp loaded
