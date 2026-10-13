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

execute as @a[tag=kitpvp.selected] run function kitpvp:player/invincible

title @a[tag=kitpvp.selected] times 5 40 10
title @a[tag=kitpvp.selected] title {"text":"游戏开始","color":"gold","bold":true}
playsound minecraft:entity.ender_dragon.growl master @a[tag=kitpvp.selected] ~ ~ ~ 1 1.2

# 启动全局计时器循环（8 分钟后进入突然死亡）
schedule function kitpvp:game/timer_tick 20t replace
