# @s = 动员家的守卫标记：本体已经没了，播红色的"结束准备"，同样给 5 秒
# 这一轮的按钮是"取消准备"（走 mobilizer_cancel）：点了就跳过这次结算，不点照样挨伤害；播完守卫自毁
# 召唤者本人不参与这一轮（本体死了不该反过来罚召唤者一次）：守卫身上带着本体每刻抄过来的 earth_owner，
# 拿它跟玩家 etid 比，对上就打 mob_exempt；他们已被置成 2（已处理），mobilizer_check 不会再罚
tag @a remove kitpvp.mob_exempt
scoreboard players set #mob_own kitpvp.game 0
scoreboard players operation #mob_own kitpvp.game = @s kitpvp.earth_owner
execute if score #mob_own kitpvp.game matches 1.. as @a if score @s kitpvp.etid = #mob_own kitpvp.game run tag @s add kitpvp.mob_exempt
scoreboard players set @a[tag=kitpvp.mob_exempt] kitpvp.mob_ready 2
scoreboard players set @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},tag=!kitpvp.mob_exempt] kitpvp.mob_ready 0
# 本轮是「取消准备」轮：5 秒没点的人挨罚时说「你没取消准备哦」
scoreboard players set #mob_round kitpvp.game 1
tellraw @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},tag=!kitpvp.mob_exempt] [{"text":"[动员家] ","color":"gray"},{"text":"结束准备","color":"red","bold":true},{"text":"　","color":"white"},{"text":"[点击取消准备]","color":"red","clickEvent":{"action":"run_command","value":"/function kitpvp:skill/earth/mobilizer_cancel"},"hoverEvent":{"action":"show_text","contents":"5 秒内点一下取消这次结算，不点会挨一下瞬间伤害"}}]
# 解散：信标熄灭那声长下行，像收工铃
execute as @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f},tag=!kitpvp.mob_exempt] at @s run playsound minecraft:block.beacon.deactivate master @s ~ ~ ~ 1.0 1.0
# 这一轮也有 5 秒倒计时，节拍器照旧
schedule function kitpvp:skill/earth/mobilizer_beep 20t append
schedule function kitpvp:skill/earth/mobilizer_beep 40t append
schedule function kitpvp:skill/earth/mobilizer_beep 60t append
schedule function kitpvp:skill/earth/mobilizer_beep 80t append
schedule function kitpvp:skill/earth/mobilizer_check 100t replace
kill @s
