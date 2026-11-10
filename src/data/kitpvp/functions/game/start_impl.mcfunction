# 开局实现（人数检查在 game/start）；subtitle 必须在 title 之前设
clear @a minecraft:carrot_on_a_stick{KitLobbyRod:1b}
clear @a minecraft:stone_sword{KitLobbySword:1b}
tag @a remove kitpvp.ready
tag @a remove kitpvp.ready_pending

execute unless score #global kitpvp.map matches 1.. run function kitpvp:map/random

scoreboard players set #state kitpvp.game 1
scoreboard players set #global kitpvp.timer 480

tag @a[tag=kitpvp.selected] remove kitpvp.spectator
tag @a[tag=kitpvp.selected] remove kitpvp.in_lobby
tag @a[tag=kitpvp.selected] remove kitpvp.sudden_death
tag @a[tag=kitpvp.selected] remove kitpvp.respawn_pending

gamemode survival @a[tag=kitpvp.selected]

function kitpvp:map/distribute

# 地图规定的天光：君士坦丁堡正午定格、地球白天定格（结算时 game/end 把 doDaylightCycle 放回 true）
execute if score #global kitpvp.map matches 10 run gamerule doDaylightCycle false
execute if score #global kitpvp.map matches 10 run time set noon
execute if score #global kitpvp.map matches 7 run gamerule doDaylightCycle false
execute if score #global kitpvp.map matches 7 run time set day
execute if score #global kitpvp.map matches 1 run time set 11000
execute if score #global kitpvp.map matches 2 run time set day
execute if score #global kitpvp.map matches 3 run time set night
execute if score #global kitpvp.map matches 9 run time set night

# 队槽每局重建：先退出上局残留的队伍，再清空槽位
# 否则上局留下的编号会让两名同职业玩家落进同一队，召唤物从此互不攻击（见 04 §十四）
# 地球 / 幽灵 / 炮台 / 里·驯兽师四套队槽各自独立，而一名玩家只可能在其中一套里，一次 team leave @a 就够
team leave @a
scoreboard players set @a kitpvp.etid 0
scoreboard players set @a kitpvp.tid 0
scoreboard players set @a kitpvp.ttid 0
scoreboard players set @a kitpvp.ttamer_tid 0
scoreboard players set #eslot kitpvp.game 0
scoreboard players set #ghost_tid kitpvp.game 0
scoreboard players set #ttamer kitpvp.game 0
scoreboard players set #hacker_prev kitpvp.game 0

# 上一局留在没加载区块里的驯兽师狼：本局开头按 tag 再扫一次（见 04 §五）
kill @e[tag=kitpvp.tamer_wolf]

# 金星：舔狗跟着进图（原版自动跟随依赖区块 tick，跨区块传送后不保证）
execute as @a[scores={kitpvp.kit=67}] at @s run function kitpvp:skill/venus/dog_follow

# 冥王星：鹦鹉跟着进图（同样是跨区块传送，必须当刻拉一把），并顺手回满血
execute as @a[scores={kitpvp.kit=76}] at @s run function kitpvp:skill/pluto/enter_map

execute as @a[tag=kitpvp.selected] run function kitpvp:player/invincible

title @a[tag=kitpvp.selected] times 5 40 10
title @a[tag=kitpvp.selected] title {"text":"游戏开始","color":"gold","bold":true}
playsound minecraft:entity.ender_dragon.growl master @a[tag=kitpvp.selected] ~ ~ ~ 1 1.2

# 启动全局计时器循环（8 分钟后进入突然死亡）
schedule function kitpvp:game/timer_tick 20t replace
