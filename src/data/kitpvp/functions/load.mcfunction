# 数据包加载时执行一次
# 一、游戏规则
gamerule keepInventory true
gamerule doMobSpawning false
gamerule mobGriefing false
gamerule doFireTick false
gamerule doInsomnia false
gamerule naturalRegeneration true
gamerule fallDamage true
gamerule announceAdvancements false
gamerule doImmediateRespawn true
gamerule sendCommandFeedback false
gamerule logAdminCommands false
gamerule commandBlockOutput false

# 二、计分板
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
scoreboard objectives add kitpvp.gapple_used minecraft.used:minecraft.golden_apple
scoreboard objectives add kitpvp.gapple_last dummy "金苹果快照"
scoreboard objectives add kitpvp.tank_used minecraft.used:minecraft.iron_golem_spawn_egg
scoreboard objectives add kitpvp.tank_last dummy "坦克技能快照"
scoreboard objectives add kitpvp.assassin_used minecraft.used:minecraft.enderman_spawn_egg                                             
scoreboard objectives add kitpvp.assassin_last dummy "刺客技能快照"

scoreboard objectives modify kitpvp.kit displayname {"text":"职业","color":"gold"}
scoreboard objectives modify kitpvp.lives displayname {"text":"命数","color":"red"}
scoreboard objectives modify kitpvp.kills displayname {"text":"击杀","color":"aqua"}

scoreboard objectives setdisplay sidebar kitpvp.lives

# 三、队伍
# 设计文档 2.8：无阵营，所有人互为敌人，此处不创建红/蓝阵营队伍。
# 若后续某张地图需要队伍机制，在此追加 team add / team modify。

# 四、标签清理
tag @a remove kitpvp.selected
tag @a remove kitpvp.invincible
tag @a remove kitpvp.sudden_death
tag @a remove kitpvp.in_lobby
tag @a remove kitpvp.spectator
tag @a remove kitpvp.death_immune
tag @a remove kitpvp.keep_inventory
tag @a remove kitpvp.respawn_pending
tag @a remove kitpvp.joined
tag @a remove kitpvp.skill_ready
tag @a remove kitpvp.skill_consume
tag @a remove kitpvp.shield_held
tag @a remove kitpvp.assassin_hidden

# 五、玩家状态归零
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

# 六、全局假玩家数据
scoreboard players set #global kitpvp.map 0
scoreboard players set #global kitpvp.timer 0
scoreboard players set #state kitpvp.game 0
scoreboard players set #survivors kitpvp.game 0
scoreboard players set #tick kitpvp.game 0
scoreboard players set #test kitpvp.game 0

# 七、清空 storage
data remove storage kitpvp:main temp
data remove storage kitpvp:main player

say Kitpvp loaded