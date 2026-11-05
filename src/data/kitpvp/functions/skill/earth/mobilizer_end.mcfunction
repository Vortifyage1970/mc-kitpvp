# @s = 动员家的守卫标记：本体已经没了，播红色的"结束准备"，同样给 5 秒
# 点与不点的结算和活着时完全一样（共用 mobilizer_check）；播完守卫自毁
scoreboard players set @a[gamemode=!spectator,tag=!kitpvp.spectator,nbt=!{Health:0.0f}] kitpvp.mob_ready 0
tellraw @a [{"text":"[动员家] ","color":"gray"},{"text":"结束准备","color":"red","bold":true},{"text":"　","color":"white"},{"text":"[点击准备]","color":"red","clickEvent":{"action":"run_command","value":"/function kitpvp:skill/earth/mobilizer_ready"},"hoverEvent":{"action":"show_text","contents":"5 秒内点一下，否则挨一下瞬间伤害"}}]
schedule function kitpvp:skill/earth/mobilizer_check 100t replace
kill @s
