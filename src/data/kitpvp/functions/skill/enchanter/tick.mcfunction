# 附魔师计时：每刻 -1，到 0 就强化一次；同时刷新蓄力条
scoreboard players remove @s kitpvp.ench_timer 1
execute if score @s kitpvp.ench_timer matches ..0 run function kitpvp:skill/enchanter/upgrade
function kitpvp:skill/enchanter/bar
