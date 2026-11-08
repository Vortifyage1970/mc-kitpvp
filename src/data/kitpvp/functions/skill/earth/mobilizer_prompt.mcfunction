# @s = 动员家本体（at 它身上）：15 秒到点，把全场参赛者的"准备"清零、弹绿色按钮、排 5 秒后的结算
# 观战者和尸体既拿不到分数、也收不到这条公告（同 selector）；点按钮走 mobilizer_ready
scoreboard players set @s kitpvp.earth_cd_a 400
# 本轮是「准备」轮：5 秒没点的人挨罚时说「你没准备哦」
scoreboard players set #mob_round kitpvp.game 0
# 召唤者本人不参与动员：先把本体的 earth_owner 抄到假玩家，再把 etid 相同的玩家打上豁免 tag
# 结算时他们已经是 2（已处理），mobilizer_check 不会再罚
tag @a remove kitpvp.mob_exempt
scoreboard players set #mob_own kitpvp.game 0
scoreboard players operation #mob_own kitpvp.game = @s kitpvp.earth_owner
execute if score #mob_own kitpvp.game matches 1.. as @a if score @s kitpvp.etid = #mob_own kitpvp.game run tag @s add kitpvp.mob_exempt
scoreboard players set @a[tag=kitpvp.mob_exempt] kitpvp.mob_ready 2
scoreboard players set @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},tag=!kitpvp.mob_exempt] kitpvp.mob_ready 0
# 召集号（袭击事件那只角）：号一响就是"全班集合"
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},tag=!kitpvp.mob_exempt] at @s run playsound minecraft:event.raid.horn master @s ~ ~ ~ 1.2 1.0
# 山羊角叠在召集号上：角声是"动员"这个动作的招牌（sound.0 = 寻角），比单放袭击号更明确
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},tag=!kitpvp.mob_exempt] at @s run playsound minecraft:item.goat_horn.sound.0 master @s ~ ~ ~ 1.0 1.0
# 5 秒倒计时：每秒一声滴答（append 叠加，不能用 replace，否则前三个会被顶掉）
schedule function kitpvp:skill/earth/mobilizer_beep 20t append
schedule function kitpvp:skill/earth/mobilizer_beep 40t append
schedule function kitpvp:skill/earth/mobilizer_beep 60t append
schedule function kitpvp:skill/earth/mobilizer_beep 80t append
tellraw @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},tag=!kitpvp.mob_exempt] [{"text":"[动员家] ","color":"gray"},{"text":"准备","color":"green","bold":true},{"text":"　","color":"white"},{"text":"[点击准备]","color":"green","clickEvent":{"action":"run_command","value":"/function kitpvp:skill/earth/mobilizer_ready"},"hoverEvent":{"action":"show_text","contents":"5 秒内点一下，否则挨一下瞬间伤害"}}]
schedule function kitpvp:skill/earth/mobilizer_check 100t replace
