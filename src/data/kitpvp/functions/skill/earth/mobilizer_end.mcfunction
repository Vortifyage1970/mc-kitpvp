# @s = 动员家的守卫标记：本体已经没了，播红色的"结束准备"，同样给 5 秒
# 这一轮的按钮是"取消准备"（走 mobilizer_cancel）：点了就跳过这次结算，不点照样挨伤害；播完守卫自毁
scoreboard players set @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] kitpvp.mob_ready 0
tellraw @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] [{"text":"[动员家] ","color":"gray"},{"text":"结束准备","color":"red","bold":true},{"text":"　","color":"white"},{"text":"[点击取消准备]","color":"red","clickEvent":{"action":"run_command","value":"/function kitpvp:skill/earth/mobilizer_cancel"},"hoverEvent":{"action":"show_text","contents":"5 秒内点一下取消这次结算，不点会挨一下瞬间伤害"}}]
schedule function kitpvp:skill/earth/mobilizer_check 100t replace
kill @s
